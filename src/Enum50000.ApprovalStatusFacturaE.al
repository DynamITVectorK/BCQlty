enum 50000 "Approval Status FacturaE"
{
    Extensible = true;

    value(0; " ")
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
