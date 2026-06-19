page 50011 "Lista Incidencias"
{
    // //***Z006 - 400 - RG- 07/11/2016 - Gestión de incidencias

    CardPageID = "Ficha de Incidencias";
    Editable = false;
    PageType = List;
    UsageCategory = Administration;
    SourceTable = 50004;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No. incidencia"; "No. incidencia")
                {
                    ApplicationArea = All;
                }
                field("No. Contador"; "No. Contador")
                {
                    ApplicationArea = All;
                }
                field("Tipo incidencia"; "Tipo incidencia")
                {
                    ApplicationArea = All;
                }
                field("Área incidencia"; "Área incidencia")
                {
                    ApplicationArea = All;
                }
                field("Nombre cliente"; "Nombre cliente")
                {
                    ApplicationArea = All;
                }
                field("No. Puesto/Pabellón"; "No. Puesto/Pabellón")
                {
                    ApplicationArea = All;
                }
                field("No. contrato"; "No. contrato")
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

