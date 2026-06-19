page 50016 "Log Errores Facturación"
{
    // //***Z009 - 400 - RG- 24/11/2016 - Facturación automática

    Editable = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = Table50005;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Num; Num)
                {
                }
                field(Fecha; Fecha)
                {
                }
                field("Registro Asociado"; "Registro Asociado")
                {
                }
                field(Motivo; Motivo)
                {
                }
            }
        }
    }

    actions
    {
    }
}

