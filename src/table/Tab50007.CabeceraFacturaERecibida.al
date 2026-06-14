table 50007 "Cabecera FacturaE Recibida"
{
    Caption = 'Cabecera FacturaE Recibida';
    DataClassification = CustomerContent;

    fields
    {
        field(1; ID_PLATAFORMA; Text[50]) { Caption = 'ID_Plataforma'; DataClassification = CustomerContent; }
        field(2; NUM; Text[20]) { Caption = 'Número'; DataClassification = CustomerContent; }
        field(3; SERIE; Text[20]) { Caption = 'Serie'; DataClassification = CustomerContent; }
        field(4; FECHA_ENTRADA; Date) { Caption = 'Fecha Entrada'; DataClassification = CustomerContent; }
        field(5; FECHA_DEVENGO; Date) { Caption = 'Fecha Devengo'; DataClassification = CustomerContent; }
        field(6; EMISOR_CIF; Text[20]) { Caption = 'CIF Emisor'; DataClassification = CustomerContent; }
        field(7; EMISOR_NOMBRE; Text[50]) { Caption = 'Nombre Emisor'; DataClassification = CustomerContent; }
        field(8; EMISOR_DIRECCION; Text[100]) { Caption = 'Dirección Emisor'; DataClassification = CustomerContent; }
        field(9; EMISOR_CIUDAD; Text[30]) { Caption = 'Ciudad Emisor'; DataClassification = CustomerContent; }
        field(10; EMISOR_PROVINCIA; Text[30]) { Caption = 'Provincia Emisor'; DataClassification = CustomerContent; }
        field(11; EMISOR_CP; Text[20]) { Caption = 'Cód. Postal Emisor'; DataClassification = CustomerContent; }
        field(12; EMISOR_TELEFONO; Text[20]) { Caption = 'Teléfono Emisor'; DataClassification = CustomerContent; }
        field(13; EMISOR_EMAIL; Text[80]) { Caption = 'Email Emisor'; DataClassification = CustomerContent; }
        field(14; RECEPTOR_CIF; Text[20]) { Caption = 'CIF Receptor'; DataClassification = CustomerContent; }
        field(22; FORMA_PAGO; Text[50]) { Caption = 'Forma Pago'; DataClassification = CustomerContent; }
        field(23; FECHA_PAGO; Date) { Caption = 'Fecha Pago'; DataClassification = CustomerContent; }
        field(24; CCC_PAGO; Text[34]) { Caption = 'IBAN Pago'; DataClassification = CustomerContent; }
        field(25; NOTAS; Text[250]) { Caption = 'Notas'; DataClassification = CustomerContent; }
        field(26; CONTACTO_NOMBRE; Text[50]) { Caption = 'Nombre Contacto'; DataClassification = CustomerContent; }
        field(27; CONTACTO_TELEFONO; Text[20]) { Caption = 'Teléfono Contacto'; DataClassification = CustomerContent; }
        field(28; CONTACTO_EMAIL; Text[80]) { Caption = 'Email Contacto'; DataClassification = CustomerContent; }
        field(29; TOTAL_BASES; Decimal) { Caption = 'Total Bases'; DataClassification = CustomerContent; }
        field(30; TOTAL_TASAS; Decimal) { Caption = 'Total Tasas'; DataClassification = CustomerContent; }
        field(31; TOTAL_PAGAR; Decimal) { Caption = 'Total Pagar'; DataClassification = CustomerContent; }
        field(32; Registrada; Boolean)
        {
            Caption = 'Registrada';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = exist("Purch. Inv. Header" where("ID Plataforma FacturaE" = field(ID_PLATAFORMA), "Numero FacturaE" = field(NUM)));
        }
        field(33; "Proveedor NAV"; Code[20])
        {
            Caption = 'Proveedor NAV';
            DataClassification = CustomerContent;
            TableRelation = Vendor."No.";

            trigger OnValidate()
            var
                Vendor: Record Vendor;
                FacturaESaaSCompatibilityMgt: Codeunit "FacturaE SaaS Compatibility Mgt.";
            begin
                if "Proveedor NAV" = '' then
                    exit;
                Vendor.Get("Proveedor NAV");
                if not FacturaESaaSCompatibilityMgt.SameVAT(EMISOR_CIF, Vendor."VAT Registration No.") then
                    Error(ProviderVatErr);
            end;
        }
        field(34; "DOCUMENTACIÓN ADJUNTA"; Text[200]) { Caption = 'Documentación adjunta'; DataClassification = CustomerContent; }
        field(35; "DOCUMENTO PDF"; Text[200]) { Caption = 'Documento PDF'; DataClassification = CustomerContent; }
        field(36; "DOCUMENTO FACTURA"; Text[200]) { Caption = 'Documento Factura'; DataClassification = CustomerContent; }
        field(37; "Documento Registrado"; Code[20])
        {
            Caption = 'Documento Registrado';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Purch. Inv. Header"."No." where("ID Plataforma FacturaE" = field(ID_PLATAFORMA), "Numero FacturaE" = field(NUM)));
        }
        field(38; "Documento en Curso"; Code[20])
        {
            Caption = 'Documento en Curso';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Purchase Header"."No." where("Document Type" = filter(Invoice | "Credit Memo"), "ID Plataforma FacturaE" = field(ID_PLATAFORMA), "Numero FacturaE" = field(NUM)));
        }
        field(39; "Nombre proveedor"; Text[100])
        {
            Caption = 'Nombre proveedor';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup(Vendor.Name where("No." = field("Proveedor NAV")));
        }
        field(40; "CIF Proveedor"; Text[30])
        {
            Caption = 'CIF Proveedor';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup(Vendor."VAT Registration No." where("No." = field("Proveedor NAV")));
        }
        field(41; Rechazada; Boolean) { Caption = 'Rechazada'; DataClassification = CustomerContent; }
        field(42; "Motivo rechazo"; Code[10])
        {
            Caption = 'Motivo rechazo';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                CalcFields("Documento en Curso", "Documento Registrado");
                TestField("Documento en Curso", '');
                TestField("Documento Registrado", '');
                TestField(Rechazada, false);
            end;
        }
        field(43; "Descripción Rechazo"; Text[250]) { Caption = 'Descripción Rechazo'; DataClassification = CustomerContent; }
        field(44; "Fecha Importación"; Date) { Caption = 'Fecha Importación'; DataClassification = CustomerContent; }
        field(45; "Hora Importación"; Time) { Caption = 'Hora Importación'; DataClassification = CustomerContent; }
        field(46; "Usuario Importación"; Text[250]) { Caption = 'Usuario Importación'; DataClassification = CustomerContent; }
        field(47; "Abono Registrado"; Code[20])
        {
            Caption = 'Abono Registrado';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Purch. Cr. Memo Hdr."."No." where("ID Plataforma FacturaE" = field(ID_PLATAFORMA), "Numero FacturaE" = field(NUM)));
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
            trigger OnValidate()
            var
                FacturaERecibidaMgt: Codeunit "FacturaE Recibida Mgt.";
            begin
                FacturaERecibidaMgt.PropagateExpedienteToLines(Rec);
            end;
        }
        field(50002; Lote; Text[30])
        {
            Caption = 'Lote';
            DataClassification = CustomerContent;
            trigger OnValidate()
            var
                FacturaERecibidaMgt: Codeunit "FacturaE Recibida Mgt.";
            begin
                FacturaERecibidaMgt.PropagateLoteToLines(Rec);
            end;
        }
        field(50057; "Shortcut Dimension 1 Code"; Code[20]) { CaptionClass = '1,2,1'; Caption = 'Shortcut Dimension 1 Code'; DataClassification = CustomerContent; TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1)); }
        field(50058; "Shortcut Dimension 2 Code"; Code[20]) { CaptionClass = '1,2,2'; Caption = 'Shortcut Dimension 2 Code'; DataClassification = CustomerContent; TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2)); }
        field(50059; "Dimension Set ID"; Integer) { Caption = 'Dimension Set ID'; DataClassification = CustomerContent; Editable = false; TableRelation = "Dimension Set Entry"; }
    }

    keys
    {
        key(PK; ID_PLATAFORMA, NUM) { Clustered = true; }
        key(ImportDateTime; "Fecha Importación", "Hora Importación") { }
        key(ApprovalStatus; "Approval Status", Rechazada) { }
    }

    trigger OnInsert()
    begin
        "Fecha Importación" := Today();
        "Hora Importación" := Time();
        "Usuario Importación" := CopyStr(UserId(), 1, MaxStrLen("Usuario Importación"));
    end;

    trigger OnDelete()
    var
        FacturaERecibidaMgt: Codeunit "FacturaE Recibida Mgt.";
    begin
        FacturaERecibidaMgt.DeleteRelatedData(Rec);
    end;

    var
        ProviderVatErr: Label 'El proveedor debe coincidir con el CIF del emisor.';
        ImportConfirmLbl: Label '¿Desea importar los datos pendientes?';
        UserCancelledErr: Label 'Proceso cancelado por el usuario.';
        RejectedMsg: Label 'Factura rechazada correctamente.';

    procedure fTraerBackup()
    var
        FacturaEImportOrchestrator: Codeunit "FacturaE Import Orchestrator";
    begin
        FacturaEImportOrchestrator.ImportPendingInvoices();
    end;

    procedure fTraerDatosRespaldo(): Boolean
    var
        FacturaEImportOrchestrator: Codeunit "FacturaE Import Orchestrator";
    begin
        exit(FacturaEImportOrchestrator.ImportPendingInvoices());
    end;

    procedure fTraerDatosRespaldoPaso1()
    begin
        if not Confirm(ImportConfirmLbl) then
            Error(UserCancelledErr);
        fTraerDatosRespaldo();
    end;

    procedure fComprobarFacturaE(PurchaseHeader: Record "Purchase Header")
    var
        FacturaERecibidaMgt: Codeunit "FacturaE Recibida Mgt.";
    begin
        FacturaERecibidaMgt.CheckFacturaEAmount(PurchaseHeader);
    end;

    procedure fRegistrar(Factura: Record "Cabecera FacturaE Recibida"; Registrar: Boolean)
    var
        FacturaEPurchaseMgt: Codeunit "FacturaE Purchase Mgt.";
        WorkHeader: Record "Cabecera FacturaE Recibida";
    begin
        WorkHeader := Factura;
        FacturaEPurchaseMgt.CreatePurchaseDocument(WorkHeader, Registrar);
    end;

    procedure ApproveEInvoice()
    var
        FacturaERecibidaMgt: Codeunit "FacturaE Recibida Mgt.";
    begin
        FacturaERecibidaMgt.ApproveFacturaE(Rec);
    end;

    procedure fRechazarFacturaEPaso1()
    begin
        fRechazarFacturaE(Rec);
        Message(RejectedMsg);
    end;

    procedure fRechazarFacturaE(CabeceraFacturaERecibida: Record "Cabecera FacturaE Recibida")
    var
        FacturaERecibidaMgt: Codeunit "FacturaE Recibida Mgt.";
        WorkHeader: Record "Cabecera FacturaE Recibida";
    begin
        WorkHeader := CabeceraFacturaERecibida;
        FacturaERecibidaMgt.RejectFacturaE(WorkHeader);
    end;

    procedure fAbrirDocumentoAlfresco(Fichero: Text[250])
    var
        FacturaEDocumentMgt: Codeunit "FacturaE Document Mgt.";
    begin
        FacturaEDocumentMgt.OpenDocument(Fichero);
    end;

    procedure fAbrirContenedorAlfresco(Fichero: Text[250])
    var
        FacturaEDocumentMgt: Codeunit "FacturaE Document Mgt.";
    begin
        FacturaEDocumentMgt.OpenContainer(Fichero);
    end;

    procedure fCopiarDocumentosAlfresco(CabeceraFacturaERecibida: Record "Cabecera FacturaE Recibida"; var PurchaseHeader: Record "Purchase Header")
    var
        FacturaEDocumentMgt: Codeunit "FacturaE Document Mgt.";
    begin
        FacturaEDocumentMgt.CopyDocumentLinksToPurchase(CabeceraFacturaERecibida, PurchaseHeader);
    end;
}
