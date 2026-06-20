page 50022 "WS Bancos cliente"
{
    // //***Z029 - AT - 16/01/18 - Area Privada WEB
    //                             WS1.2 - Bancos clientes

    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    UsageCategory = Administration;
    SourceTable = Customer;
    SourceTableView = WHERE("Bloqueado Web" = FILTER(No),
                            "Contraseña Web" = FILTER(<> ''));

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
                field(IBAN; vCustomerBankAccount)
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
        Clear(vCustomerBankAccount);
        if Rec."Preferred Bank Account" <> '' then begin
            Clear(tCustomerBankAccount);
            tCustomerBankAccount.SetRange("Customer No.", Rec."No.");
            tCustomerBankAccount.SetRange(Code, Rec."Preferred Bank Account");
            if tCustomerBankAccount.FindSet() then
                vCustomerBankAccount := tCustomerBankAccount.IBAN;
        end else begin
            Clear(tCustomerBankAccount);
            tCustomerBankAccount.SetRange("Customer No.", Rec."No.");
            if tCustomerBankAccount.FindFirst() then
                vCustomerBankAccount := tCustomerBankAccount.IBAN;
        end;
    end;

    var
        tCustomerBankAccount: Record "Customer Bank Account";
        vCustomerBankAccount: Code[50];
}