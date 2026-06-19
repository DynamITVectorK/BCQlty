page 90012 ZAMTicketBaiSubPage
{
    PageType = ListPart;
    SourceTable = 90003;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("ZAM_Fiscal Type"; "ZAM_Fiscal Type")
                {
                    ApplicationArea = All;
                }
                field(ZAM_Base; ZAM_Base)
                {
                    ApplicationArea = All;
                }
                field(ZAM_Amount; ZAM_Amount)
                {
                    ApplicationArea = All;
                }
                field("ZAM_EC Type"; "ZAM_EC Type")
                {
                    ApplicationArea = All;
                }
                field("ZAM_Amount EC"; "ZAM_Amount EC")
                {
                    ApplicationArea = All;
                }
                field("ZAM_Subject to Ticket Bai"; "ZAM_Subject to Ticket Bai")
                {
                    ApplicationArea = All;
                }
                field("ZAM_No Subject Type"; "ZAM_No Subject Type")
                {
                    ApplicationArea = All;
                }
                field("ZAM_Rating of Operation Type"; "ZAM_Rating of Operation Type")
                {
                    ApplicationArea = All;
                    LookupPageID = ZAMRatingOfOperationType;
                }
                field("ZAM_Cause of Exemption"; "ZAM_Cause of Exemption")
                {
                    ApplicationArea = All;
                    LookupPageID = ZAMCausesOfExemption;
                }
                field("ZAM_Service to Ticket Bai"; "ZAM_Service to Ticket Bai")
                {
                    ApplicationArea = All;
                }
                field("ZAM_Investment Taxpayer"; "ZAM_Investment Taxpayer")
                {
                    ApplicationArea = All;
                }
                field("ZAM_Type of Purchase"; "ZAM_Type of Purchase")
                {
                    ApplicationArea = All;
                    LookupPageID = ZAMTypeOfPurchase;
                }
                field("ZAM_Property Registration No."; "ZAM_Property Registration No.")
                {
                    ApplicationArea = All;
                }
                field(ZAM_Situation; ZAM_Situation)
                {
                    ApplicationArea = All;
                }
                field("ZAM_Real Estate No."; "ZAM_Real Estate No.")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."ZAM_Line No." := Rec.GetLineNo(Rec);
        Rec."ZAM_Line Type" := Rec."ZAM_Line Type"::Amount;
    end;
}

