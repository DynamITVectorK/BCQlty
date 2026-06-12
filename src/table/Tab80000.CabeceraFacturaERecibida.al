table 80000 "Cabecera FacturaE Recibida"
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
            CalcFormula = exist("Purch. Inv. Header" where("ID Plataforma FacturaE" = field("ID Plataforma"), "Numero FacturaE" = field("Numero")));
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
                FacturaEMgt: Codeunit "FacturaE Recibida Mgt.";
            begin
                exit(FacturaEMgt.LookupVendor(Rec));
            end;

            trigger OnValidate()
            var
                FacturaEMgt: Codeunit "FacturaE Recibida Mgt.";
            begin
                FacturaEMgt.ValidateVendor(Rec);
            end;
        }
        field(34;"DOCUMENTACIÓN ADJUNTA";Text[200])
        {
            Caption = 'Documentación adjunta';
            DataClassification = CustomerContent;
        }
        field(35;"DOCUMENTO PDF";Text[200])
        {
            Caption = 'Documento PDF';
            DataClassification = CustomerContent;
        }
        field(36;"DOCUMENTO FACTURA";Text[200])
        {
            Caption = 'Documento Factura';
            DataClassification = CustomerContent;
        }
        field(37;"Documento Registrado";Code[20])
        {
            Caption = 'Documento Registrado';
            CalcFormula = lookup("Purch. Inv. Header"."No." where("ID Plataforma FacturaE" = field("ID Plataforma"), "Numero FacturaE" = field("Numero")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(38; "Documento en Curso"; Code[20])
        {
            Caption = 'Documento en Curso';
            CalcFormula = lookup("Purchase Header"."No." where(
                "Document Type" = filter(Invoice | "Credit Memo"),
                "ID Plataforma FacturaE" = field("ID Plataforma"),
                "Numero FacturaE" = field("Numero")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(39; "Nombre Proveedor"; Text[100])
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
        field(42; "Motivo Rechazo"; Code[10])
        {
            Caption = 'Motivo rechazo';
            DataClassification = CustomerContent;
            TableRelation = "Standard Text".Code;

            trigger OnLookup()
            var
                FacturaEMgt: Codeunit "FacturaE Recibida Mgt.";
            begin
                exit(FacturaEMgt.LookupRejectReason(Rec));
            end;

            trigger OnValidate()
            begin
                CalcFields("Documento en Curso", "Documento Registrado");
                TestField("Documento en Curso", '');
                TestField("Documento Registrado", '');
                TestField(Rechazada, false);
            end;
        }
        field(43;"Descripción Rechazo";Text[250])
        {
            Caption = 'Descripción Rechazo';
            DataClassification = CustomerContent;
        }
        field(44;"Fecha Importación";Date)
        {
            Caption = 'Fecha Importación';
            DataClassification = SystemMetadata;
            Editable = false;
        }
        field(45;"Hora Importación";Time)
        {
            Caption = 'Hora Importación';
            DataClassification = SystemMetadata;
            Editable = false;
        }
        field(46;"Usuario Importación";Text[250])
        {
            Caption = 'Usuario Importación';
            DataClassification = EndUserIdentifiableInformation;
            Editable = false;
        }
        field(47; "Abono Registrado"; Code[20])
        {
            Caption = 'Abono Registrado';
            CalcFormula = lookup("Purch. Cr. Memo Hdr."."No." where("ID Plataforma FacturaE" = field("ID Plataforma"), "Numero FacturaE" = field("Numero")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(48; "XML Original"; Blob)
        {
            Caption = 'XML Original';
            DataClassification = CustomerContent;
        }
        field(49; "Nombre Fichero XML"; Text[250])
        {
            Caption = 'Nombre fichero XML';
            DataClassification = CustomerContent;
        }
        field(50000; "Approval Status"; Enum "FacturaE Approval Status")
        {
            Caption = 'Approval Status';
            DataClassification = CustomerContent;
        }
        field(50001;EXPEDIENTE;Text[20])
        {
            Caption = 'Expediente';
            DataClassification = CustomerContent;

            trigger OnLookup()
            var
                FacturaEMgt: Codeunit "FacturaE Recibida Mgt.";
            begin
                exit(FacturaEMgt.LookupExpediente(Rec));
            end;

            trigger OnValidate()
            var
                FacturaEMgt: Codeunit "FacturaE Recibida Mgt.";
            begin
                FacturaEMgt.UpdateExpedienteOnLines(Rec);
            end;
        }
        field(50002; Lote; Text[30])
        {
            Caption = 'Lote';
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                FacturaEMgt: Codeunit "FacturaE Recibida Mgt.";
            begin
                FacturaEMgt.UpdateLoteOnLines(Rec);
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
        key(Key1;ID_PLATAFORMA,NUM)
        {
            Clustered = true;
        }
        key(Key2;"Fecha Importación","Hora Importación")
        {
        }
        key(Key3;"Approval Status",Rechazada)
        {
        }
    }

    trigger OnDelete()
    var
        FacturaEMgt: Codeunit "FacturaE Recibida Mgt.";
    begin
        FacturaEMgt.DeleteRelatedLines(Rec);
    end;

    trigger OnInsert()
    begin
        "Fecha Importacion" := Today();
        "Hora Importacion" := Time();
        "Usuario Importacion" := CopyStr(UserId(), 1, MaxStrLen("Usuario Importacion"));
    end;

    procedure ComprobarFacturaE(PurchaseHeader: Record "Purchase Header")
    var
        FacturaEMgt: Codeunit "FacturaE Recibida Mgt.";
    begin
        FacturaEMgt.CheckInvoiceAmount(PurchaseHeader, Rec);
    end;

    procedure fComprobarFacturaE(PurchaseHeader: Record "Purchase Header")
    begin
        ComprobarFacturaE(PurchaseHeader);
    end;

    procedure TraerBackup()
    var
        FacturaEMgt: Codeunit "FacturaE Recibida Mgt.";
    begin
        FacturaEMgt.ImportBackupData();
    end;

    procedure fTraerBackup()
    begin
        TraerBackup();
    end;

    procedure TraerDatosRespaldo(): Boolean
    var
        FacturaEMgt: Codeunit "FacturaE Recibida Mgt.";
    begin
        exit(FacturaEMgt.ImportBackupData());
    end;

    procedure ImportarXmlFacturaE()
    var
        FacturaEMgt: Codeunit "FacturaE Recibida Mgt.";
    begin
        FacturaEMgt.ImportFacturaEXmlFromUpload();
    end;

    procedure ImportarXmlFacturaE(StreamIn: InStream; FileName: Text)
    var
        ImportOrchestrator: Codeunit "FacturaE Import Orchestrator";
    begin
        ImportOrchestrator.ImportXmlStream(StreamIn, FileName);
    end;

    procedure fTraerDatosRespaldo(): Boolean
    begin
        exit(TraerDatosRespaldo());
    end;

    procedure AbrirDocumentoAlfresco(Fichero: Text[250])
    var
        FacturaEMgt: Codeunit "FacturaE Recibida Mgt.";
    begin
        FacturaEMgt.OpenExternalDocument(Fichero, false);
    end;

    procedure fAbrirDocumentoAlfresco(Fichero: Text[250])
    begin
        AbrirDocumentoAlfresco(Fichero);
    end;

    procedure AbrirContenedorAlfresco(Fichero: Text[250])
    var
        FacturaEMgt: Codeunit "FacturaE Recibida Mgt.";
    begin
        FacturaEMgt.OpenExternalDocument(Fichero, true);
    end;

    procedure fAbrirContenedorAlfresco(Fichero: Text[250])
    begin
        AbrirContenedorAlfresco(Fichero);
    end;

    procedure ApproveEInvoice()
    var
        FacturaEMgt: Codeunit "FacturaE Recibida Mgt.";
    begin
        FacturaEMgt.ApproveEInvoice(Rec);
    end;

    procedure Registrar(var FacturaE: Record "Cabecera FacturaE Recibida"; RegistrarDocumento: Boolean)
    var
        FacturaEMgt: Codeunit "FacturaE Recibida Mgt.";
    begin
        FacturaEMgt.RegisterInvoice(FacturaE, RegistrarDocumento);
    end;

    procedure fRegistrar(var FacturaE: Record "Cabecera FacturaE Recibida"; RegistrarDocumento: Boolean)
    begin
        Registrar(FacturaE, RegistrarDocumento);
    end;

    procedure RechazarFacturaEPaso1()
    var
        FacturaEMgt: Codeunit "FacturaE Recibida Mgt.";
    begin
        FacturaEMgt.RejectInvoiceWithConfirmation(Rec);
    end;

    procedure fRechazarFacturaEPaso1()
    begin
        RechazarFacturaEPaso1();
    end;

    procedure RechazarFacturaE(var FacturaE: Record "Cabecera FacturaE Recibida")
    var
        FacturaEMgt: Codeunit "FacturaE Recibida Mgt.";
    begin
        FacturaEMgt.RejectInvoice(FacturaE);
    end;

    procedure fRechazarFacturaE(var FacturaE: Record "Cabecera FacturaE Recibida")
    begin
        RechazarFacturaE(FacturaE);
    end;

    procedure VerFacturaE(var FacturaE: Record "Cabecera FacturaE Recibida")
    var
        FacturaEMgt: Codeunit "FacturaE Recibida Mgt.";
    begin
        FacturaEMgt.ViewInvoice(FacturaE);
    end;

    procedure fVerFacturaE(var FacturaE: Record "Cabecera FacturaE Recibida")
    begin
        VerFacturaE(FacturaE);
    end;

    procedure SiguienteEstadoFacturaE(var FacturaE: Record "Cabecera FacturaE Recibida")
    var
        FacturaEMgt: Codeunit "FacturaE Recibida Mgt.";
    begin
        FacturaEMgt.MoveToNextState(FacturaE);
    end;

    procedure fSiguienteEstadoFacturaE(var FacturaE: Record "Cabecera FacturaE Recibida")
    begin
        SiguienteEstadoFacturaE(FacturaE);
    end;

    procedure VolverARecibidaFacturaE(var FacturaE: Record "Cabecera FacturaE Recibida")
    var
        FacturaEMgt: Codeunit "FacturaE Recibida Mgt.";
    begin
        FacturaEMgt.ReturnToReceived(FacturaE);
    end;

    procedure fVolverARecibidaFacturaE(var FacturaE: Record "Cabecera FacturaE Recibida")
    begin
        VolverARecibidaFacturaE(FacturaE);
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

    procedure TraerDatosRespaldoPaso1()
    var
        FacturaEMgt: Codeunit "FacturaE Recibida Mgt.";
    begin
        FacturaEMgt.ImportBackupDataWithConfirmation();
    end;

    procedure fTraerDatosRespaldoPaso1()
    begin
        TraerDatosRespaldoPaso1();
    end;

    procedure fCortarLineas(TextoOrigen: Text[1024]; var Posicion: Integer; TamanoMaximo: Integer): Text[1024]
    begin
        exit(CortarLineas(TextoOrigen, Posicion, TamanoMaximo));
    end;

    procedure CreateDim(Type1: Integer; No1: Code[20]; Type2: Integer; No2: Code[20]; Type3: Integer; No3: Code[20]; Type4: Integer; No4: Code[20])
    var
        DimMgt: Codeunit DimensionManagement;
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

        if (OldDimSetID <> "Dimension Set ID") and PurchLinesExist() then begin
            Modify();
            UpdateAllLineDim("Dimension Set ID", OldDimSetID);
        end;
    end;

    procedure ShowDocDim()
    var
        DimMgt: Codeunit DimensionManagement;
        OldDimSetID: Integer;
    begin
        OldDimSetID := "Dimension Set ID";
        "Dimension Set ID" := DimMgt.EditDimensionSet2("Dimension Set ID", StrSubstNo('%1 %2', 'Factura', "Numero"), "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");

        if OldDimSetID <> "Dimension Set ID" then begin
            Modify();
            if PurchLinesExist() then
                UpdateAllLineDim("Dimension Set ID", OldDimSetID);
        end;
    end;

    procedure PurchLinesExist(): Boolean
    var
        FacturaEMgt: Codeunit "FacturaE Recibida Mgt.";
    begin
        exit(FacturaEMgt.LinesExist("ID Plataforma"));
    end;

    local procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    var
        DimMgt: Codeunit DimensionManagement;
        OldDimSetID: Integer;
    begin
        OldDimSetID := "Dimension Set ID";
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
        if "Numero" <> '' then
            if Modify() then;

        if OldDimSetID <> "Dimension Set ID" then begin
            if Modify() then;
            if PurchLinesExist() then
                UpdateAllLineDim("Dimension Set ID", OldDimSetID);
        end;
    end;

    local procedure UpdateAllLineDim(NewParentDimSetID: Integer; OldParentDimSetID: Integer)
    var
        FacturaEMgt: Codeunit "FacturaE Recibida Mgt.";
    begin
        FacturaEMgt.UpdateAllLineDim("ID Plataforma", NewParentDimSetID, OldParentDimSetID);
    end;
}
    end;
}

