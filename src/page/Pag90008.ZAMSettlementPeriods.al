page 90008 ZAMSettlementPeriods
{
    // Z0041GEN 13/12/21 PBS

    Caption = 'Settlement Periods';
    PageType = List;
    UsageCategory = Administration;
    SourceTable = 90002;
    SourceTableView = SORTING (ZAM_Type, ZAM_Code)
                      WHERE (ZAM_Type = FILTER (Settlement Period));

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
                field("Settlement Period"; "ZAM_Settlement Period")
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
        Rec.ZAM_Type := Rec.ZAM_Type::"Settlement Period";
        //Z0041GEN 13/12/21 PBS.FIN
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        //Z0041GEN 13/12/21 PBS.INICIO
        Rec.ZAM_Type := Rec.ZAM_Type::"Settlement Period";
        //Z0041GEN 13/12/21 PBS.FIN
    end;

    trigger OnOpenPage()
    begin
        //Z0041GEN 13/12/21 PBS.INICIO
        Rec.FILTERGROUP(100);
        Rec.SETRANGE(ZAM_Type, Rec.ZAM_Type::"Settlement Period");
        Rec.FILTERGROUP(0);
        //Z0041GEN 13/12/21 PBS.INICIO
    end;
}

