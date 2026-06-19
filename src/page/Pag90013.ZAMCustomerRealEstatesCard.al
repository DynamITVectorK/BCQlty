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
                field("ZAM_Customer No."; Rec."ZAM_Customer No.")
                {
                    ApplicationArea = All;
                }
                field("Real Estate No."; Rec."ZAM_Real Estate No.")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field(Description; Rec.ZAM_Description)
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Property Registration No."; Rec."ZAM_Property Registration No.")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field(Situation; Rec.ZAM_Situation)
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
            }
            group("Real Estate Address")
            {
                Caption = 'Real Estate Address';
                field(Address; Rec.ZAM_Address)
                {
                    ApplicationArea = All;
                }
                field("Address 2"; Rec."ZAM_Address 2")
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

