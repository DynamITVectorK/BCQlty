page 90012 ZAMTicketBaiSubPage
{
    PageType = ListPart;
    SourceTable = Table90003;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("ZAM_Fiscal Type"; "ZAM_Fiscal Type")
                {
                }
                field(ZAM_Base; ZAM_Base)
                {
                }
                field(ZAM_Amount; ZAM_Amount)
                {
                }
                field("ZAM_EC Type"; "ZAM_EC Type")
                {
                }
                field("ZAM_Amount EC"; "ZAM_Amount EC")
                {
                }
                field("ZAM_Subject to Ticket Bai"; "ZAM_Subject to Ticket Bai")
                {
                }
                field("ZAM_No Subject Type"; "ZAM_No Subject Type")
                {
                }
                field("ZAM_Rating of Operation Type"; "ZAM_Rating of Operation Type")
                {
                    LookupPageID = ZAMRatingOfOperationType;
                }
                field("ZAM_Cause of Exemption"; "ZAM_Cause of Exemption")
                {
                    LookupPageID = ZAMCausesOfExemption;
                }
                field("ZAM_Service to Ticket Bai"; "ZAM_Service to Ticket Bai")
                {
                }
                field("ZAM_Investment Taxpayer"; "ZAM_Investment Taxpayer")
                {
                }
                field("ZAM_Type of Purchase"; "ZAM_Type of Purchase")
                {
                    LookupPageID = ZAMTypeOfPurchase;
                }
                field("ZAM_Property Registration No."; "ZAM_Property Registration No.")
                {
                }
                field(ZAM_Situation; ZAM_Situation)
                {
                }
                field("ZAM_Real Estate No."; "ZAM_Real Estate No.")
                {
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

