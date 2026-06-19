page 50022 "WS Bancos cliente"
{
    // //***Z029 - AT - 16/01/18 - Area Privada WEB
    //                             WS1.2 - Bancos clientes

    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    UsageCategory = Administration;
    SourceTable = "Customer";
    SourceTableView = WHERE (Bloqueado Web=FILTER(No),
                            Contraseña Web=FILTER(<>''));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(IBAN; Rec.vCustomerBankAccount)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        CLEAR(vCustomerBankAccount);
        IF "Preferred Bank Account" <> '' THEN BEGIN
          CLEAR(tCustomerBankAccount);
          tCustomerBankAccount.SETRANGE("Customer No.","No.");
          tCustomerBankAccount.SETRANGE(Code,"Preferred Bank Account");
          IF tCustomerBankAccount.FINDSET THEN
             vCustomerBankAccount := tCustomerBankAccount.IBAN;

        END ELSE BEGIN
          CLEAR(tCustomerBankAccount);
          tCustomerBankAccount.SETRANGE("Customer No.","No.");
          IF tCustomerBankAccount.FINDFIRST THEN
             vCustomerBankAccount := tCustomerBankAccount.IBAN

        END;
    end;

    var
        tCustomerBankAccount: Record "Customer Bank Account";
        vCustomerBankAccount: Code[50];
}

