codeunit 50007 "FacturaE Recibida Mgt."
{
    Access = Internal;

    var
        VendorVatErr: Label 'El proveedor debe coincidir con el CIF del emisor.';
        CloudIntegrationErr: Label 'La integración heredada %1 usaba Automation, File local, SQL directo o DOM de cliente de NAV 2016. En Business Central SaaS debe implementarse mediante HttpClient, XmlDocument/JsonObject, SecretText/Isolated Storage y archivos/medios en la nube.';
        BackupConfirmQst: Label '¿Desea importar los datos que estén pendientes en la base de datos de respaldo?';
        ProcessCanceledErr: Label 'Proceso cancelado por el usuario.';
        NoBackupDataMsg: Label 'No existe ningún registro sin traspasar en la Base de Datos de Respaldo.';
        BackupImportedMsg: Label 'Datos importados correctamente.';
        RejectConfirmQst: Label '¿Desea rechazar esta factura?';
        InvoiceRejectedMsg: Label 'Factura rechazada correctamente.';
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
    begin
        exit(NotImplemented('Lookup de expedientes/lotes'));
    end;

    procedure UpdateExpedienteOnLines(FacturaE: Record "Cabecera FacturaE Recibida")
    begin
        NotImplemented('actualización de expediente en líneas FacturaE');
    end;

    procedure UpdateLoteOnLines(FacturaE: Record "Cabecera FacturaE Recibida")
    begin
        NotImplemented('actualización de lote en líneas FacturaE');
    end;

    procedure DeleteRelatedLines(FacturaE: Record "Cabecera FacturaE Recibida")
    begin
        NotImplemented('borrado en cascada de líneas y tasas FacturaE');
    end;

    procedure CheckInvoiceAmount(PurchaseHeader: Record "Purchase Header"; FacturaE: Record "Cabecera FacturaE Recibida")
    var
        PurchaseLine: Record "Purchase Line";
        PurchaseAmount: Decimal;
    begin
        PurchaseLine.SetRange("Document Type", PurchaseHeader."Document Type");
        PurchaseLine.SetRange("Document No.", PurchaseHeader."No.");
        PurchaseLine.CalcSums("Amount Including VAT");
        PurchaseAmount := PurchaseLine."Amount Including VAT";

        if Abs(PurchaseAmount - FacturaE."Total Pagar") > 0.01 then
            Error('El importe de la factura (%1) no coincide con el total FacturaE (%2).', PurchaseAmount, FacturaE."Total Pagar");
    end;

    procedure ImportBackupData(): Boolean
    begin
        exit(NotImplemented('importación desde base de datos de respaldo'));
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
    begin
        NotImplemented('apertura de documentos Alfresco');
    end;

    procedure ApproveEInvoice(var FacturaE: Record "Cabecera FacturaE Recibida")
    begin
        FacturaE.TestField(Rechazada, false);
        FacturaE."Approval Status" := FacturaE."Approval Status"::Approved;
        FacturaE.Modify(true);
    end;

    procedure RegisterInvoice(var FacturaE: Record "Cabecera FacturaE Recibida"; PostDocument: Boolean)
    begin
        NotImplemented('registro de factura de compra desde FacturaE');
    end;

    procedure RejectInvoiceWithConfirmation(var FacturaE: Record "Cabecera FacturaE Recibida")
    begin
        if not Confirm(RejectConfirmQst) then
            Error(ProcessCanceledErr);

        RejectInvoice(FacturaE);
        Message(InvoiceRejectedMsg);
    end;

    procedure RejectInvoice(var FacturaE: Record "Cabecera FacturaE Recibida")
    begin
        FacturaE.CalcFields("Documento en Curso", "Documento Registrado");
        FacturaE.TestField("Documento en Curso", '');
        FacturaE.TestField("Documento Registrado", '');
        FacturaE.Rechazada := true;
        FacturaE."Approval Status" := FacturaE."Approval Status"::Rejected;
        FacturaE.Modify(true);
    end;

    procedure ViewInvoice(var FacturaE: Record "Cabecera FacturaE Recibida")
    begin
        NotImplemented('consulta de estado FacturaE');
    end;

    procedure MoveToNextState(var FacturaE: Record "Cabecera FacturaE Recibida")
    begin
        NotImplemented('avance de estado FacturaE');
    end;

    procedure ReturnToReceived(var FacturaE: Record "Cabecera FacturaE Recibida")
    begin
        NotImplemented('retorno de FacturaE a recibida');
    end;

    procedure LinesExist(InvoicePlatformId: Text[50]): Boolean
    begin
        exit(NotImplemented('comprobación de líneas FacturaE'));
    end;

    procedure UpdateAllLineDim(InvoicePlatformId: Text[50]; NewParentDimSetID: Integer; OldParentDimSetID: Integer)
    begin
        NotImplemented('actualización de dimensiones en líneas FacturaE');
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

    local procedure AppendRejectDescription(var FacturaE: Record "Cabecera FacturaE Recibida"; var ExtendedTextLine: Record "Extended Text Line"; StandardTextCode: Code[10]; LanguageCode: Code[10])
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
        FacturaE.Validate("Descripcion Rechazo", CopyStr(FacturaE."Descripcion Rechazo" + TextToAppend, 1, MaxStrLen(FacturaE."Descripcion Rechazo")));
    end;

    local procedure NotImplemented(IntegrationName: Text): Boolean
    begin
        Error(CloudIntegrationErr, IntegrationName);
    end;
}
