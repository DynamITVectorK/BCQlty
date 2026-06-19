page 50006 Contadores
{
    // //***Z005 - 400 - RG- 07/11/2016 - Gestión de contadores nueva Page

    PageType = Card;
    UsageCategory = Administration;
    SourceTable = 50002;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No. Contador"; "No. Contador")
                {
                    ApplicationArea = All;
                }
                field("Tipo contador"; "Tipo contador")
                {
                    ApplicationArea = All;
                }
                field(Destino; Destino)
                {
                    ApplicationArea = All;
                }
                field("No. puesto"; "No. puesto")
                {
                    ApplicationArea = All;
                }
                field(Estado; Estado)
                {
                    ApplicationArea = All;
                }
                field("No. Orden de lectura"; "No. Orden de lectura")
                {
                    ApplicationArea = All;
                }
                field("No. Contrato"; "No. Contrato")
                {
                    ApplicationArea = All;
                }
                field("Nombre cliente"; "Nombre cliente")
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
                field(Coeficiente2; Coeficiente2)
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Camara reserva diaria"; "Camara reserva diaria")
                {
                    ApplicationArea = All;
                }
                field(Condensadores; Condensadores)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Pabellon; Pabellon)
                {
                    ApplicationArea = All;
                }
                field("Tipo Consumo"; "Tipo Consumo")
                {
                    ApplicationArea = All;
                }
                field("Descripcion Ubicacion Contador"; "Descripcion Ubicacion Contador")
                {
                    ApplicationArea = All;
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
                    ApplicationArea = All;
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

