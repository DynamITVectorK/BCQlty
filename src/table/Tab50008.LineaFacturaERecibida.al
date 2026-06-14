table 50008 "Linea FacturaE Recibida"
{
    Caption = 'Linea FacturaE Recibida';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "ID Factura"; Text[50])
        {
            Caption = 'ID Factura';
            DataClassification = CustomerContent;
        }
        field(2; Linea; Integer)
        {
            Caption = 'Linea';
            DataClassification = CustomerContent;
        }
        field(3; DESCRIPCION; Text[1024])
        {
            Caption = 'Descripcion';
            DataClassification = CustomerContent;
        }
        field(4; CANTIDAD; Decimal)
        {
            Caption = 'Cantidad';
            DataClassification = CustomerContent;
        }
        field(5; PRECIO; Decimal)
        {
            Caption = 'Precio';
            DataClassification = CustomerContent;
        }
        field(6; DESCUENTO; Decimal)
        {
            Caption = 'Descuento';
            DataClassification = CustomerContent;
        }
        field(7; Tasas; Decimal)
        {
            Caption = 'Tasas';
            DataClassification = CustomerContent;
        }
        field(8; Retenciones; Decimal)
        {
            Caption = 'Retenciones';
            DataClassification = CustomerContent;
        }
        field(9; "Amount Including VAT"; Decimal)
        {
            Caption = 'Importe IVA incluido';
            DataClassification = CustomerContent;
        }
        field(10; "Cuenta NAV"; Code[20])
        {
            Caption = 'Cuenta NAV';
            DataClassification = CustomerContent;
            TableRelation = "G/L Account"."No.";
        }
        field(11; "Cod Activo"; Code[20])
        {
            Caption = 'Codigo activo';
            DataClassification = CustomerContent;
            TableRelation = "Fixed Asset"."No.";
        }
        field(12; "Codigo IVA NAV"; Code[20])
        {
            Caption = 'Codigo IVA NAV';
            DataClassification = CustomerContent;
            TableRelation = "VAT Product Posting Group".Code;
        }
        field(13; "Codigo IRPF NAV"; Code[20])
        {
            Caption = 'Codigo IRPF NAV';
            DataClassification = CustomerContent;
        }
        field(14; EXPEDIENTE; Text[20])
        {
            Caption = 'Expediente';
            DataClassification = CustomerContent;
        }
        field(15; Lote; Text[30])
        {
            Caption = 'Lote';
            DataClassification = CustomerContent;
        }
        field(16; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(17; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(18; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            DataClassification = CustomerContent;
            Editable = false;
            TableRelation = "Dimension Set Entry";
        }
        field(19; "Pedido NAV"; Code[20])
        {
            Caption = 'Pedido NAV';
            DataClassification = CustomerContent;
        }
        field(20; "REFERENCIA DEL RECEPTOR"; Text[50])
        {
            Caption = 'Referencia del receptor';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; "ID Factura", Linea)
        {
            Clustered = true;
        }
        key(ExpedienteLote; EXPEDIENTE, Lote)
        {
        }
    }

    procedure fQuitarPaisCIF(VatRegistrationNo: Text): Text
    begin
        exit(RemoveCountryPrefixFromVAT(VatRegistrationNo));
    end;

    procedure RemoveCountryPrefixFromVAT(VatRegistrationNo: Text): Text
    begin
        if StrLen(VatRegistrationNo) <= 2 then
            exit(VatRegistrationNo);

        if CopyStr(VatRegistrationNo, 1, 2) in ['ES', 'FR', 'PT', 'DE', 'IT', 'NL', 'BE', 'IE', 'LU', 'AT'] then
            exit(CopyStr(VatRegistrationNo, 3));

        exit(VatRegistrationNo);
    end;
}
