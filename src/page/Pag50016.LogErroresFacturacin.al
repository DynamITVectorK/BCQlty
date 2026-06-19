page 50016 "Log Errores Facturación"
{
    // //***Z009 - 400 - RG- 24/11/2016 - Facturación automática

    Editable = false;
    InsertAllowed = false;
    PageType = List;
    UsageCategory = Administration;
    SourceTable = 50005;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Num; Num)
                {
                    ApplicationArea = All;
                }
                field(Fecha; Fecha)
                {
                    ApplicationArea = All;
                }
                field("Registro Asociado"; "Registro Asociado")
                {
                    ApplicationArea = All;
                }
                field(Motivo; Motivo)
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

