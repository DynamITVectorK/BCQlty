page 50001 "Lista Expdtes Adjudicacion Com"
{
    // //***Z004 - 400 - AT- 25/10/2016 - Gestión de expedientes de adjudicación - Compras
    // //Zam0004 - IAG - 04/06/20: CAMPOS EXPEDIENTE DE ADJUDICACION Y LOTE LLAMADA A SUBFORM
    // 
    // //zam0038 iag 170720 sacados campos "Cuenta Contable" y Prorroga

    Caption = 'Lista Expedientes de Adjudicacion Compra';
    CardPageID = "Expedientes adjudicación Compr";
    Editable = false;
    PageType = List;
    SourceTable = Table50001;
    SourceTableView = WHERE (Tipo Contratación=FILTER(Compras));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No.";"No.")
                {
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
                field(Lotes;"Num Lotes")
                {
                }
                field("Importe Lotes";"Total Importe Lotes")
                {
                }
                field("Importe adjudicado";"Importe adjudicado")
                {
                }
                field("Fecha adjudicación";"Fecha adjudicación")
                {
                }
                field("Fecha inicio del contrato";"Fecha inicio del contrato")
                {
                }
                field("Fecha finalización contrato";"Fecha finalización contrato")
                {
                }
                field("Fecha cierre expediente";"Fecha cierre expediente")
                {
                }
                field(Prórroga;Prórroga)
                {
                }
                field("Cuenta Contable";"Cuenta Contable")
                {
                }
            }
            part(;50033)
            {
                Editable = false;
                SubPageLink = No. Expediente=FIELD(No.);
            }
        }
        area(factboxes)
        {
            systempart(;Links)
            {
                Visible = false;
            }
            systempart(;Notes)
            {
                Visible = true;
            }
        }
    }

    actions
    {
        area(navigation)
        {
        }
        area(processing)
        {
            group("&Print")
            {
                Caption = '&Print';
                Image = Print;
                action("Work Order")
                {
                    Caption = 'Work Order';
                    Ellipsis = true;
                    Image = Print;

                    trigger OnAction()
                    begin
                        CurrPage.SETSELECTIONFILTER(tlExpedientesadjudicacion);
                        REPORT.RUNMODAL(50004,TRUE,FALSE,tlExpedientesadjudicacion);
                    end;
                }
            }
        }
    }

    var
        tlExpedientesadjudicacion: Record "50001";
}

