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
                field("Codigo Tarifa"; Rec."Codigo Tarifa")
                {
                    ApplicationArea = All;
                }
                field("Descripción Tarifa"; Rec."Descripción Tarifa")
                {
                    ApplicationArea = All;
                }
                field(Tramos; Rec.Tramos)
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

