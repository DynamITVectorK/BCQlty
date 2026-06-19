page 50012 "Nombres tarifa"
{
    PageType = List;
    UsageCategory = Administration;
    SourceTable = 50006;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Codigo Tarifa"; "Codigo Tarifa")
                {
                    ApplicationArea = All;
                }
                field("Descripción Tarifa"; "Descripción Tarifa")
                {
                    ApplicationArea = All;
                }
                field(Tramos; Tramos)
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

