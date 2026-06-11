tableextension 50008 "Purch. Inv. Header FacturaE" extends "Purch. Inv. Header"
{
    fields
    {
        field(50007; "ID Plataforma FacturaE"; Text[50])
        {
            Caption = 'ID Plataforma FacturaE';
            DataClassification = CustomerContent;
        }
        field(50008; "Numero FacturaE"; Text[20])
        {
            Caption = 'Número FacturaE';
            DataClassification = CustomerContent;
        }
    }
}
