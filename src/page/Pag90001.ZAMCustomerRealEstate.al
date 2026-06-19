page 90001 "ZAM_CustomerRealEstate"
{
    // Z0041GEN PBS 17/21/21: TicketBai

    Caption = 'Customer Real Estates';
    CardPageID = ZAMCustomerRealEstatesCard;
    Editable = false;
    PageType = List;
    SourceTable = Table90004;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Real Estate No."; "ZAM_Real Estate No.")
                {
                }
                field(Description; ZAM_Description)
                {
                }
                field(Situation; ZAM_Situation)
                {
                    LookupPageID = ZAM_CustomerRealEstate;
                }
                field("Property Registration No."; "ZAM_Property Registration No.")
                {
                }
                field(Address; ZAM_Address)
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

