codeunit 50007 "FacturaE Recibida Mgt."
{
    var
        VendorVatErr: Label 'El proveedor debe coincidir con el CIF del emisor.';
        BackupConfirmQst: Label '¿Desea importar un XML FacturaE recibido?';
        ProcessCanceledErr: Label 'Proceso cancelado por el usuario.';
        NoBackupDataMsg: Label 'No se importó ningún XML FacturaE.';
        BackupImportedMsg: Label 'XML FacturaE importado correctamente.';
        RejectConfirmQst: Label '¿Desea rechazar esta factura?';
        InvoiceRejectedMsg: Label 'Factura rechazada correctamente.';
        PurchaseInvoiceCreatedMsg: Label 'Se ha generado la factura %1. Puede proceder a su revisión.';
        NoDocumentToOpenMsg: Label 'No hay ningún documento o URL disponible para abrir.';
        MissingLineAccountErr: Label 'La línea FacturaE %1 no tiene Cuenta NAV. Informe la cuenta contable antes de generar la factura de compra.';
        RejectReasonPrefixLbl: Label 'RECHAZO', Locked = true;

    procedure LookupVendor(var FacturaE: Record "Cabecera FacturaE Recibida"): Boolean
    var
        Vendor: Record Vendor;
        VendorList: Page "Vendor List";
    begin
        FilterVendorByVat(Vendor, FacturaE."Emisor CIF");
        VendorList.SetTableView(Vendor);
        VendorList.LookupMode(true);
        if VendorList.RunModal() <> Action::LookupOK then
            exit(false);

        VendorList.GetRecord(Vendor);
        FacturaE.Validate("Proveedor NAV", Vendor."No.");
        exit(true);
    end;

    procedure ValidateVendor(FacturaE: Record "Cabecera FacturaE Recibida")
    var
        Vendor: Record Vendor;
    begin
        if FacturaE."Proveedor NAV" = '' then
            exit;

        FilterVendorByVat(Vendor, FacturaE."Emisor CIF");
        Vendor.SetRange("No.", FacturaE."Proveedor NAV");
        if Vendor.IsEmpty() then
            Error(VendorVatErr);
    end;

    procedure LookupRejectReason(var FacturaE: Record "Cabecera FacturaE Recibida"): Boolean
    var
        StandardText: Record "Standard Text";
        StandardTexts: Page "Standard Text Codes";
    begin
        StandardText.SetFilter(Code, '%1', RejectReasonPrefixLbl + '*');
        StandardTexts.SetTableView(StandardText);
        StandardTexts.LookupMode(true);
        if StandardTexts.RunModal() <> Action::LookupOK then
            exit(false);

        StandardTexts.GetRecord(StandardText);
        FacturaE.Validate("Descripcion Rechazo", '');
        FacturaE.Validate("Motivo Rechazo", StandardText.Code);
        SetRejectDescription(FacturaE, StandardText.Code);
        exit(true);
    end;

    procedure LookupExpediente(var FacturaE: Record "Cabecera FacturaE Recibida"): Boolean
    var
        IsHandled: Boolean;
        LookupAccepted: Boolean;
    begin
        OnLookupExpediente(FacturaE, LookupAccepted, IsHandled);
        if IsHandled then
            exit(LookupAccepted);

        exit(false);
    end;

    procedure UpdateExpedienteOnLines(FacturaE: Record "Cabecera FacturaE Recibida")
    var
        LineaFacturaE: Record "Linea FacturaE Recibida";
    begin
        LineaFacturaE.SetRange("ID Factura", FacturaE."ID Plataforma");
        if LineaFacturaE.FindSet(true) then
            repeat
                LineaFacturaE.Validate(Expediente, FacturaE.Expediente);
                LineaFacturaE.Validate("Shortcut Dimension 1 Code", FacturaE."Shortcut Dimension 1 Code");
                LineaFacturaE.Validate("Shortcut Dimension 2 Code", FacturaE."Shortcut Dimension 2 Code");
                LineaFacturaE.Validate("Dimension Set ID", FacturaE."Dimension Set ID");
                LineaFacturaE.Modify(true);
            until LineaFacturaE.Next() = 0;

        OnAfterUpdateExpedienteOnLines(FacturaE);
    end;

    procedure UpdateLoteOnLines(FacturaE: Record "Cabecera FacturaE Recibida")
    var
        LineaFacturaE: Record "Linea FacturaE Recibida";
    begin
        LineaFacturaE.SetRange("ID Factura", FacturaE."ID Plataforma");
        if LineaFacturaE.FindSet(true) then
            repeat
                LineaFacturaE.Validate(Lote, FacturaE.Lote);
                LineaFacturaE.Modify(true);
            until LineaFacturaE.Next() = 0;

        OnAfterUpdateLoteOnLines(FacturaE);
    end;

    procedure DeleteRelatedLines(FacturaE: Record "Cabecera FacturaE Recibida")
    var
        LineaFacturaE: Record "Linea FacturaE Recibida";
        TasaFacturaE: Record "Tasa FacturaE Recibida";
    begin
        LineaFacturaE.SetRange("ID Factura", FacturaE."ID Plataforma");
        LineaFacturaE.DeleteAll(true);

        TasaFacturaE.SetRange("ID Factura", FacturaE."ID Plataforma");
        TasaFacturaE.DeleteAll(true);

        OnAfterDeleteRelatedLines(FacturaE);
    end;

    procedure CheckInvoiceAmount(PurchaseHeader: Record "Purchase Header"; FacturaE: Record "Cabecera FacturaE Recibida")
    var
        PurchaseLine: Record "Purchase Line";
        PurchaseAmount: Decimal;
        IsHandled: Boolean;
    begin
        OnBeforeCheckInvoiceAmount(PurchaseHeader, FacturaE, IsHandled);
        if IsHandled then
            exit;

        PurchaseLine.SetRange("Document Type", PurchaseHeader."Document Type");
        PurchaseLine.SetRange("Document No.", PurchaseHeader."No.");
        PurchaseLine.CalcSums("Amount Including VAT");
        PurchaseAmount := PurchaseLine."Amount Including VAT";

        if Abs(PurchaseAmount - FacturaE."Total Pagar") > 0.01 then
            Error('El importe de la factura (%1) no coincide con el total FacturaE (%2).', PurchaseAmount, FacturaE."Total Pagar");
    end;

    procedure ImportBackupData(): Boolean
    var
        Imported: Boolean;
        IsHandled: Boolean;
    begin
        OnImportBackupData(Imported, IsHandled);
        if IsHandled then
            exit(Imported);

        exit(ImportFacturaEXmlFromUpload());
    end;

    procedure ImportFacturaEXmlFromUpload(): Boolean
    var
        FacturaEXmlImport: Codeunit "FacturaE XML Import";
        XmlInStream: InStream;
        FileName: Text;
    begin
        if not UploadIntoStream('Seleccione el XML FacturaE', '', 'XML (*.xml)|*.xml', FileName, XmlInStream) then
            exit(false);

        FacturaEXmlImport.ImportXml(XmlInStream, FileName);
        exit(true);
    end;

    procedure ImportBackupDataWithConfirmation()
    var
        DataImported: Boolean;
    begin
        if not Confirm(BackupConfirmQst) then
            Error(ProcessCanceledErr);

        DataImported := ImportBackupData();
        if DataImported then
            Message(BackupImportedMsg)
        else
            Message(NoBackupDataMsg);
    end;

    procedure OpenExternalDocument(FileName: Text[250]; OpenContainer: Boolean)
    var
        UrlToOpen: Text;
    begin
        UrlToOpen := BuildUrlToOpen(FileName, OpenContainer);
        if UrlToOpen = '' then begin
            Message(NoDocumentToOpenMsg);
            exit;
        end;

        Hyperlink(UrlToOpen);
    end;

    procedure ApproveEInvoice(var FacturaE: Record "Cabecera FacturaE Recibida")
    var
        IsHandled: Boolean;
    begin
        OnBeforeApproveEInvoice(FacturaE, IsHandled);
        if IsHandled then
            exit;

        FacturaE.TestField(Rechazada, false);
        FacturaE."Approval Status" := FacturaE."Approval Status"::Approved;
        FacturaE.Modify(true);

        OnAfterApproveEInvoice(FacturaE);
    end;

    procedure RegisterInvoice(var FacturaE: Record "Cabecera FacturaE Recibida"; PostDocument: Boolean)
    var
        PurchaseHeader: Record "Purchase Header";
        IsHandled: Boolean;
    begin
        OnBeforeRegisterInvoice(FacturaE, PostDocument, PurchaseHeader, IsHandled);
        if not IsHandled then begin
            CreatePurchaseHeaderFromFacturaE(FacturaE, PurchaseHeader);
            CreatePurchaseLinesFromFacturaE(FacturaE, PurchaseHeader);
        end;

        if PostDocument then
            Codeunit.Run(Codeunit::"Purch.-Post (Yes/No)", PurchaseHeader)
        else
            Message(PurchaseInvoiceCreatedMsg, PurchaseHeader."No.");

        OnAfterRegisterInvoice(FacturaE, PurchaseHeader, PostDocument);
    end;

    procedure RejectInvoiceWithConfirmation(var FacturaE: Record "Cabecera FacturaE Recibida")
    begin
        if not Confirm(RejectConfirmQst) then
            Error(ProcessCanceledErr);

        RejectInvoice(FacturaE);
        Message(InvoiceRejectedMsg);
    end;

    procedure RejectInvoice(var FacturaE: Record "Cabecera FacturaE Recibida")
    var
        IsHandled: Boolean;
    begin
        OnBeforeRejectInvoice(FacturaE, IsHandled);
        if IsHandled then
            exit;

        FacturaE.CalcFields("Documento en Curso", "Documento Registrado");
        FacturaE.TestField("Documento en Curso", '');
        FacturaE.TestField("Documento Registrado", '');
        FacturaE.Rechazada := true;
        FacturaE."Approval Status" := FacturaE."Approval Status"::Rejected;
        FacturaE.Modify(true);

        OnAfterRejectInvoice(FacturaE);
    end;

    procedure ViewInvoice(var FacturaE: Record "Cabecera FacturaE Recibida")
    var
        PurchInvHeader: Record "Purch. Inv. Header";
    begin
        if FacturaE."Documento PDF" <> '' then begin
            OpenExternalDocument(FacturaE."Documento PDF", false);
            exit;
        end;

        FacturaE.CalcFields("Documento Registrado");
        if (FacturaE."Documento Registrado" <> '') and PurchInvHeader.Get(FacturaE."Documento Registrado") then begin
            Page.Run(Page::"Posted Purchase Invoice", PurchInvHeader);
            exit;
        end;

        if FacturaE."Documento Factura" <> '' then begin
            OpenExternalDocument(FacturaE."Documento Factura", false);
            exit;
        end;

        Message(NoDocumentToOpenMsg);
    end;

    procedure MoveToNextState(var FacturaE: Record "Cabecera FacturaE Recibida")
    var
        IsHandled: Boolean;
    begin
        OnBeforeMoveToNextState(FacturaE, IsHandled);
        if IsHandled then
            exit;

        case FacturaE."Approval Status" of
            FacturaE."Approval Status"::Blank:
                FacturaE."Approval Status" := FacturaE."Approval Status"::"Approval Pending";
            FacturaE."Approval Status"::"Approval Pending":
                FacturaE."Approval Status" := FacturaE."Approval Status"::Approved;
            FacturaE."Approval Status"::Approved:
                exit;
            FacturaE."Approval Status"::Rejected:
                begin
                    FacturaE.Rechazada := false;
                    FacturaE."Approval Status" := FacturaE."Approval Status"::"Approval Pending";
                end;
        end;
        FacturaE.Modify(true);

        OnAfterMoveToNextState(FacturaE);
    end;

    procedure ReturnToReceived(var FacturaE: Record "Cabecera FacturaE Recibida")
    var
        IsHandled: Boolean;
    begin
        OnBeforeReturnToReceived(FacturaE, IsHandled);
        if IsHandled then
            exit;

        FacturaE.Rechazada := false;
        FacturaE."Approval Status" := FacturaE."Approval Status"::Blank;
        FacturaE.Modify(true);

        OnAfterReturnToReceived(FacturaE);
    end;

    procedure LinesExist(InvoicePlatformId: Text[50]): Boolean
    var
        LineaFacturaE: Record "Linea FacturaE Recibida";
    begin
        LineaFacturaE.SetRange("ID Factura", InvoicePlatformId);
        exit(not LineaFacturaE.IsEmpty());
    end;

    procedure UpdateAllLineDim(InvoicePlatformId: Text[50]; NewParentDimSetID: Integer; OldParentDimSetID: Integer)
    var
        LineaFacturaE: Record "Linea FacturaE Recibida";
        DimMgt: Codeunit DimensionManagement;
        NewDimSetID: Integer;
    begin
        if NewParentDimSetID = OldParentDimSetID then
            exit;

        LineaFacturaE.SetRange("ID Factura", InvoicePlatformId);
        if LineaFacturaE.FindSet(true) then
            repeat
                NewDimSetID := DimMgt.GetDeltaDimSetID(LineaFacturaE."Dimension Set ID", NewParentDimSetID, OldParentDimSetID);
                if LineaFacturaE."Dimension Set ID" <> NewDimSetID then begin
                    LineaFacturaE."Dimension Set ID" := NewDimSetID;
                    DimMgt.UpdateGlobalDimFromDimSetID(LineaFacturaE."Dimension Set ID", LineaFacturaE."Shortcut Dimension 1 Code", LineaFacturaE."Shortcut Dimension 2 Code");
                    LineaFacturaE.Modify(true);
                end;
            until LineaFacturaE.Next() = 0;
    end;

    local procedure CreatePurchaseHeaderFromFacturaE(var FacturaE: Record "Cabecera FacturaE Recibida"; var PurchaseHeader: Record "Purchase Header")
    begin
        FacturaE.TestField("Proveedor NAV");
        FacturaE.CalcFields("Documento en Curso", "Documento Registrado");
        FacturaE.TestField("Documento en Curso", '');
        FacturaE.TestField("Documento Registrado", '');

        PurchaseHeader.Init();
        PurchaseHeader."Document Type" := PurchaseHeader."Document Type"::Invoice;
        PurchaseHeader.Insert(true);
        PurchaseHeader.Validate("Buy-from Vendor No.", FacturaE."Proveedor NAV");
        PurchaseHeader.Validate("Vendor Invoice No.", CopyStr(FacturaE."Numero", 1, MaxStrLen(PurchaseHeader."Vendor Invoice No.")));
        PurchaseHeader.Validate("Document Date", FacturaE."Fecha Devengo");
        PurchaseHeader.Validate("Posting Date", WorkDate());
        PurchaseHeader."ID Plataforma FacturaE" := FacturaE."ID Plataforma";
        PurchaseHeader."Numero FacturaE" := FacturaE."Numero";
        PurchaseHeader.Modify(true);
    end;

    local procedure CreatePurchaseLinesFromFacturaE(FacturaE: Record "Cabecera FacturaE Recibida"; PurchaseHeader: Record "Purchase Header")
    var
        LineaFacturaE: Record "Linea FacturaE Recibida";
        PurchaseLine: Record "Purchase Line";
        NextLineNo: Integer;
    begin
        LineaFacturaE.SetRange("ID Factura", FacturaE."ID Plataforma");
        if not LineaFacturaE.FindSet() then
            exit;

        repeat
            NextLineNo += 10000;
            PurchaseLine.Init();
            PurchaseLine."Document Type" := PurchaseHeader."Document Type";
            PurchaseLine."Document No." := PurchaseHeader."No.";
            PurchaseLine."Line No." := NextLineNo;
            PurchaseLine.Insert(true);
            if LineaFacturaE."Cuenta NAV" = '' then
                Error(MissingLineAccountErr, LineaFacturaE."Line No.");

            PurchaseLine.Validate(Type, PurchaseLine.Type::"G/L Account");
            PurchaseLine.Validate("No.", LineaFacturaE."Cuenta NAV");
            PurchaseLine.Validate(Description, LineaFacturaE.Description);
            if LineaFacturaE.Quantity = 0 then
                PurchaseLine.Validate(Quantity, 1)
            else
                PurchaseLine.Validate(Quantity, LineaFacturaE.Quantity);
            if LineaFacturaE."Unit Price" <> 0 then
                PurchaseLine.Validate("Direct Unit Cost", LineaFacturaE."Unit Price")
            else
                PurchaseLine.Validate("Direct Unit Cost", LineaFacturaE.Amount);
            PurchaseLine."Dimension Set ID" := LineaFacturaE."Dimension Set ID";
            PurchaseLine."Shortcut Dimension 1 Code" := LineaFacturaE."Shortcut Dimension 1 Code";
            PurchaseLine."Shortcut Dimension 2 Code" := LineaFacturaE."Shortcut Dimension 2 Code";
            PurchaseLine.Modify(true);
        until LineaFacturaE.Next() = 0;
    end;

    local procedure BuildUrlToOpen(FileName: Text[250]; OpenContainer: Boolean): Text
    var
        Url: Text;
        LastSlashPosition: Integer;
    begin
        Url := FileName;
        if Url = '' then
            exit('');

        if OpenContainer then begin
            LastSlashPosition := GetLastSlashPosition(Url);
            if LastSlashPosition > 0 then
                Url := CopyStr(Url, 1, LastSlashPosition);
        end;

        exit(Url);
    end;

    local procedure GetLastSlashPosition(Value: Text): Integer
    var
        Position: Integer;
        LastPosition: Integer;
        RemainingText: Text;
    begin
        RemainingText := Value;
        while StrPos(RemainingText, '/') > 0 do begin
            Position += StrPos(RemainingText, '/');
            LastPosition := Position;
            RemainingText := CopyStr(Value, Position + 1);
        end;

        exit(LastPosition);
    end;

    local procedure FilterVendorByVat(var Vendor: Record Vendor; VatRegistrationNo: Text[20])
    begin
        Vendor.Reset();
        Vendor.SetFilter("VAT Registration No.", '%1|%2', VatRegistrationNo, RemoveCountryFromVat(VatRegistrationNo));
    end;

    local procedure RemoveCountryFromVat(VatRegistrationNo: Text[20]): Text[20]
    var
        CountryPrefix: Text[2];
    begin
        if StrLen(VatRegistrationNo) <= 2 then
            exit(VatRegistrationNo);

        CountryPrefix := UpperCase(CopyStr(VatRegistrationNo, 1, 2));
        case CountryPrefix of
            'DE', 'ES', 'FR', 'GB', 'IT', 'PT':
                exit(CopyStr(VatRegistrationNo, 3));
        end;

        exit(VatRegistrationNo);
    end;

    local procedure SetRejectDescription(var FacturaE: Record "Cabecera FacturaE Recibida"; StandardTextCode: Code[10])
    var
        ExtendedTextLine: Record "Extended Text Line";
    begin
        AppendRejectDescription(FacturaE, ExtendedTextLine, StandardTextCode, 'ESP');
        if HasExtendedText(StandardTextCode, 'EUS') then begin
            AppendDescriptionText(FacturaE, ' / ');
            AppendRejectDescription(FacturaE, ExtendedTextLine, StandardTextCode, 'EUS');
        end;
    end;

    local procedure AppendRejectDescription(
        var FacturaE: Record "Cabecera FacturaE Recibida";
        var ExtendedTextLine: Record "Extended Text Line";
        StandardTextCode: Code[10];
        LanguageCode: Code[10])
    begin
        ExtendedTextLine.Reset();
        ExtendedTextLine.SetRange("Table Name", ExtendedTextLine."Table Name"::"Standard Text");
        ExtendedTextLine.SetRange("No.", StandardTextCode);
        ExtendedTextLine.SetRange("Language Code", LanguageCode);
        ExtendedTextLine.SetRange("Text No.", 1);
        if ExtendedTextLine.FindSet() then
            repeat
                AppendDescriptionText(FacturaE, ExtendedTextLine.Text);
            until ExtendedTextLine.Next() = 0;
    end;

    local procedure HasExtendedText(StandardTextCode: Code[10]; LanguageCode: Code[10]): Boolean
    var
        ExtendedTextLine: Record "Extended Text Line";
    begin
        ExtendedTextLine.SetRange("Table Name", ExtendedTextLine."Table Name"::"Standard Text");
        ExtendedTextLine.SetRange("No.", StandardTextCode);
        ExtendedTextLine.SetRange("Language Code", LanguageCode);
        ExtendedTextLine.SetRange("Text No.", 1);
        exit(not ExtendedTextLine.IsEmpty());
    end;

    local procedure AppendDescriptionText(var FacturaE: Record "Cabecera FacturaE Recibida"; TextToAppend: Text)
    begin
        FacturaE.Validate(
            "Descripcion Rechazo",
            CopyStr(FacturaE."Descripcion Rechazo" + TextToAppend, 1, MaxStrLen(FacturaE."Descripcion Rechazo")));
    end;

    [IntegrationEvent(false, false)]
    local procedure OnLookupExpediente(var FacturaE: Record "Cabecera FacturaE Recibida"; var LookupAccepted: Boolean; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterUpdateExpedienteOnLines(FacturaE: Record "Cabecera FacturaE Recibida")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterUpdateLoteOnLines(FacturaE: Record "Cabecera FacturaE Recibida")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterDeleteRelatedLines(FacturaE: Record "Cabecera FacturaE Recibida")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeCheckInvoiceAmount(
        PurchaseHeader: Record "Purchase Header";
        FacturaE: Record "Cabecera FacturaE Recibida";
        var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnImportBackupData(var Imported: Boolean; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeApproveEInvoice(var FacturaE: Record "Cabecera FacturaE Recibida"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterApproveEInvoice(FacturaE: Record "Cabecera FacturaE Recibida")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeRegisterInvoice(
        var FacturaE: Record "Cabecera FacturaE Recibida";
        PostDocument: Boolean;
        var PurchaseHeader: Record "Purchase Header";
        var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterRegisterInvoice(
        var FacturaE: Record "Cabecera FacturaE Recibida";
        PurchaseHeader: Record "Purchase Header";
        PostDocument: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeRejectInvoice(var FacturaE: Record "Cabecera FacturaE Recibida"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterRejectInvoice(FacturaE: Record "Cabecera FacturaE Recibida")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeMoveToNextState(var FacturaE: Record "Cabecera FacturaE Recibida"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterMoveToNextState(FacturaE: Record "Cabecera FacturaE Recibida")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeReturnToReceived(var FacturaE: Record "Cabecera FacturaE Recibida"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterReturnToReceived(FacturaE: Record "Cabecera FacturaE Recibida")
    begin
    end;
}
