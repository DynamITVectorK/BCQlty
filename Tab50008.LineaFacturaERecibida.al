table 50008 "Linea FacturaE Recibida"
{
    Caption = 'Línea FacturaE Recibida';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "ID Factura"; Text[50])
        {
            Caption = 'ID Factura';
            DataClassification = CustomerContent;
            TableRelation = "Cabecera FacturaE Recibida"."ID Plataforma";
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = SystemMetadata;
        }
        field(3; Description; Text[100])
        {
            Caption = 'Descripción';
            DataClassification = CustomerContent;
        }
        field(4; Quantity; Decimal)
        {
            Caption = 'Cantidad';
            DataClassification = CustomerContent;
            DecimalPlaces = 0 : 5;
        }
        field(5; "Unit Price"; Decimal)
        {
            Caption = 'Precio unitario';
            DataClassification = CustomerContent;
            AutoFormatType = 1;
        }
        field(6; Amount; Decimal)
        {
            Caption = 'Importe';
            DataClassification = CustomerContent;
            AutoFormatType = 1;
        }
        field(7; Expediente; Code[20])
        {
            Caption = 'Expediente';
            DataClassification = CustomerContent;
        }
        field(8; Lote; Text[30])
        {
            Caption = 'Lote';
            DataClassification = CustomerContent;
        }
        field(9; "Cuenta NAV"; Code[20])
        {
            Caption = 'Cuenta NAV';
            DataClassification = CustomerContent;
            TableRelation = "G/L Account"."No.";
        }
        field(10; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(11; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(12; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            DataClassification = SystemMetadata;
            TableRelation = "Dimension Set Entry";
        }
    }

    keys
    {
        key(PK; "ID Factura", "Line No.")
        {
            Clustered = true;
        }
    }
}
