page 50073 "Control Accesos ADOS"
{
    Caption = 'Control Accesos ADOS';
    PageType = List;
    UsageCategory = Administration;
    SourceTable = 50015;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Fecha; Rec.Fecha)
                {
                    ApplicationArea = All;
                }
                field(Tique; Rec.Tique)
                {
                    ApplicationArea = All;
                }
                field(Sesion; Rec.Sesion)
                {
                    ApplicationArea = All;
                }
                field(Tratado; Rec.Tratado)
                {
                    ApplicationArea = All;
                }
                field(FechaTratado; Rec.FechaTratado)
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