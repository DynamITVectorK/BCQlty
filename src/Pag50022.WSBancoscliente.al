page 50022 "WS Bancos cliente"
{
    // //***Z029 - AT - 16/01/18 - Area Privada WEB
    //                             WS1.2 - Bancos clientes

    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = Table18;
    SourceTableView = WHERE (Bloqueado Web=FILTER(No),
                            Contraseña Web=FILTER(<>''));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No.";"No.")
                {
                }
                field(IBAN;vCustomerBankAccount)
                {
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
        tCustomerBankAccount: Record "287";
        vCustomerBankAccount: Code[50];
}

