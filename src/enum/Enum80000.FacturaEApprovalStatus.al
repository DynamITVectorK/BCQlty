enum 80000 "FacturaE Approval Status"
{
    Extensible = true;
    Caption = 'FacturaE Approval Status';

    value(0; Blank)
    {
        Caption = ' ';
    }
    value(1; "Approval Pending")
    {
        Caption = 'Approval Pending';
    }
    value(2; Approved)
    {
        Caption = 'Approved';
    }
    value(3; Rejected)
    {
        Caption = 'Rejected';
    }
}
