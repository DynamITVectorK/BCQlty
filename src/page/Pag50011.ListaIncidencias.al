page 50011 "Lista Incidencias"
{
    // //***Z006 - 400 - RG- 07/11/2016 - Gestión de incidencias

    CardPageID = "Ficha de Incidencias";
    Editable = false;
    PageType = List;
    SourceTable = Table50004;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No. incidencia"; "No. incidencia")
                {
                }
                field("No. Contador"; "No. Contador")
                {
                }
                field("Tipo incidencia"; "Tipo incidencia")
                {
                }
                field("Área incidencia"; "Área incidencia")
                {
                }
                field("Nombre cliente"; "Nombre cliente")
                {
                }
                field("No. Puesto/Pabellón"; "No. Puesto/Pabellón")
                {
                }
                field("No. contrato"; "No. contrato")
                {
                }
            }
        }
    }

    actions
    {
    }
}

