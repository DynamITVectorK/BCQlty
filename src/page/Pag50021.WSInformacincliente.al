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
    SourceTableView = WHERE (Bloqueado Web=FILTER(No));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No.";"No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Name;Name)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("VAT Registration No.";"VAT Registration No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Address;Address)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Address 2";"Address 2")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(City;City)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Post Code";"Post Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(County;County)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Phone No.";"Phone No.")
                {
                    ApplicationArea = All;
                }
                field("Fax No.";"Fax No.")
                {
                    ApplicationArea = All;
                }
                field("E-mail Comunicacion";"E-mail Comunicacion")
                {
                    ApplicationArea = All;
                }
                field("E-Mail";"E-Mail")
                {
                    ApplicationArea = All;
                }
                field(Contact;Contact)
                {
                    ApplicationArea = All;
                }
                field("Forma de pago";vPaymentMethod)
                {
                    ApplicationArea = All;
                }
                field("Contraseña Web";"Contraseña Web")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Balance (LCY)";"Balance (LCY)")
                {
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
        CALCFIELDS("Balance (LCY)");
        CLEAR(tPaymentMethod);
        tPaymentMethod.GET("Payment Method Code");
        vPaymentMethod := tPaymentMethod.Description;
    end;

    var
        tPaymentMethod: Record "Payment Method";
        vPaymentMethod: Text;
}

