page 50021 "WS Información cliente"
{
    // //***Z029 - AT - 16/01/18 - Area Privada WEB
    //                             WS1.1 - Información cliente

    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Worksheet;
    UsageCategory = Administration;
    SaveValues = true;
    SourceTable = "Customer";
    SourceTableView = WHERE("Bloqueado Web" = FILTER(No));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("VAT Registration No."; Rec."VAT Registration No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Address 2"; Rec."Address 2")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(City; Rec.City)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Post Code"; Rec."Post Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(County; Rec.County)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = All;
                }
                field("Fax No."; Rec."Fax No.")
                {
                    ApplicationArea = All;
                }
                field("E-mail Comunicacion"; Rec."E-mail Comunicacion")
                {
                    ApplicationArea = All;
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ApplicationArea = All;
                }
                field(Contact; Rec.Contact)
                {
                    ApplicationArea = All;
                }
                field("Forma de pago"; vPaymentMethod)
                {
                    ApplicationArea = All;
                }
                field("Contraseña Web"; Rec."Contraseña Web")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Balance (LCY)"; Rec."Balance (LCY)")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        Rec.CalcFields("Balance (LCY)");
        Clear(tPaymentMethod);
        tPaymentMethod.Get(Rec."Payment Method Code");
        vPaymentMethod := tPaymentMethod.Description;
    end;

    var
        tPaymentMethod: Record "Payment Method";
        vPaymentMethod: Text;
}