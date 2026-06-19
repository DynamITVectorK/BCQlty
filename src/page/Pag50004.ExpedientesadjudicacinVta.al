page 50004 "Expedientes adjudicación Vta"
{
    // //***Z004 - 400 - AT- 25/10/2016 - Gestión de expedientes de adjudicación - Compras

    PageType = Card;
    SourceTable = Table50001;
    SourceTableView = WHERE (Tipo Contratación=FILTER(Ventas));

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No.";"No.")
                {

                    trigger OnAssistEdit()
                    begin
                        IF AssistEdit(xRec) THEN
                          CurrPage.UPDATE;
                    end;
                }
                field(Ejercicio;Ejercicio)
                {
                }
                field("Fecha expediente";"Fecha expediente")
                {
                }
                field(Descripción;Descripción)
                {
                }
                field("Tipo trabajo";"Tipo trabajo")
                {
                }
                field("Dpto. solicitante";"Dpto. solicitante")
                {
                }
                field(Estado;Estado)
                {
                }
                field("Fecha publicación";"Fecha publicación")
                {
                }
                field("Fecha propuesta";"Fecha propuesta")
                {
                }
                field("Fecha apertura plicas";"Fecha apertura plicas")
                {
                }
                field("Importe del presupuesto";"Importe del presupuesto")
                {
                }
                field("Bases expediente";"Bases expediente")
                {
                }
                field("Organo de decisión";"Organo de decisión")
                {
                }
                field("Adjudicatario Vta";"Adjudicatario Vta")
                {
                }
                field("Nombre Adjudicatario Vta";"Nombre Adjudicatario Vta")
                {
                    Editable = false;
                }
                field("Importe adjudicado";"Importe adjudicado")
                {
                }
                field("Fecha adjudicación";"Fecha adjudicación")
                {
                }
                field(Lote;Lote)
                {
                }
                field("Importe lote";"Importe lote")
                {
                }
                field("Fecha inicio del contrato";"Fecha inicio del contrato")
                {
                }
                field("Fecha finalización contrato";"Fecha finalización contrato")
                {
                }
                field(Prórroga;Prórroga)
                {

                    trigger OnValidate()
                    begin
                        fEditarProrroga;
                    end;
                }
                field("Fecha prórroga";"Fecha prórroga")
                {
                    Editable = vEditarProrroga;
                }
                field("No. prórroga";"No. prórroga")
                {
                    Editable = vEditarProrroga;
                }
                field("Fecha cierre expediente";"Fecha cierre expediente")
                {
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
                    Caption = 'Ofertas relacionadas';
                    Image = Approve;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    RunObject = Page 9300;
                                    RunPageLink = No. expediente adjudicacion=FIELD(No.);

                    trigger OnAction()
                    var
                        tlSalesHdr: Record "36";
                    begin
                    end;
                }
                action(ArchivarOf)
                {
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
        pSalesQuotes: Page "9300";

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

