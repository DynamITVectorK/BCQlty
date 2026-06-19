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
    UsageCategory = Administration;
    SourceTable = 50001;
    SourceTableView = WHERE (Tipo Contratación=FILTER(Compras));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No.";"No.")
                {
                    ApplicationArea = All;
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
                field(Lotes;"Num Lotes")
                {
                    ApplicationArea = All;
                }
                field("Importe Lotes";"Total Importe Lotes")
                {
                    ApplicationArea = All;
                }
                field("Importe adjudicado";"Importe adjudicado")
                {
                    ApplicationArea = All;
                }
                field("Fecha adjudicación";"Fecha adjudicación")
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
                field("Fecha cierre expediente";"Fecha cierre expediente")
                {
                    ApplicationArea = All;
                }
                field(Prórroga;Prórroga)
                {
                    ApplicationArea = All;
                }
                field("Cuenta Contable";"Cuenta Contable")
                {
                    ApplicationArea = All;
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
                    ApplicationArea = All;
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
        tlExpedientesadjudicacion: Record 50001;
}

