page 50025 "WS Movimientos de cliente"
{
    // //***Z029 - AT - 16/01/18 - Area Privada WEB
    //                             WS4 - Movimientos de cliente

    PageType = API;
    SourceTable = "Cust. Ledger Entry";
    SourceTableView = WHERE("Document Type" = FILTER(<> ' '));
    DelayedInsert = true;
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;
    Editable = false;
    Extensible = false;

    APIPublisher = 'zamundi';
    APIGroup = 'privateweb';
    APIVersion = 'v1.0';
    EntityName = 'customerLedgerMovement';
    EntitySetName = 'customerLedgerMovements';
    ODataKeyFields = SystemId;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(id; Rec.SystemId)
                {
                    Caption = 'Id';
                    Editable = false;
                }
                field(customerNo; Rec."Customer No.")
                {
                    Caption = 'Customer No.';
                    Editable = false;
                }
                field(postingDate; Rec."Posting Date")
                {
                    Caption = 'Posting Date';
                    Editable = false;
                }
                field(documentType; Rec."Document Type")
                {
                    Caption = 'Document Type';
                    Editable = false;
                }
                field(documentNo; Rec."Document No.")
                {
                    Caption = 'Document No.';
                    Editable = false;
                }
                field(description; Rec.Description)
                {
                    Caption = 'Description';
                    Editable = false;
                }
                field(amount; Rec.Amount)
                {
                    Caption = 'Amount';
                    Editable = false;
                }
                field(remainingAmount; Rec."Remaining Amount")
                {
                    Caption = 'Remaining Amount';
                    Editable = false;
                }
                field(dueDate; Rec."Due Date")
                {
                    Caption = 'Due Date';
                    Editable = false;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.CalcFields(ClienteBloqueado, ContraseñaWeb);
        Rec.SetRange(ClienteBloqueado, false);
        Rec.SetFilter(ContraseñaWeb, '<>%1', '');
    end;
}