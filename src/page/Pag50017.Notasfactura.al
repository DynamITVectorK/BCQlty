page 50017 "Notas factura"
{
    // //***Z018 - 400- AT- 13/12/2016 - Posibilidad de incluir notas en facturas

    AutoSplitKey = true;
    LinksAllowed = false;
    MultipleNewLines = true;
    PageType = List;
    SourceTable = Table97;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Table Name"; "Table Name")
                {
                    Visible = false;

                    trigger OnValidate()
                    begin
                        CurrPage.SAVERECORD;
                        CurrPage.UPDATE(FALSE);
                    end;
                }
                field(Comment; Comment)
                {

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

