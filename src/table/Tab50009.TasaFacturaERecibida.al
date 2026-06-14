table 50009 "Tasa FacturaE Recibida"
{
    Caption = 'Tasa FacturaE Recibida';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "ID Factura"; Text[50]) { Caption = 'ID Factura'; DataClassification = CustomerContent; }
        field(2; Linea; Integer) { Caption = 'Linea'; DataClassification = CustomerContent; }
        field(3; "Line No."; Integer) { Caption = 'Line No.'; DataClassification = CustomerContent; }
        field(4; TASA; Decimal) { Caption = 'Tasa'; DataClassification = CustomerContent; }
        field(5; RETENCION; Decimal) { Caption = 'Retencion'; DataClassification = CustomerContent; }
        field(6; "Código IVA NAV"; Code[20]) { Caption = 'Codigo IVA NAV'; DataClassification = CustomerContent; TableRelation = "VAT Product Posting Group".Code; }
        field(7; "Código IRPF NAV"; Code[20]) { Caption = 'Codigo IRPF NAV'; DataClassification = CustomerContent; }
    }

    keys
    {
        key(PK; "ID Factura", Linea, "Line No.") { Clustered = true; }
        key(LineTax; "ID Factura", Linea, TASA, RETENCION) { }
    }
}
