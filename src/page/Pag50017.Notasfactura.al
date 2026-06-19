page 50017 "Notas factura"
{
    // //***Z018 - 400- AT- 13/12/2016 - Posibilidad de incluir notas en facturas

    AutoSplitKey = true;
    LinksAllowed = false;
    MultipleNewLines = true;
    PageType = List;
    UsageCategory = Administration;
    SourceTable = "Comment Line";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Table Name"; Rec."Table Name")
                {
                    ApplicationArea = All;
                    Visible = false;

                    trigger OnValidate()
                    begin
                        CurrPage.SAVERECORD;
                        CurrPage.UPDATE(FALSE);
                    end;
                }
                field(Comment; Rec.Comment)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        CurrPage.SAVERECORD;
                        CurrPage.UPDATE(FALSE);
                    end;
                }
            }
        }
    }

    actions
    {
    }
}

