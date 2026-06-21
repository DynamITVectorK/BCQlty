page 50021 "WS Información cliente"
{
    // //***Z029 - AT - 16/01/18 - Area Privada WEB
    //                             WS1.1 - Información cliente

    PageType = API;
    SourceTable = Customer;
    SourceTableView = WHERE("Bloqueado Web" = FILTER(No));
    DelayedInsert = true;
    InsertAllowed = false;
    DeleteAllowed = false;
    Extensible = false;

    APIPublisher = 'zamundi';
    APIGroup = 'privateweb';
    APIVersion = 'v1.0';
    EntityName = 'customerInformation';
    EntitySetName = 'customerInformations';
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
                field(name; Rec.Name)
                {
                    Caption = 'Name';
                    Editable = false;
                }
                field(vatRegistrationNo; Rec."VAT Registration No.")
                {
                    Caption = 'VAT Registration No.';
                    Editable = false;
                }
                field(address; Rec.Address)
                {
                    Caption = 'Address';
                    Editable = false;
                }
                field(address2; Rec."Address 2")
                {
                    Caption = 'Address 2';
                    Editable = false;
                }
                field(city; Rec.City)
                {
                    Caption = 'City';
                    Editable = false;
                }
                field(postCode; Rec."Post Code")
                {
                    Caption = 'Post Code';
                    Editable = false;
                }
                field(county; Rec.County)
                {
                    Caption = 'County';
                    Editable = false;
                }
                field(phoneNo; Rec."Phone No.")
                {
                    Caption = 'Phone No.';
                }
                field(faxNo; Rec."Fax No.")
                {
                    Caption = 'Fax No.';
                }
                field(emailComunicacion; Rec."E-mail Comunicacion")
                {
                    Caption = 'E-mail Comunicacion';
                }
                field(email; Rec."E-Mail")
                {
                    Caption = 'E-Mail';
                }
                field(contact; Rec.Contact)
                {
                    Caption = 'Contact';
                }
                field(formaDePago; PaymentMethodDescription)
                {
                    Caption = 'Forma de pago';
                    Editable = false;
                }
                field(balanceLCY; Rec."Balance (LCY)")
                {
                    Caption = 'Balance (LCY)';
                    Editable = false;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        Rec.CalcFields("Balance (LCY)");

        Clear(PaymentMethod);
        PaymentMethod.Get(Rec."Payment Method Code");
        PaymentMethodDescription := PaymentMethod.Description;
    end;

    var
        PaymentMethod: Record "Payment Method";
        PaymentMethodDescription: Text;
}