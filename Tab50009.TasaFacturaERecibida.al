table 50009 "Tasa FacturaE Recibida"
{
    Caption = 'Tasa FacturaE Recibida';
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
        field(4; Amount; Decimal)
        {
            Caption = 'Importe';
            DataClassification = CustomerContent;
            AutoFormatType = 1;
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
