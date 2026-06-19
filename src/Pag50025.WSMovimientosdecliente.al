page 50025 "WS Movimientos de cliente"
{
    // //***Z029 - AT - 16/01/18 - Area Privada WEB
    //                             WS4 - Movimientos de cliente

    DelayedInsert = false;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = Table21;
    SourceTableView = WHERE (Document Type=FILTER(<>' '));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Customer No.";"Customer No.")
                {
                }
                field("Posting Date";"Posting Date")
                {
                }
                field("Document Type";"Document Type")
                {
                }
                field("Document No.";"Document No.")
                {
                }
                field(Description;Description)
                {
                }
                field(Amount;Amount)
                {
                }
                field("Remaining Amount";"Remaining Amount")
                {
                }
                field("Due Date";"Due Date")
                {
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin

        CALCFIELDS(ClienteBloqueado,ContraseñaWeb);
        SETRANGE(ClienteBloqueado,FALSE);
        SETFILTER(ContraseñaWeb,'<>%1', '');
    end;
}

