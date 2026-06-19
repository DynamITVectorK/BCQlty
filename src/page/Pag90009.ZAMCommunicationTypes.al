page 90009 ZAMCommunicationTypes
{
    // Z0041GEN 13/12/21 PBS

    Caption = 'Communication Types';
    PageType = List;
    UsageCategory = Administration;
    SourceTable = 90002;
    SourceTableView = SORTING (ZAM_Type, ZAM_Code)
                      WHERE (ZAM_Type = FILTER (Communication Type));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; ZAM_Code)
                {
                    ApplicationArea = All;
                }
                field(Description; ZAM_Description)
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

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        //Z0041GEN 13/12/21 PBS.INICIO
        Rec.ZAM_Type := Rec.ZAM_Type::"Communication Type";
        //Z0041GEN 13/12/21 PBS.FIN
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        //Z0041GEN 13/12/21 PBS.INICIO
        Rec.ZAM_Type := Rec.ZAM_Type::"Communication Type";
        //Z0041GEN 13/12/21 PBS.FIN
    end;

    trigger OnOpenPage()
    begin
        //Z0041GEN 13/12/21 PBS.INICIO
        Rec.FILTERGROUP(100);
        Rec.SETRANGE(ZAM_Type, Rec.ZAM_Type::"Communication Type");
        Rec.FILTERGROUP(0);
        //Z0041GEN 13/12/21 PBS.INICIO
    end;
}

