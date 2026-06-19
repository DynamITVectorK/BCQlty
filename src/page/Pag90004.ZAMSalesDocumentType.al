page 90004 ZAMSalesDocumentType
{
    // Z0041GEN 13/12/21 PBS

    Caption = 'Sales Document Type';
    PageType = List;
    UsageCategory = Administration;
    SourceTable = 90002;
    SourceTableView = SORTING (ZAM_Type, ZAM_Code)
                      WHERE (ZAM_Type = FILTER (Sales Document Type));

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
                field(Corrective; ZAM_Corrective)
                {
                    ApplicationArea = All;
                }
                field(Simple; ZAM_Simple)
                {
                    ApplicationArea = All;
                }
                field(Summary; ZAM_Summary)
                {
                    ApplicationArea = All;
                }
                field(ZAMSimplified_doc_replacement; ZAMSimplified_doc_replacement1)
                {
                    ApplicationArea = All;
                }
                field(ZAMSimplifiedRegimeEC; ZAMSimplifiedRegimeEC1)
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
        Rec.ZAM_Type := Rec.ZAM_Type::"Sales Document Type";
        //Z0041GEN 13/12/21 PBS.FIN
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        //Z0041GEN 13/12/21 PBS.INICIO
        Rec.ZAM_Type := Rec.ZAM_Type::"Sales Document Type";
        //Z0041GEN 13/12/21 PBS.FIN
    end;

    trigger OnOpenPage()
    begin
        //Z0041GEN 13/12/21 PBS.INICIO
        Rec.FILTERGROUP(100);
        Rec.SETRANGE(ZAM_Type, Rec.ZAM_Type::"Sales Document Type");
        Rec.FILTERGROUP(0);
        //Z0041GEN 13/12/21 PBS.INICIO
    end;
}

