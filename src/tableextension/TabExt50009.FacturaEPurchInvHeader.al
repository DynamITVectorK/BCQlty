tableextension 50009 "FacturaE Purch Inv Header" extends "Purch. Inv. Header"
{
    fields
    {
        field(50007; "ID Plataforma FacturaE"; Text[50]) { Caption = 'ID Plataforma FacturaE'; DataClassification = CustomerContent; }
        field(50008; "Numero FacturaE"; Text[20]) { Caption = 'Numero FacturaE'; DataClassification = CustomerContent; }
    }
}
