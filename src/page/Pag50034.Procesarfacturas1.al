page 50034 "Procesar facturas1"
{
    CardPageID = "proceso de factura";
    PageType = List;
    UsageCategory = Administration;
    SourceTable = 2000000026;
    SourceTableView = SORTING (Number)
                      ORDER(Ascending)
                      WHERE (Number = FILTER (1));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Number; Number)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

