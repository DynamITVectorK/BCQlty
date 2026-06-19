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
                field("No. Contador"; Rec."No. Contador")
                {
                    ApplicationArea = All;
                }
                field("No. puesto"; Rec."No. puesto")
                {
                    ApplicationArea = All;
                }
                field("Tipo contador"; Rec."Tipo contador")
                {
                    ApplicationArea = All;
                }
                field(Estado; Rec.Estado)
                {
                    ApplicationArea = All;
                }
                field("No. Contrato"; Rec."No. Contrato")
                {
                    ApplicationArea = All;
                }
                field("No. Orden de lectura"; Rec."No. Orden de lectura")
                {
                    ApplicationArea = All;
                }
                field(Tarifa; Rec.Tarifa)
                {
                    ApplicationArea = All;
                }
                field("% desviación +/- para aviso"; Rec."% desviación +/- para aviso")
                {
                    ApplicationArea = All;
                }
                field(Area; Rec.Area)
        {
            ApplicationArea = All;
        }
                field("Nombre cliente"; Rec."Nombre cliente")
                {
                    ApplicationArea = All;
                }
                field(Destino; Rec.Destino)
                {
                    ApplicationArea = All;
                }
                field(Coeficiente2; Rec.Coeficiente2)
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Camara reserva diaria"; Rec."Camara reserva diaria")
                {
                    ApplicationArea = All;
                }
                field(Condensadores; Rec.Condensadores)
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

