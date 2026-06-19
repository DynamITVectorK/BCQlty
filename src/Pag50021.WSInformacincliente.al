page 50021 "WS Información cliente"
{
    // //***Z029 - AT - 16/01/18 - Area Privada WEB
    //                             WS1.1 - Información cliente

    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Worksheet;
    SaveValues = true;
    SourceTable = Table18;
    SourceTableView = WHERE (Bloqueado Web=FILTER(No));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No.";"No.")
                {
                    Editable = false;
                }
                field(Name;Name)
                {
                    Editable = false;
                }
                field("VAT Registration No.";"VAT Registration No.")
                {
                    Editable = false;
                }
                field(Address;Address)
                {
                    Editable = false;
                }
                field("Address 2";"Address 2")
                {
                    Editable = false;
                }
                field(City;City)
                {
                    Editable = false;
                }
                field("Post Code";"Post Code")
                {
                    Editable = false;
                }
                field(County;County)
                {
                    Editable = false;
                }
                field("Phone No.";"Phone No.")
                {
                }
                field("Fax No.";"Fax No.")
                {
                }
                field("E-mail Comunicacion";"E-mail Comunicacion")
                {
                }
                field("E-Mail";"E-Mail")
                {
                }
                field(Contact;Contact)
                {
                }
                field("Forma de pago";vPaymentMethod)
                {
                }
                field("Contraseña Web";"Contraseña Web")
                {
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
        tPaymentMethod: Record "289";
        vPaymentMethod: Text;
}

