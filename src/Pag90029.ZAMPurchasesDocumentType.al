page 90029 ZAMPurchasesDocumentType
{
    // Z0041GEN 13/12/21 PBS

    Caption = 'Purchases Document Type';
    PageType = List;
    SourceTable = Table90002;
    SourceTableView = SORTING (ZAM_Type, ZAM_Code)
                      WHERE (ZAM_Type = FILTER (Purchase Document Type));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; ZAM_Code)
                {
                }
                field(Description; ZAM_Description)
                {
                }
                field(Corrective; ZAM_Corrective)
                {
                }
                field(Simple; ZAM_Simple)
                {
                }
                field(Summary; ZAM_Summary)
                {
                }
                field(ZAMSimplified_doc_replacement; ZAMSimplified_doc_replacement1)
                {
                }
                field(ZAMSimplifiedRegimeEC; ZAMSimplifiedRegimeEC1)
                {
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

