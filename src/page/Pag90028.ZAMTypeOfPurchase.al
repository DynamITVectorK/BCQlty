page 90028 ZAMTypeOfPurchase
{
    // Z0041GEN 13/12/21 PBS

    Caption = 'ZAMTypeOfPurchase';
    PageType = List;
    UsageCategory = Administration;
    SourceTable = 90002;
    SourceTableView = SORTING (ZAM_Type, ZAM_Code)
                      WHERE (ZAM_Type = FILTER (Type of purchase));

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(ZAM_Code; ZAM_Code)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field(ZAM_Description; ZAM_Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
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
        Rec.ZAM_Type := Rec.ZAM_Type::"Type of purchase";
        //Z0041GEN 13/12/21 PBS.FIN
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        //Z0041GEN 13/12/21 PBS.INICIO
        Rec.ZAM_Type := Rec.ZAM_Type::"Type of purchase";
        //Z0041GEN 13/12/21 PBS.FIN
    end;

    trigger OnOpenPage()
    begin
        //Z0041GEN 13/12/21 PBS.INICIO
        Rec.FILTERGROUP(100);
        Rec.SETRANGE(ZAM_Type, Rec.ZAM_Type::"Type of purchase");
        Rec.FILTERGROUP(0);
        //Z0041GEN 13/12/21 PBS.INICIO
    end;
}

