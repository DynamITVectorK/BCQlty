page 90013 ZAMCustomerRealEstatesCard
{
    // Z0041GEN PBS 17/12/21: TicketBai.

    Caption = 'Customer Real Estate Card';
    PageType = Card;
    SourceTable = Table90004;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("ZAM_Customer No."; "ZAM_Customer No.")
                {
                }
                field("Real Estate No."; "ZAM_Real Estate No.")
                {
                    ShowMandatory = true;
                }
                field(Description; ZAM_Description)
                {
                    ShowMandatory = true;
                }
                field("Property Registration No."; "ZAM_Property Registration No.")
                {
                    ShowMandatory = true;
                }
                field(Situation; ZAM_Situation)
                {
                    ShowMandatory = true;
                }
            }
            group("Real Estate Address")
            {
                Caption = 'Real Estate Address';
                field(Address; ZAM_Address)
                {
                }
                field("Address 2"; "ZAM_Address 2")
                {
                }
                field(City; ZAM_City)
                {
                }
                field("Post Code"; "ZAM_Post Code")
                {
                }
                field(County; ZAM_County)
                {
                }
                field("Country/Region Code"; "ZAM_Country/Region Code")
                {
                    ShowMandatory = true;
                }
            }
        }
        area(factboxes)
        {
            systempart(; Notes)
            {
            }
            systempart(; Links)
            {
            }
        }
    }

    actions
    {
    }
}

