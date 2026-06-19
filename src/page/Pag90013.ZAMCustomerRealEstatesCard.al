page 90013 ZAMCustomerRealEstatesCard
{
    // Z0041GEN PBS 17/12/21: TicketBai.

    Caption = 'Customer Real Estate Card';
    PageType = Card;
    UsageCategory = Administration;
    SourceTable = 90004;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("ZAM_Customer No."; "ZAM_Customer No.")
                {
                    ApplicationArea = All;
                }
                field("Real Estate No."; "ZAM_Real Estate No.")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field(Description; ZAM_Description)
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Property Registration No."; "ZAM_Property Registration No.")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field(Situation; ZAM_Situation)
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
            }
            group("Real Estate Address")
            {
                Caption = 'Real Estate Address';
                field(Address; ZAM_Address)
                {
                    ApplicationArea = All;
                }
                field("Address 2"; "ZAM_Address 2")
                {
                    ApplicationArea = All;
                }
                field(City; ZAM_City)
                {
                    ApplicationArea = All;
                }
                field("Post Code"; "ZAM_Post Code")
                {
                    ApplicationArea = All;
                }
                field(County; ZAM_County)
                {
                    ApplicationArea = All;
                }
                field("Country/Region Code"; "ZAM_Country/Region Code")
                {
                    ApplicationArea = All;
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

