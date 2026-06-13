table 50007 "Cabecera FacturaE Recibida"
{
    Caption = 'Cabecera FacturaE Recibida';
    DataClassification = CustomerContent;

    fields
    {
        field(1; ID_PLATAFORMA; Text[50])
        {
            Caption = 'ID Plataforma';
            DataClassification = CustomerContent;
        }
        field(2; NUM; Text[20])
        {
            Caption = 'Número';
            DataClassification = CustomerContent;
        }
        field(3; SERIE; Text[20])
        {
            Caption = 'Serie';
            DataClassification = CustomerContent;
        }
        field(4; FECHA_ENTRADA; Date)
        {
            Caption = 'Fecha Entrada';
            DataClassification = CustomerContent;
        }
        field(5; FECHA_DEVENGO; Date)
        {
            Caption = 'Fecha Devengo';
            DataClassification = CustomerContent;
        }
        field(6; EMISOR_CIF; Text[20])
        {
            Caption = 'CIF Emisor';
            DataClassification = CustomerContent;
        }
        field(7; EMISOR_NOMBRE; Text[50])
        {
            Caption = 'Nombre Emisor';
            DataClassification = CustomerContent;
        }
        field(8; EMISOR_DIRECCION; Text[100])
        {
            Caption = 'Dirección Emisor';
            DataClassification = CustomerContent;
        }
        field(9; EMISOR_CIUDAD; Text[30])
        {
            Caption = 'Ciudad Emisor';
            DataClassification = CustomerContent;
        }
        field(10; EMISOR_PROVINCIA; Text[30])
        {
            Caption = 'Provincia Emisor';
            DataClassification = CustomerContent;
        }
        field(11; EMISOR_CP; Text[20])
        {
            Caption = 'Cód. Postal Emisor';
            DataClassification = CustomerContent;
        }
        field(12; EMISOR_TELEFONO; Text[20])
        {
            Caption = 'Teléfono Emisor';
            DataClassification = CustomerContent;
        }
        field(13; EMISOR_EMAIL; Text[80])
        {
            Caption = 'Email Emisor';
            DataClassification = CustomerContent;
        }
        field(14; RECEPTOR_CIF; Text[20])
        {
            Caption = 'CIF Receptor';
            DataClassification = CustomerContent;
        }
        field(22; FORMA_PAGO; Text[50])
        {
            Caption = 'Forma Pago';
            DataClassification = CustomerContent;
        }
        field(23; FECHA_PAGO; Date)
        {
            Caption = 'Fecha Pago';
            DataClassification = CustomerContent;
        }
        field(24; CCC_PAGO; Text[34])
        {
            Caption = 'IBAN Pago';
            DataClassification = CustomerContent;
        }
        field(25; NOTAS; Text[250])
        {
            Caption = 'Notas';
            DataClassification = CustomerContent;
        }
        field(26; CONTACTO_NOMBRE; Text[50])
        {
            Caption = 'Nombre Contacto';
            DataClassification = CustomerContent;
        }
        field(27; CONTACTO_TELEFONO; Text[20])
        {
            Caption = 'Teléfono Contacto';
            DataClassification = CustomerContent;
        }
        field(28; CONTACTO_EMAIL; Text[80])
        {
            Caption = 'Email Contacto';
            DataClassification = CustomerContent;
        }
        field(29; TOTAL_BASES; Decimal)
        {
            Caption = 'Total Bases';
            DataClassification = CustomerContent;
            AutoFormatType = 1;
        }
        field(30; TOTAL_TASAS; Decimal)
        {
            Caption = 'Total Tasas';
            DataClassification = CustomerContent;
            AutoFormatType = 1;
        }
        field(31; TOTAL_PAGAR; Decimal)
        {
            Caption = 'Total Pagar';
            DataClassification = CustomerContent;
            AutoFormatType = 1;
        }
        field(32; Registrada; Boolean)
        {
            Caption = 'Registrada';
            CalcFormula = exist("Purch. Inv. Header" where("ID Plataforma FacturaE" = field(ID_PLATAFORMA), "Numero FacturaE" = field(NUM)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(33; "Proveedor NAV"; Code[20])
        {
            Caption = 'Proveedor NAV';
            DataClassification = CustomerContent;
            TableRelation = Vendor."No.";

            trigger OnLookup()
            var
                Vendor: Record Vendor;
                VendorList: Page "Vendor List";
            begin
                FilterVendorByVat(Vendor);
                VendorList.SetTableView(Vendor);
                VendorList.LookupMode(true);
                if VendorList.RunModal() <> Action::LookupOK then
                    exit;

                VendorList.GetRecord(Vendor);
                Validate("Proveedor NAV", Vendor."No.");
            end;

            trigger OnValidate()
            var
                Vendor: Record Vendor;
            begin
                if "Proveedor NAV" = '' then
                    exit;

                FilterVendorByVat(Vendor);
                Vendor.SetRange("No.", "Proveedor NAV");
                if Vendor.IsEmpty() then
                    Error(VendorVatErr);
            end;
        }
        field(34; "DOCUMENTACIÓN ADJUNTA"; Text[200])
        {
            Caption = 'Documentación adjunta';
            DataClassification = CustomerContent;
        }
        field(35; "DOCUMENTO PDF"; Text[200])
        {
            Caption = 'Documento PDF';
            DataClassification = CustomerContent;
        }
        field(36; "DOCUMENTO FACTURA"; Text[200])
        {
            Caption = 'Documento Factura';
            DataClassification = CustomerContent;
        }
        field(37; "Documento Registrado"; Code[20])
        {
            Caption = 'Documento Registrado';
            CalcFormula = lookup("Purch. Inv. Header"."No." where("ID Plataforma FacturaE" = field(ID_PLATAFORMA), "Numero FacturaE" = field(NUM)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(38; "Documento en Curso"; Code[20])
        {
            Caption = 'Documento en Curso';
            CalcFormula = lookup("Purchase Header"."No." where("Document Type" = filter(Invoice | "Credit Memo"), "ID Plataforma FacturaE" = field(ID_PLATAFORMA), "Numero FacturaE" = field(NUM)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(39; "Nombre proveedor"; Text[100])
        {
            Caption = 'Nombre proveedor';
            CalcFormula = lookup(Vendor.Name where("No." = field("Proveedor NAV")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(40; "CIF Proveedor"; Text[30])
        {
            Caption = 'CIF Proveedor';
            CalcFormula = lookup(Vendor."VAT Registration No." where("No." = field("Proveedor NAV")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(41; Rechazada; Boolean)
        {
            Caption = 'Rechazada';
            DataClassification = CustomerContent;
        }
        field(42; "Motivo rechazo"; Code[10])
        {
            Caption = 'Motivo rechazo';
            DataClassification = CustomerContent;
            TableRelation = "Standard Text".Code;

            trigger OnLookup()
            begin
                LookupRejectReason();
            end;

            trigger OnValidate()
            begin
                CalcFields("Documento en Curso", "Documento Registrado");
                TestField("Documento en Curso", '');
                TestField("Documento Registrado", '');
                TestField(Rechazada, false);
            end;
        }
        field(43; "Descripción Rechazo"; Text[250])
        {
            Caption = 'Descripción Rechazo';
            DataClassification = CustomerContent;
        }
        field(44; "Fecha Importación"; Date)
        {
            Caption = 'Fecha Importación';
            DataClassification = SystemMetadata;
            Editable = false;
        }
        field(45; "Hora Importación"; Time)
        {
            Caption = 'Hora Importación';
            DataClassification = SystemMetadata;
            Editable = false;
        }
        field(46; "Usuario Importación"; Text[250])
        {
            Caption = 'Usuario Importación';
            DataClassification = EndUserIdentifiableInformation;
            Editable = false;
        }
        field(47; "Abono Registrado"; Code[20])
        {
            Caption = 'Abono Registrado';
            CalcFormula = lookup("Purch. Cr. Memo Hdr."."No." where("ID Plataforma FacturaE" = field(ID_PLATAFORMA), "Numero FacturaE" = field(NUM)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50000; "Approval Status"; Option)
        {
            Caption = 'Approval Status';
            DataClassification = CustomerContent;
            OptionCaption = ' ,Approval Pending,Approved,Rejected';
            OptionMembers = " ","Approval Pending",Approved,Rejected;
        }
        field(50001; EXPEDIENTE; Text[20])
        {
            Caption = 'Expediente';
            DataClassification = CustomerContent;

            trigger OnLookup()
            var
                LookupAccepted: Boolean;
                IsHandled: Boolean;
            begin
                OnLookupExpediente(Rec, LookupAccepted, IsHandled);
                if not IsHandled then
                    exit;
            end;

            trigger OnValidate()
            begin
                OnAfterValidateExpediente(Rec);
            end;
        }
        field(50002; Lote; Text[30])
        {
            Caption = 'Lote';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                OnAfterValidateLote(Rec);
            end;
        }
        field(50057; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
            end;
        }
        field(50058; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
            end;
        }
        field(50059; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            DataClassification = SystemMetadata;
            Editable = false;
            TableRelation = "Dimension Set Entry";

            trigger OnLookup()
            begin
                ShowDocDim();
            end;
        }
    }

    keys
    {
        key(Key1; ID_PLATAFORMA, NUM)
        {
            Clustered = true;
        }
        key(Key2; "Fecha Importación", "Hora Importación")
        {
        }
        key(Key3; "Approval Status", Rechazada)
        {
        }
    }

    trigger OnDelete()
    begin
        OnDeleteRelatedFacturaEData(Rec);
    end;

    trigger OnInsert()
    begin
        "Fecha Importación" := Today();
        "Hora Importación" := Time();
        "Usuario Importación" := CopyStr(UserId(), 1, MaxStrLen("Usuario Importación"));
    end;

    var
        DimMgt: Codeunit DimensionManagement;
        VendorVatErr: Label 'El proveedor debe coincidir con el CIF del emisor.';
        ProcessCanceledErr: Label 'Proceso cancelado por el usuario.';
        ImportConfirmQst: Label '¿Desea importar facturas FacturaE recibidas?';
        RejectConfirmQst: Label '¿Desea rechazar esta factura?';
        RejectReasonPrefixLbl: Label 'RECHAZO', Locked = true;
        NoDocumentToOpenMsg: Label 'No hay ningún documento o URL disponible para abrir.';
        PurchaseInvoiceCreatedMsg: Label 'Se ha generado la factura %1. Puede proceder a su revisión.';
        AmountMismatchErr: Label 'El importe de la factura (%1) no coincide con el total FacturaE (%2).';
        PdfLinkDescriptionTxt: Label 'FacturaE - PDF', Locked = true;
        XmlLinkDescriptionTxt: Label 'FacturaE - XML', Locked = true;
        AttachmentLinkDescriptionTxt: Label 'FacturaE - documentación adjunta', Locked = true;

    procedure TraerBackup()
    begin
        fTraerBackup();
    end;

    procedure fTraerBackup()
    var
        Imported: Boolean;
        IsHandled: Boolean;
    begin
        OnImportBackupData(Rec, Imported, IsHandled);
    end;

    procedure TraerDatosRespaldo(): Boolean
    begin
        exit(fTraerDatosRespaldo());
    end;

    procedure fTraerDatosRespaldo(): Boolean
    var
        Imported: Boolean;
        IsHandled: Boolean;
    begin
        OnImportBackupData(Rec, Imported, IsHandled);
        exit(Imported);
    end;

    procedure TraerDatosRespaldoPaso1()
    begin
        fTraerDatosRespaldoPaso1();
    end;

    procedure fTraerDatosRespaldoPaso1()
    begin
        if not Confirm(ImportConfirmQst) then
            Error(ProcessCanceledErr);

        fTraerDatosRespaldo();
    end;

    procedure ImportarXmlFacturaE()
    var
        XmlInStream: InStream;
        FileName: Text;
    begin
        if not UploadIntoStream('Seleccione el XML FacturaE', '', 'XML (*.xml)|*.xml', FileName, XmlInStream) then
            exit;

        ImportarXmlFacturaE(XmlInStream, FileName);
    end;

    procedure ImportarXmlFacturaE(XmlInStream: InStream; FileName: Text)
    var
        IsHandled: Boolean;
    begin
        OnImportFacturaEXml(Rec, XmlInStream, FileName, IsHandled);
    end;

    procedure fComprobarFacturaE(PurchaseHeader: Record "Purchase Header")
    begin
        ComprobarFacturaE(PurchaseHeader);
    end;

    procedure ComprobarFacturaE(PurchaseHeader: Record "Purchase Header")
    var
        PurchaseLine: Record "Purchase Line";
        AmountIncludingVAT: Decimal;
        IsHandled: Boolean;
    begin
        OnBeforeComprobarFacturaE(Rec, PurchaseHeader, IsHandled);
        if IsHandled then
            exit;

        PurchaseLine.SetRange("Document Type", PurchaseHeader."Document Type");
        PurchaseLine.SetRange("Document No.", PurchaseHeader."No.");
        PurchaseLine.CalcSums("Amount Including VAT");
        AmountIncludingVAT := PurchaseLine."Amount Including VAT";

        if Abs(AmountIncludingVAT - TOTAL_PAGAR) > 0.01 then
            Error(AmountMismatchErr, AmountIncludingVAT, TOTAL_PAGAR);
    end;

    procedure fAbrirDocumentoAlfresco(Fichero: Text[250])
    begin
        AbrirDocumentoAlfresco(Fichero);
    end;

    procedure AbrirDocumentoAlfresco(Fichero: Text[250])
    begin
        OpenExternalDocument(Fichero, false);
    end;

    procedure fAbrirContenedorAlfresco(Fichero: Text[250])
    begin
        AbrirContenedorAlfresco(Fichero);
    end;

    procedure AbrirContenedorAlfresco(Fichero: Text[250])
    begin
        OpenExternalDocument(Fichero, true);
    end;

    procedure fCopiarDocumentosAlfresco(CabeceraFacturaERecibida: Record "Cabecera FacturaE Recibida"; var PurchaseHeader: Record "Purchase Header")
    begin
        CopiarDocumentosAlfresco(CabeceraFacturaERecibida, PurchaseHeader);
    end;

    procedure CopiarDocumentosAlfresco(CabeceraFacturaERecibida: Record "Cabecera FacturaE Recibida"; var PurchaseHeader: Record "Purchase Header")
    var
        IsHandled: Boolean;
    begin
        OnBeforeCopiarDocumentosAlfresco(CabeceraFacturaERecibida, PurchaseHeader, IsHandled);
        if IsHandled then
            exit;

        AddFacturaELinkToPurchaseHeader(PurchaseHeader, CabeceraFacturaERecibida."DOCUMENTO PDF", PdfLinkDescriptionTxt, 'PDF');
        AddFacturaELinkToPurchaseHeader(PurchaseHeader, CabeceraFacturaERecibida."DOCUMENTO FACTURA", XmlLinkDescriptionTxt, 'XML');
        AddFacturaELinkToPurchaseHeader(PurchaseHeader, CabeceraFacturaERecibida."DOCUMENTACIÓN ADJUNTA", AttachmentLinkDescriptionTxt, 'ATTACHMENT');

        PurchaseHeader.CopyLinks(CabeceraFacturaERecibida);
        OnAfterCopiarDocumentosAlfresco(CabeceraFacturaERecibida, PurchaseHeader);
    end;

    procedure ApproveEInvoice()
    var
        IsHandled: Boolean;
    begin
        OnBeforeApproveEInvoice(Rec, IsHandled);
        if IsHandled then
            exit;

        TestField(Rechazada, false);
        "Approval Status" := "Approval Status"::Approved;
        Modify(true);
        OnAfterApproveEInvoice(Rec);
    end;

    procedure fRegistrar(FacturaE: Record "Cabecera FacturaE Recibida"; RegistrarDocumento: Boolean)
    begin
        Registrar(FacturaE, RegistrarDocumento);
    end;

    procedure Registrar(var FacturaE: Record "Cabecera FacturaE Recibida"; RegistrarDocumento: Boolean)
    var
        PurchaseHeader: Record "Purchase Header";
        IsHandled: Boolean;
    begin
        OnBeforeRegistrar(FacturaE, RegistrarDocumento, PurchaseHeader, IsHandled);
        if not IsHandled then begin
            FacturaE.TestField("Proveedor NAV");
            PurchaseHeader.Init();
            PurchaseHeader."Document Type" := PurchaseHeader."Document Type"::Invoice;
            PurchaseHeader.Insert(true);
            PurchaseHeader.Validate("Buy-from Vendor No.", FacturaE."Proveedor NAV");
            PurchaseHeader.Validate("Vendor Invoice No.", CopyStr(FacturaE.NUM, 1, MaxStrLen(PurchaseHeader."Vendor Invoice No.")));
            PurchaseHeader.Validate("Document Date", FacturaE.FECHA_DEVENGO);
            PurchaseHeader.Validate("Posting Date", WorkDate());
            PurchaseHeader.Modify(true);
        end;

        CopiarDocumentosAlfresco(FacturaE, PurchaseHeader);

        if RegistrarDocumento then
            Codeunit.Run(Codeunit::"Purch.-Post (Yes/No)", PurchaseHeader)
        else
            Message(PurchaseInvoiceCreatedMsg, PurchaseHeader."No.");

        OnAfterRegistrar(FacturaE, PurchaseHeader, RegistrarDocumento);
    end;

    procedure fRechazarFacturaEPaso1()
    begin
        RechazarFacturaEPaso1();
    end;

    procedure RechazarFacturaEPaso1()
    begin
        if not Confirm(RejectConfirmQst) then
            Error(ProcessCanceledErr);

        RechazarFacturaE(Rec);
    end;

    procedure fRechazarFacturaE(CabeceraFacturaERecibida: Record "Cabecera FacturaE Recibida")
    begin
        RechazarFacturaE(CabeceraFacturaERecibida);
    end;

    procedure RechazarFacturaE(var CabeceraFacturaERecibida: Record "Cabecera FacturaE Recibida")
    var
        IsHandled: Boolean;
    begin
        OnBeforeRechazarFacturaE(CabeceraFacturaERecibida, IsHandled);
        if IsHandled then
            exit;

        CabeceraFacturaERecibida.CalcFields("Documento en Curso", "Documento Registrado");
        CabeceraFacturaERecibida.TestField("Documento en Curso", '');
        CabeceraFacturaERecibida.TestField("Documento Registrado", '');
        CabeceraFacturaERecibida.Rechazada := true;
        CabeceraFacturaERecibida."Approval Status" := CabeceraFacturaERecibida."Approval Status"::Rejected;
        CabeceraFacturaERecibida.Modify(true);
        OnAfterRechazarFacturaE(CabeceraFacturaERecibida);
    end;

    procedure fVerFacturaE(CabeceraFacturaERecibida: Record "Cabecera FacturaE Recibida")
    begin
        VerFacturaE(CabeceraFacturaERecibida);
    end;

    procedure VerFacturaE(var CabeceraFacturaERecibida: Record "Cabecera FacturaE Recibida")
    var
        PurchInvHeader: Record "Purch. Inv. Header";
        IsHandled: Boolean;
    begin
        OnBeforeVerFacturaE(CabeceraFacturaERecibida, IsHandled);
        if IsHandled then
            exit;

        if CabeceraFacturaERecibida."DOCUMENTO PDF" <> '' then begin
            OpenExternalDocument(CabeceraFacturaERecibida."DOCUMENTO PDF", false);
            exit;
        end;

        CabeceraFacturaERecibida.CalcFields("Documento Registrado");
        if (CabeceraFacturaERecibida."Documento Registrado" <> '') and PurchInvHeader.Get(CabeceraFacturaERecibida."Documento Registrado") then begin
            Page.Run(Page::"Posted Purchase Invoice", PurchInvHeader);
            exit;
        end;

        Message(NoDocumentToOpenMsg);
    end;

    procedure fSiguienteEstadoFacturaE(CabeceraFacturaERecibida: Record "Cabecera FacturaE Recibida")
    begin
        SiguienteEstadoFacturaE(CabeceraFacturaERecibida);
    end;

    procedure SiguienteEstadoFacturaE(var CabeceraFacturaERecibida: Record "Cabecera FacturaE Recibida")
    begin
        case CabeceraFacturaERecibida."Approval Status" of
            CabeceraFacturaERecibida."Approval Status"::" ":
                CabeceraFacturaERecibida."Approval Status" := CabeceraFacturaERecibida."Approval Status"::"Approval Pending";
            CabeceraFacturaERecibida."Approval Status"::"Approval Pending":
                CabeceraFacturaERecibida."Approval Status" := CabeceraFacturaERecibida."Approval Status"::Approved;
            CabeceraFacturaERecibida."Approval Status"::Rejected:
                begin
                    CabeceraFacturaERecibida.Rechazada := false;
                    CabeceraFacturaERecibida."Approval Status" := CabeceraFacturaERecibida."Approval Status"::"Approval Pending";
                end;
        end;
        CabeceraFacturaERecibida.Modify(true);
    end;

    procedure fVolverARecibidaFacturaE(CabeceraFacturaERecibida: Record "Cabecera FacturaE Recibida")
    begin
        VolverARecibidaFacturaE(CabeceraFacturaERecibida);
    end;

    procedure VolverARecibidaFacturaE(var CabeceraFacturaERecibida: Record "Cabecera FacturaE Recibida")
    begin
        CabeceraFacturaERecibida.Rechazada := false;
        CabeceraFacturaERecibida."Approval Status" := CabeceraFacturaERecibida."Approval Status"::" ";
        CabeceraFacturaERecibida.Modify(true);
    end;

    procedure fCortarLineas(TextoOrigen: Text[1024]; var Posicion: Integer; TamanoMaximo: Integer): Text[1024]
    begin
        exit(CortarLineas(TextoOrigen, Posicion, TamanoMaximo));
    end;

    procedure CortarLineas(TextoOrigen: Text[1024]; var Posicion: Integer; TamanoMaximo: Integer): Text[1024]
    var
        TextoNoCortar: Text[1024];
        TextoPosicion: Text[1024];
        TextoRetorno: Text[1024];
        Inicio: Boolean;
        PosicionBlanco: Integer;
        PosicionTotal: Integer;
    begin
        if Posicion > StrLen(TextoOrigen) then
            exit('');

        TextoNoCortar := CopyStr(TextoOrigen, Posicion, TamanoMaximo + 1);
        if StrLen(TextoNoCortar) > TamanoMaximo then begin
            TextoPosicion := TextoNoCortar;
            Inicio := true;
            while StrPos(TextoPosicion, ' ') <> 0 do begin
                PosicionBlanco := StrPos(TextoPosicion, ' ');
                PosicionTotal += PosicionBlanco;
                TextoPosicion := CopyStr(TextoPosicion, PosicionBlanco + 1, TamanoMaximo);
                Inicio := false;
            end;

            if (PosicionBlanco = 0) and Inicio then
                TextoRetorno := CopyStr(TextoOrigen, Posicion, TamanoMaximo)
            else
                if PosicionTotal <> 0 then
                    if StrLen(TextoNoCortar) < TamanoMaximo then
                        TextoRetorno := CopyStr(TextoOrigen, Posicion, TamanoMaximo)
                    else
                        TextoRetorno := CopyStr(TextoOrigen, Posicion, PosicionTotal)
                else
                    TextoRetorno := CopyStr(TextoOrigen, Posicion, TamanoMaximo);
        end else
            TextoRetorno := CopyStr(TextoOrigen, Posicion, TamanoMaximo);

        Posicion += StrLen(TextoRetorno);
        exit(TextoRetorno);
    end;

    procedure CreateDim(Type1: Integer; No1: Code[20]; Type2: Integer; No2: Code[20]; Type3: Integer; No3: Code[20]; Type4: Integer; No4: Code[20])
    var
        SourceCodeSetup: Record "Source Code Setup";
        TableID: array[10] of Integer;
        No: array[10] of Code[20];
        OldDimSetID: Integer;
    begin
        SourceCodeSetup.Get();
        TableID[1] := Type1;
        No[1] := No1;
        TableID[2] := Type2;
        No[2] := No2;
        TableID[3] := Type3;
        No[3] := No3;
        TableID[4] := Type4;
        No[4] := No4;

        "Shortcut Dimension 1 Code" := '';
        "Shortcut Dimension 2 Code" := '';
        OldDimSetID := "Dimension Set ID";
        "Dimension Set ID" := DimMgt.GetDefaultDimID(TableID, No, SourceCodeSetup.Purchases, "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code", 0, 0);

        if OldDimSetID <> "Dimension Set ID" then begin
            Modify(true);
            UpdateAllLineDim("Dimension Set ID", OldDimSetID);
        end;
    end;

    procedure ShowDocDim()
    var
        OldDimSetID: Integer;
    begin
        OldDimSetID := "Dimension Set ID";
        "Dimension Set ID" := DimMgt.EditDimensionSet2("Dimension Set ID", StrSubstNo('%1 %2', 'Factura', NUM), "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");

        if OldDimSetID <> "Dimension Set ID" then begin
            Modify(true);
            UpdateAllLineDim("Dimension Set ID", OldDimSetID);
        end;
    end;

    procedure PurchLinesExist(): Boolean
    var
        LinesExist: Boolean;
    begin
        OnPurchLinesExist(Rec, LinesExist);
        exit(LinesExist);
    end;

    local procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    var
        OldDimSetID: Integer;
    begin
        OldDimSetID := "Dimension Set ID";
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
        if NUM <> '' then
            if Modify(true) then;

        if OldDimSetID <> "Dimension Set ID" then begin
            if Modify(true) then;
            UpdateAllLineDim("Dimension Set ID", OldDimSetID);
        end;
    end;

    local procedure UpdateAllLineDim(NewParentDimSetID: Integer; OldParentDimSetID: Integer)
    begin
        if NewParentDimSetID = OldParentDimSetID then
            exit;

        OnUpdateAllLineDim(Rec, NewParentDimSetID, OldParentDimSetID);
    end;

    local procedure FilterVendorByVat(var Vendor: Record Vendor)
    begin
        Vendor.Reset();
        Vendor.SetFilter("VAT Registration No.", '%1|%2', EMISOR_CIF, QuitarPaisCIF(EMISOR_CIF));
    end;

    local procedure QuitarPaisCIF(VatRegistrationNo: Text[20]): Text[20]
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

    local procedure LookupRejectReason()
    var
        StandardText: Record "Standard Text";
        StandardTexts: Page "Standard Text Codes";
    begin
        StandardText.SetFilter(Code, '%1', RejectReasonPrefixLbl + '*');
        StandardTexts.SetTableView(StandardText);
        StandardTexts.LookupMode(true);
        if StandardTexts.RunModal() <> Action::LookupOK then
            exit;

        StandardTexts.GetRecord(StandardText);
        Validate("Motivo rechazo", StandardText.Code);
        SetRejectDescription(StandardText.Code);
    end;

    local procedure SetRejectDescription(StandardTextCode: Code[10])
    var
        ExtendedTextLine: Record "Extended Text Line";
    begin
        Validate("Descripción Rechazo", '');
        AppendRejectDescription(ExtendedTextLine, StandardTextCode, 'ESP');
        if HasExtendedText(StandardTextCode, 'EUS') then begin
            AppendRejectText(' / ');
            AppendRejectDescription(ExtendedTextLine, StandardTextCode, 'EUS');
        end;
    end;

    local procedure AppendRejectDescription(var ExtendedTextLine: Record "Extended Text Line"; StandardTextCode: Code[10]; LanguageCode: Code[10])
    begin
        ExtendedTextLine.Reset();
        ExtendedTextLine.SetRange("Table Name", ExtendedTextLine."Table Name"::"Standard Text");
        ExtendedTextLine.SetRange("No.", StandardTextCode);
        ExtendedTextLine.SetRange("Language Code", LanguageCode);
        ExtendedTextLine.SetRange("Text No.", 1);
        if ExtendedTextLine.FindSet() then
            repeat
                AppendRejectText(ExtendedTextLine.Text);
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

    local procedure AppendRejectText(TextToAppend: Text)
    begin
        Validate("Descripción Rechazo", CopyStr("Descripción Rechazo" + TextToAppend, 1, MaxStrLen("Descripción Rechazo")));
    end;

    local procedure OpenExternalDocument(FileName: Text[250]; OpenContainer: Boolean)
    var
        UrlToOpen: Text;
        LastSlashPosition: Integer;
    begin
        UrlToOpen := FileName;
        if UrlToOpen = '' then begin
            Message(NoDocumentToOpenMsg);
            exit;
        end;

        if OpenContainer then begin
            LastSlashPosition := GetLastSlashPosition(UrlToOpen);
            if LastSlashPosition > 0 then
                UrlToOpen := CopyStr(UrlToOpen, 1, LastSlashPosition);
        end;

        Hyperlink(UrlToOpen);
    end;

    local procedure AddFacturaELinkToPurchaseHeader(var PurchaseHeader: Record "Purchase Header"; LinkUrl: Text[200]; LinkDescription: Text[80]; LinkType: Code[20])
    var
        NormalizedLinkUrl: Text[2048];
        IsHandled: Boolean;
    begin
        NormalizedLinkUrl := NormalizeExternalDocumentUrl(LinkUrl);
        if NormalizedLinkUrl = '' then
            exit;

        OnBeforeAddFacturaELinkToPurchaseHeader(PurchaseHeader, NormalizedLinkUrl, LinkDescription, LinkType, IsHandled);
        if IsHandled then
            exit;

        PurchaseHeader.AddLink(NormalizedLinkUrl, LinkDescription);
        OnAfterAddFacturaELinkToPurchaseHeader(PurchaseHeader, NormalizedLinkUrl, LinkDescription, LinkType);
    end;

    local procedure NormalizeExternalDocumentUrl(LinkUrl: Text[200]) NormalizedLinkUrl: Text[2048]
    begin
        NormalizedLinkUrl := DelChr(LinkUrl, '<>');
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

    [IntegrationEvent(false, false)]
    local procedure OnImportBackupData(var CabeceraFacturaERecibida: Record "Cabecera FacturaE Recibida"; var Imported: Boolean; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnImportFacturaEXml(var CabeceraFacturaERecibida: Record "Cabecera FacturaE Recibida"; var XmlInStream: InStream; FileName: Text; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnDeleteRelatedFacturaEData(CabeceraFacturaERecibida: Record "Cabecera FacturaE Recibida")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnLookupExpediente(var CabeceraFacturaERecibida: Record "Cabecera FacturaE Recibida"; var LookupAccepted: Boolean; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterValidateExpediente(var CabeceraFacturaERecibida: Record "Cabecera FacturaE Recibida")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterValidateLote(var CabeceraFacturaERecibida: Record "Cabecera FacturaE Recibida")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeComprobarFacturaE(CabeceraFacturaERecibida: Record "Cabecera FacturaE Recibida"; PurchaseHeader: Record "Purchase Header"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeApproveEInvoice(var CabeceraFacturaERecibida: Record "Cabecera FacturaE Recibida"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeCopiarDocumentosAlfresco(CabeceraFacturaERecibida: Record "Cabecera FacturaE Recibida"; var PurchaseHeader: Record "Purchase Header"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeAddFacturaELinkToPurchaseHeader(var PurchaseHeader: Record "Purchase Header"; var LinkUrl: Text[2048]; var LinkDescription: Text[80]; LinkType: Code[20]; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterAddFacturaELinkToPurchaseHeader(var PurchaseHeader: Record "Purchase Header"; LinkUrl: Text[2048]; LinkDescription: Text[80]; LinkType: Code[20])
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterCopiarDocumentosAlfresco(CabeceraFacturaERecibida: Record "Cabecera FacturaE Recibida"; var PurchaseHeader: Record "Purchase Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterApproveEInvoice(CabeceraFacturaERecibida: Record "Cabecera FacturaE Recibida")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeRegistrar(var CabeceraFacturaERecibida: Record "Cabecera FacturaE Recibida"; RegistrarDocumento: Boolean; var PurchaseHeader: Record "Purchase Header"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterRegistrar(var CabeceraFacturaERecibida: Record "Cabecera FacturaE Recibida"; PurchaseHeader: Record "Purchase Header"; RegistrarDocumento: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeRechazarFacturaE(var CabeceraFacturaERecibida: Record "Cabecera FacturaE Recibida"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterRechazarFacturaE(CabeceraFacturaERecibida: Record "Cabecera FacturaE Recibida")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeVerFacturaE(var CabeceraFacturaERecibida: Record "Cabecera FacturaE Recibida"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnPurchLinesExist(CabeceraFacturaERecibida: Record "Cabecera FacturaE Recibida"; var LinesExist: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnUpdateAllLineDim(CabeceraFacturaERecibida: Record "Cabecera FacturaE Recibida"; NewParentDimSetID: Integer; OldParentDimSetID: Integer)
    begin
    end;
}
