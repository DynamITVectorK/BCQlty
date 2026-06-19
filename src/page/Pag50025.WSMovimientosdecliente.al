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
                field("Customer No."; Rec."Customer No.")
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = All;
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                }
                field("Remaining Amount"; Rec."Remaining Amount")
                {
                    ApplicationArea = All;
                }
                field("Due Date"; Rec."Due Date")
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

        Rec.CALCFIELDS(ClienteBloqueado,ContraseñaWeb);
        Rec.SETRANGE(ClienteBloqueado,FALSE);
        Rec.SETFILTER(ContraseñaWeb,'<>%1', '');
    end;
}

