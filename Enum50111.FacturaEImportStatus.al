enum 50111 "FacturaE Import Status"
{
    Extensible = true;
    Caption = 'FacturaE Import Status';

    value(0; Pending)
    {
        Caption = 'Pending';
    }
    value(1; Imported)
    {
        Caption = 'Imported';
    }
    value(2; Error)
    {
        Caption = 'Error';
    }
}
