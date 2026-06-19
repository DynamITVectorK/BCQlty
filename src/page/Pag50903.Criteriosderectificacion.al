page 50903 "Criterios de rectificacion"
{
    // //***Z001 -   4 - BGS - 27/04/15: Factura electrónica: generación, firma, subida y actualización

    Caption = 'Criterios de rectificación';
    PageType = List;
    UsageCategory = Administration;
    SourceTable = 50130;
    SourceTableView = SORTING (Tipo, Codigo)
                      WHERE (Tipo = CONST (Criterio rectificacion));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Codigo; Codigo)
                {
                    ApplicationArea = All;
                }
                field(Descripcion; Descripcion)
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

