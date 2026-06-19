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
                field("No. Contador"; Rec."No. Contador")
                {
                    ApplicationArea = All;
                }
                field("Tipo contador"; Rec."Tipo contador")
                {
                    ApplicationArea = All;
                }
                field(Destino; Rec.Destino)
                {
                    ApplicationArea = All;
                }
                field("No. puesto"; Rec."No. puesto")
                {
                    ApplicationArea = All;
                }
                field(Estado; Rec.Estado)
                {
                    ApplicationArea = All;
                }
                field("No. Orden de lectura"; Rec."No. Orden de lectura")
                {
                    ApplicationArea = All;
                }
                field("No. Contrato"; Rec."No. Contrato")
                {
                    ApplicationArea = All;
                }
                field("Nombre cliente"; Rec."Nombre cliente")
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
                    Editable = false;
                }
                field(Pabellon; Rec.Pabellon)
                {
                    ApplicationArea = All;
                }
                field("Tipo Consumo"; Rec."Tipo Consumo")
                {
                    ApplicationArea = All;
                }
                field("Descripcion Ubicacion Contador"; Rec."Descripcion Ubicacion Contador")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
            }
        }
        area(factboxes)
        {
            systempart(Outlook; Outlook)
            {
                ApplicationArea = All;
            }
            systempart(Notes; Notes)
            {
                ApplicationArea = All;
            }
            systempart(MyNotes; MyNotes)
            {
                ApplicationArea = All;
            }
            systempart(Links; Links)
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(creation)
        {
            group(Lecturas)
            {
                Caption = 'Lecturas';
                action("Histórico de Lecturas")
                {
                    ApplicationArea = All;
                    Image = History;
                    RunObject = Page "Hist. Agua /Electricidad";
                    RunPageLink = "No. Contador" = FIELD("No. Contador");
                }
            }
        }
        area(Promoted)
        {
            group(Category_Lecturas)
            {
                Caption = 'Lecturas';

                actionref(HistoricoLecturas_Promoted; "Histórico de Lecturas")
                {
                }
            }
        }
    }
}