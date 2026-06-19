page 50004 "Expedientes adjudicación Vta"
{
    // //***Z004 - 400 - AT- 25/10/2016 - Gestión de expedientes de adjudicación - Compras

    PageType = Card;
    UsageCategory = Administration;
    SourceTable = 50001;
    SourceTableView = WHERE (Tipo Contratación=FILTER(Ventas));

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;

                    trigger OnAssistEdit()
                    begin
                        IF AssistEdit(xRec) THEN
                          CurrPage.UPDATE;
                    end;
                }
                field(Ejercicio; Rec.Ejercicio)
                {
                    ApplicationArea = All;
                }
                field("Fecha expediente"; Rec."Fecha expediente")
                {
                    ApplicationArea = All;
                }
                field(Descripción; Rec.Descripción)
                {
                    ApplicationArea = All;
                }
                field("Tipo trabajo"; Rec."Tipo trabajo")
                {
                    ApplicationArea = All;
                }
                field("Dpto. solicitante"; Rec."Dpto. solicitante")
                {
                    ApplicationArea = All;
                }
                field(Estado; Rec.Estado)
                {
                    ApplicationArea = All;
                }
                field("Fecha publicación"; Rec."Fecha publicación")
                {
                    ApplicationArea = All;
                }
                field("Fecha propuesta"; Rec."Fecha propuesta")
                {
                    ApplicationArea = All;
                }
                field("Fecha apertura plicas"; Rec."Fecha apertura plicas")
                {
                    ApplicationArea = All;
                }
                field("Importe del presupuesto"; Rec."Importe del presupuesto")
                {
                    ApplicationArea = All;
                }
                field("Bases expediente"; Rec."Bases expediente")
                {
                    ApplicationArea = All;
                }
                field("Organo de decisión"; Rec."Organo de decisión")
                {
                    ApplicationArea = All;
                }
                field("Adjudicatario Vta"; Rec."Adjudicatario Vta")
                {
                    ApplicationArea = All;
                }
                field("Nombre Adjudicatario Vta"; Rec."Nombre Adjudicatario Vta")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Importe adjudicado"; Rec."Importe adjudicado")
                {
                    ApplicationArea = All;
                }
                field("Fecha adjudicación"; Rec."Fecha adjudicación")
                {
                    ApplicationArea = All;
                }
                field(Lote; Rec.Lote)
                {
                    ApplicationArea = All;
                }
                field("Importe lote"; Rec."Importe lote")
                {
                    ApplicationArea = All;
                }
                field("Fecha inicio del contrato"; Rec."Fecha inicio del contrato")
                {
                    ApplicationArea = All;
                }
                field("Fecha finalización contrato"; Rec."Fecha finalización contrato")
                {
                    ApplicationArea = All;
                }
                field(Prórroga; Rec.Prórroga)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        fEditarProrroga;
                    end;
                }
                field("Fecha prórroga"; Rec."Fecha prórroga")
                {
                    ApplicationArea = All;
                    Editable = vEditarProrroga;
                }
                field("No. prórroga"; Rec."No. prórroga")
                {
                    ApplicationArea = All;
                    Editable = vEditarProrroga;
                }
                field("Fecha cierre expediente"; Rec."Fecha cierre expediente")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(Approval)
            {
                Caption = 'Approval';
                action(OfertasRel)
                {
                    ApplicationArea = All;
                    Caption = 'Ofertas relacionadas';
                    Image = Approve;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    RunObject = Page 9300;
                                    RunPageLink = No. expediente adjudicacion=FIELD(No.);

                    trigger OnAction()
                    var
                        tlSalesHdr: Record "Sales Header";
                    begin
                    end;
                }
                action(ArchivarOf)
                {
                    ApplicationArea = All;
                    Caption = 'Archivar ofertas expediente';
                    Image = Archive;

                    trigger OnAction()
                    begin
                        //***Z004 - 400 - AT- 25/10/2016 - Inicio
                        IF CONFIRM('Esta acción archivará todas las ofertas del expediente. Previamente se debería haber adjudicado la oferta ganadora. ¿Está seguro de continuar?') THEN BEGIN
                          fArchivarOfertasVta;
                        END;

                        //***Z004 - 400 - AT- 25/10/2016 - Fin
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        Rec.CALCFIELDS("Nombre Adjudicatario","Nombre Adjudicatario Vta");
    end;

    trigger OnAfterGetRecord()
    begin
        Rec.CALCFIELDS("Nombre Adjudicatario","Nombre Adjudicatario Vta");
    end;

    var
        vEditarProrroga: Boolean;
        pSalesQuotes: Page "Sales Quotes";

    [Scope('Internal')]
    procedure fEditarProrroga()
    begin
        IF Prórroga THEN
            vEditarProrroga := TRUE
        ELSE BEGIN
            "Fecha prórroga" := 0D;
            "No. prórroga" := 0;
            vEditarProrroga := FALSE;
        END;
    end;
}

