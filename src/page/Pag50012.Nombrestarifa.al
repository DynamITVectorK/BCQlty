page 50012 "Nombres tarifa"
{
    PageType = List;
    SourceTable = Table50006;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Codigo Tarifa"; "Codigo Tarifa")
                {
                }
                field("Descripción Tarifa"; "Descripción Tarifa")
                {
                }
                field(Tramos; Tramos)
                {
                }
            }
        }
    }

    actions
    {
    }
}

