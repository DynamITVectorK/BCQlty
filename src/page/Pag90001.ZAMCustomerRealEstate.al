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
                field("Real Estate No."; Rec."ZAM_Real Estate No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.ZAM_Description)
                {
                    ApplicationArea = All;
                }
                field(Situation; Rec.ZAM_Situation)
                {
                    ApplicationArea = All;
                    LookupPageID = ZAM_CustomerRealEstate;
                }
                field("Property Registration No."; Rec."ZAM_Property Registration No.")
                {
                    ApplicationArea = All;
                }
                field(Address; Rec.ZAM_Address)
                {
                    ApplicationArea = All;
                }
                field(City; Rec.ZAM_City)
                {
                    ApplicationArea = All;
                }
                field("Post Code"; Rec."ZAM_Post Code")
                {
                    ApplicationArea = All;
                }
                field(County; Rec.ZAM_County)
                {
                    ApplicationArea = All;
                }
                field("Country/Region Code"; Rec."ZAM_Country/Region Code")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
            systempart(Links; Links)
            {
                ApplicationArea = All;
            }
            systempart(Notes; Notes)
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
    }
}