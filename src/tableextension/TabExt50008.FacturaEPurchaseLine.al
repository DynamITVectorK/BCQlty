tableextension 50008 "FacturaE Purchase Line" extends "Purchase Line"
{
    fields
    {
        field(50007; "ID Plataforma FacturaE"; Text[50]) { Caption = 'ID Plataforma FacturaE'; DataClassification = CustomerContent; }
        field(50008; "Numero FacturaE"; Text[20]) { Caption = 'Numero FacturaE'; DataClassification = CustomerContent; }
        field(50009; "Linea FacturaE"; Integer) { Caption = 'Linea FacturaE'; DataClassification = CustomerContent; }
        field(50010; "No. expediente adjudicacion"; Text[20]) { Caption = 'No. expediente adjudicacion'; DataClassification = CustomerContent; }
        field(50011; Lote; Text[30]) { Caption = 'Lote'; DataClassification = CustomerContent; }
    }
}
