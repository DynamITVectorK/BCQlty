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
                field("No.";"No.")
                {
                    ApplicationArea = All;

                    trigger OnAssistEdit()
                    begin
                        IF AssistEdit(xRec) THEN
                          CurrPage.UPDATE;
                    end;
                }
                field(Ejercicio;Ejercicio)
                {
                    ApplicationArea = All;
                }
                field("Fecha expediente";"Fecha expediente")
                {
                    ApplicationArea = All;
                }
                field(Descripción;Descripción)
                {
                    ApplicationArea = All;
                }
                field("Tipo trabajo";"Tipo trabajo")
                {
                    ApplicationArea = All;
                }
                field("Dpto. solicitante";"Dpto. solicitante")
                {
                    ApplicationArea = All;
                }
                field(Estado;Estado)
                {
                    ApplicationArea = All;
                }
                field("Fecha publicación";"Fecha publicación")
                {
                    ApplicationArea = All;
                }
                field("Fecha propuesta";"Fecha propuesta")
                {
                    ApplicationArea = All;
                }
                field("Fecha apertura plicas";"Fecha apertura plicas")
                {
                    ApplicationArea = All;
                }
                field("Importe del presupuesto";"Importe del presupuesto")
                {
                    ApplicationArea = All;
                }
                field("Bases expediente";"Bases expediente")
                {
                    ApplicationArea = All;
                }
                field("Organo de decisión";"Organo de decisión")
                {
                    ApplicationArea = All;
                }
                field("Adjudicatario Vta";"Adjudicatario Vta")
                {
                    ApplicationArea = All;
                }
                field("Nombre Adjudicatario Vta";"Nombre Adjudicatario Vta")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Importe adjudicado";"Importe adjudicado")
                {
                    ApplicationArea = All;
                }
                field("Fecha adjudicación";"Fecha adjudicación")
                {
                    ApplicationArea = All;
                }
                field(Lote;Lote)
                {
                    ApplicationArea = All;
                }
                field("Importe lote";"Importe lote")
                {
                    ApplicationArea = All;
                }
                field("Fecha inicio del contrato";"Fecha inicio del contrato")
                {
                    ApplicationArea = All;
                }
                field("Fecha finalización contrato";"Fecha finalización contrato")
                {
                    ApplicationArea = All;
                }
                field(Prórroga;Prórroga)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        fEditarProrroga;
                    end;
                }
                field("Fecha prórroga";"Fecha prórroga")
                {
                    ApplicationArea = All;
                    Editable = vEditarProrroga;
                }
                field("No. prórroga";"No. prórroga")
                {
                    ApplicationArea = All;
                    Editable = vEditarProrroga;
                }
                field("Fecha cierre expediente";"Fecha cierre expediente")
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
        CALCFIELDS("Nombre Adjudicatario","Nombre Adjudicatario Vta");
    end;

    trigger OnAfterGetRecord()
    begin
        CALCFIELDS("Nombre Adjudicatario","Nombre Adjudicatario Vta");
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

