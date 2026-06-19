page 90029 ZAMPurchasesDocumentType
{
    // Z0041GEN 13/12/21 PBS

    Caption = 'Purchases Document Type';
    PageType = List;
    UsageCategory = Administration;
    SourceTable = 90002;
    SourceTableView = SORTING (ZAM_Type, ZAM_Code)
                      WHERE (ZAM_Type = FILTER (Purchase Document Type));

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
                field(Corrective; Rec.ZAM_Corrective)
                {
                    ApplicationArea = All;
                }
                field(Simple; Rec.ZAM_Simple)
                {
                    ApplicationArea = All;
                }
                field(Summary; Rec.ZAM_Summary)
                {
                    ApplicationArea = All;
                }
                field(ZAMSimplified_doc_replacement; Rec.ZAMSimplified_doc_replacement1)
                {
                    ApplicationArea = All;
                }
                field(ZAMSimplifiedRegimeEC; Rec.ZAMSimplifiedRegimeEC1)
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
        Rec.ZAM_Type := Rec.ZAM_Type::"Purchase Document Type";
        //Z0041GEN 13/12/21 PBS.FIN
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        //Z0041GEN 13/12/21 PBS.INICIO
        Rec.ZAM_Type := Rec.ZAM_Type::"Purchase Document Type";
        //Z0041GEN 13/12/21 PBS.FIN
    end;

    trigger OnOpenPage()
    begin
        //Z0041GEN 13/12/21 PBS.INICIO
        Rec.FILTERGROUP(100);
        Rec.SETRANGE(ZAM_Type, Rec.ZAM_Type::"Purchase Document Type");
        Rec.FILTERGROUP(0);
        //Z0041GEN 13/12/21 PBS.INICIO
    end;
}

