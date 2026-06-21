page 50022 "WS Bancos cliente"
{
    // //***Z029 - AT - 16/01/18 - Area Privada WEB
    //                             WS1.2 - Bancos clientes

    PageType = API;
    SourceTable = Customer;
    SourceTableView = WHERE("Bloqueado Web" = FILTER(No),
                            "Contraseña Web" = FILTER(<> ''));
    DelayedInsert = true;
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;
    Editable = false;
    Extensible = false;

    APIPublisher = 'zamundi';
    APIGroup = 'privateweb';
    APIVersion = 'v1.0';
    EntityName = 'customerBank';
    EntitySetName = 'customerBanks';
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
                field(no; Rec."No.")
                {
                    Caption = 'No.';
                    Editable = false;
                }
                field(iban; CustomerBankAccountIBAN)
                {
                    Caption = 'IBAN';
                    Editable = false;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        Clear(CustomerBankAccountIBAN);

        if Rec."Preferred Bank Account" <> '' then begin
            Clear(CustomerBankAccount);
            CustomerBankAccount.SetRange("Customer No.", Rec."No.");
            CustomerBankAccount.SetRange(Code, Rec."Preferred Bank Account");
            if CustomerBankAccount.FindSet() then
                CustomerBankAccountIBAN := CustomerBankAccount.IBAN;
        end else begin
            Clear(CustomerBankAccount);
            CustomerBankAccount.SetRange("Customer No.", Rec."No.");
            if CustomerBankAccount.FindFirst() then
                CustomerBankAccountIBAN := CustomerBankAccount.IBAN;
        end;
    end;

    var
        CustomerBankAccount: Record "Customer Bank Account";
        CustomerBankAccountIBAN: Code[50];
}