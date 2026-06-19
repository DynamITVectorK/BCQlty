page 50006 Contadores
{
    // //***Z005 - 400 - RG- 07/11/2016 - Gestión de contadores nueva Page

    PageType = Card;
    SourceTable = Table50002;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No. Contador"; "No. Contador")
                {
                }
                field("Tipo contador"; "Tipo contador")
                {
                }
                field(Destino; Destino)
                {
                }
                field("No. puesto"; "No. puesto")
                {
                }
                field(Estado; Estado)
                {
                }
                field("No. Orden de lectura"; "No. Orden de lectura")
                {
                }
                field("No. Contrato"; "No. Contrato")
                {
                }
                field("Nombre cliente"; "Nombre cliente")
                {
                }
                field(Tarifa; Tarifa)
                {
                }
                field("% desviación +/- para aviso"; "% desviación +/- para aviso")
                {
                }
                field(Coeficiente2; Coeficiente2)
                {
                    Editable = true;
                }
                field("Camara reserva diaria"; "Camara reserva diaria")
                {
                }
                field(Condensadores; Condensadores)
                {
                    Editable = false;
                }
                field(Pabellon; Pabellon)
                {
                }
                field("Tipo Consumo"; "Tipo Consumo")
                {
                }
                field("Descripcion Ubicacion Contador"; "Descripcion Ubicacion Contador")
                {
                    MultiLine = true;
                }
            }
        }
        area(factboxes)
        {
            systempart(; Outlook)
            {
            }
            systempart(; Notes)
            {
            }
            systempart(; MyNotes)
            {
            }
            systempart(; Links)
            {
            }
        }
    }

    actions
    {
        area(creation)
        {
            group()
            {
                action("Histórico de Lecturas")
                {
                    Image = History;
                    Promoted = true;
                    PromotedIsBig = true;
                    RunObject = Page 50007;
                    RunPageLink = No. Contador=FIELD(No. Contador);
                }
            }
        }
    }
}

