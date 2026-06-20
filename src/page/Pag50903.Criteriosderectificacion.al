page 50903 "Criterios de rectificacion"
{
    // //***Z001 -   4 - BGS - 27/04/15: Factura electronica

    Caption = 'Criterios de rectificación';
    PageType = List;
    UsageCategory = Administration;
    SourceTable = 50130;
    SourceTableView = SORTING(Tipo, Codigo)
                      WHERE(Tipo = CONST("Criterio rectificacion"));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Codigo; Rec.Codigo)
                {
                    ApplicationArea = All;
                }
                field(Descripcion; Rec.Descripcion)
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