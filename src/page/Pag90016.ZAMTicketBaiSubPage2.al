page 90016 ZAMTicketBaiSubPage2
{
    DeleteAllowed = false;
    PageType = ListPart;
    SourceTable = Table90003;
    SourceTableView = SORTING (ZAM_Company, ZAM_Type, ZAM_Document No., ZAM_Line No.)
                      WHERE (ZAM_Line Type=FILTER(Real Estate));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("ZAM_Real Estate No.";"ZAM_Real Estate No.")
                {
                }
                field("ZAM_Property Registration No.";"ZAM_Property Registration No.")
                {
                }
                field(ZAM_Situation;ZAM_Situation)
                {
                    LookupPageID = ZAMRealEstateSituation;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."ZAM_Line No." := Rec.GetLineNo(Rec);
        Rec."ZAM_Line Type" := Rec."ZAM_Line Type"::"Real Estate";
    end;
}

