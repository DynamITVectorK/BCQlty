page 90023 ZAMIntracomTransType
{
    // Z0041GEN 13/12/21 PBS

    Caption = 'Intracom. Trans. Type';
    PageType = List;
    UsageCategory = Administration;
    SourceTable = 90002;
    SourceTableView = SORTING(ZAM_Type, ZAM_Code)
                      WHERE(ZAM_Type = FILTER("Intracom. Trans. Type"));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.ZAM_Code)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.ZAM_Description)
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

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        //Z0041GEN 13/12/21 PBS.INICIO
        Rec.ZAM_Type := Rec.ZAM_Type::"Intracom. Trans. Type";
        //Z0041GEN 13/12/21 PBS.FIN
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        //Z0041GEN 13/12/21 PBS.INICIO
        Rec.ZAM_Type := Rec.ZAM_Type::"Intracom. Trans. Type";
        //Z0041GEN 13/12/21 PBS.FIN
    end;

    trigger OnOpenPage()
    begin
        //Z0041GEN 13/12/21 PBS.INICIO
        Rec.FilterGroup(100);
        Rec.SetRange(ZAM_Type, Rec.ZAM_Type::"Intracom. Trans. Type");
        Rec.FilterGroup(0);
        //Z0041GEN 13/12/21 PBS.INICIO
    end;
}