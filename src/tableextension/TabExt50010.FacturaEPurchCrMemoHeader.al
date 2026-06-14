tableextension 50010 "FacturaE Purch Cr Memo Header" extends "Purch. Cr. Memo Hdr."
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
            Caption = 'Numero FacturaE';
            DataClassification = CustomerContent;
        }
    }
}
