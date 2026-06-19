page 50005 "Lista de contadores"
{
    // //***Z005 - 400 - RG- 07/11/2016 - Gestión de contadores
    //                                     Objeto nuevo

    CardPageID = Contadores;
    Editable = false;
    PageType = List;
    UsageCategory = Administration;
    SourceTable = 50002;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No. Contador"; "No. Contador")
                {
                    ApplicationArea = All;
                }
                field("No. puesto"; "No. puesto")
                {
                    ApplicationArea = All;
                }
                field("Tipo contador"; "Tipo contador")
                {
                    ApplicationArea = All;
                }
                field(Estado; Estado)
                {
                    ApplicationArea = All;
                }
                field("No. Contrato"; "No. Contrato")
                {
                    ApplicationArea = All;
                }
                field("No. Orden de lectura"; "No. Orden de lectura")
                {
                    ApplicationArea = All;
                }
                field(Tarifa; Tarifa)
                {
                    ApplicationArea = All;
                }
                field("% desviación +/- para aviso"; "% desviación +/- para aviso")
                {
                    ApplicationArea = All;
                }
                field(Area;Area)
        {
            ApplicationArea = All;
        }
                field("Nombre cliente";"Nombre cliente")
                {
                    ApplicationArea = All;
                }
                field(Destino;Destino)
                {
                    ApplicationArea = All;
                }
                field(Coeficiente2;Coeficiente2)
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Camara reserva diaria";"Camara reserva diaria")
                {
                    ApplicationArea = All;
                }
                field(Condensadores;Condensadores)
                {
                    ApplicationArea = All;
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

