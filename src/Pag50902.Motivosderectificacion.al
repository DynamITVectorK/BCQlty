page 50902 "Motivos de rectificacion"
{
    // //***Z001 -   4 - BGS - 27/04/15: Factura electrónica: generación, firma, subida y actualización

    Caption = 'Motivos de rectificación';
    PageType = List;
    SourceTable = Table50130;
    SourceTableView = SORTING (Tipo, Codigo)
                      WHERE (Tipo = CONST (Motivo rectificacion));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Codigo; Codigo)
                {
                }
                field(Descripcion; Descripcion)
                {
                }
            }
        }
    }

    actions
    {
    }
}

