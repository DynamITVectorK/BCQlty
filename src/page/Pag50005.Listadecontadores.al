page 50005 "Lista de contadores"
{
    // //***Z005 - 400 - RG- 07/11/2016 - Gestión de contadores
    //                                     Objeto nuevo

    CardPageID = Contadores;
    Editable = false;
    PageType = List;
    SourceTable = Table50002;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No. Contador"; "No. Contador")
                {
                }
                field("No. puesto"; "No. puesto")
                {
                }
                field("Tipo contador"; "Tipo contador")
                {
                }
                field(Estado; Estado)
                {
                }
                field("No. Contrato"; "No. Contrato")
                {
                }
                field("No. Orden de lectura"; "No. Orden de lectura")
                {
                }
                field(Tarifa; Tarifa)
                {
                }
                field("% desviación +/- para aviso"; "% desviación +/- para aviso")
                {
                }
                field(Area;Area)
        {
        }
                field("Nombre cliente";"Nombre cliente")
                {
                }
                field(Destino;Destino)
                {
                }
                field(Coeficiente2;Coeficiente2)
                {
                    Editable = true;
                }
                field("Camara reserva diaria";"Camara reserva diaria")
                {
                }
                field(Condensadores;Condensadores)
                {
                }
            }
        }
        area(factboxes)
        {
            systempart(;Notes)
            {
            }
            systempart(;MyNotes)
            {
            }
            systempart(;Links)
            {
            }
        }
    }

    actions
    {
    }
}

