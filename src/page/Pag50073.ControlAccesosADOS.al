page 50073 "Control Accesos ADOS"
{
    PageType = List;
    UsageCategory = Administration;
    SourceTable = 50015;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Fecha; Fecha)
                {
                    ApplicationArea = All;
                }
                field(Tique; Tique)
                {
                    ApplicationArea = All;
                }
                field(Sesion; Sesion)
                {
                    ApplicationArea = All;
                }
                field(Tratado; Tratado)
                {
                    ApplicationArea = All;
                }
                field(FechaTratado; FechaTratado)
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

