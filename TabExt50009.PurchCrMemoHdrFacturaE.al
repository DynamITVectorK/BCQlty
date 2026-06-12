tableextension 50009 "Purch. Cr. Memo Hdr. FactE" extends "Purch. Cr. Memo Hdr."
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
