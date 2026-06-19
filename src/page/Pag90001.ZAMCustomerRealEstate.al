page 90001 "ZAM_CustomerRealEstate"
{
    // Z0041GEN PBS 17/21/21: TicketBai

    Caption = 'Customer Real Estates';
    CardPageID = ZAMCustomerRealEstatesCard;
    Editable = false;
    PageType = List;
    UsageCategory = Administration;
    SourceTable = 90004;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Real Estate No."; "ZAM_Real Estate No.")
                {
                    ApplicationArea = All;
                }
                field(Description; ZAM_Description)
                {
                    ApplicationArea = All;
                }
                field(Situation; ZAM_Situation)
                {
                    ApplicationArea = All;
                    LookupPageID = ZAM_CustomerRealEstate;
                }
                field("Property Registration No."; "ZAM_Property Registration No.")
                {
                    ApplicationArea = All;
                }
                field(Address; ZAM_Address)
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
                }
            }
        }
        area(factboxes)
        {
            systempart(; Links)
            {
            }
            systempart(; Notes)
            {
            }
        }
    }

    actions
    {
    }
}

