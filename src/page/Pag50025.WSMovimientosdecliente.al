page 50025 "WS Movimientos de cliente"
{
    // //***Z029 - AT - 16/01/18 - Area Privada WEB
    //                             WS4 - Movimientos de cliente

    DelayedInsert = false;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    UsageCategory = Administration;
    SourceTable = "Cust. Ledger Entry";
    SourceTableView = WHERE (Document Type=FILTER(<>' '));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Customer No.";"Customer No.")
                {
                    ApplicationArea = All;
                }
                field("Posting Date";"Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Document Type";"Document Type")
                {
                    ApplicationArea = All;
                }
                field("Document No.";"Document No.")
                {
                    ApplicationArea = All;
                }
                field(Description;Description)
                {
                    ApplicationArea = All;
                }
                field(Amount;Amount)
                {
                    ApplicationArea = All;
                }
                field("Remaining Amount";"Remaining Amount")
                {
                    ApplicationArea = All;
                }
                field("Due Date";"Due Date")
                {
                    ApplicationArea = All;
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

