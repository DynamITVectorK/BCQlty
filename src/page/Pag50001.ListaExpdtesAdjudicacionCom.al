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
    SourceTableView = WHERE("Tipo Contratación" = FILTER(Compras));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
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
                field(Lotes; Rec."Num Lotes")
                {
                    ApplicationArea = All;
                }
                field("Importe Lotes"; Rec."Total Importe Lotes")
                {
                    ApplicationArea = All;
                }
                field("Importe adjudicado"; Rec."Importe adjudicado")
                {
                    ApplicationArea = All;
                }
                field("Fecha adjudicación"; Rec."Fecha adjudicación")
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
                field("Fecha cierre expediente"; Rec."Fecha cierre expediente")
                {
                    ApplicationArea = All;
                }
                field(Prórroga; Rec.Prórroga)
                {
                    ApplicationArea = All;
                }
                field("Cuenta Contable"; Rec."Cuenta Contable")
                {
                    ApplicationArea = All;
                }
            }
            part(LotesSubform; "Lista Lotes Subform")
            {
                ApplicationArea = All;
                Editable = false;
                SubPageLink = "No. Expediente" = FIELD("No.");
            }
        }
        area(factboxes)
        {
            systempart(Links; Links)
            {
                ApplicationArea = All;
                Visible = false;
            }
            systempart(Notes; Notes)
            {
                ApplicationArea = All;
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
                        CurrPage.SetSelectionFilter(tlExpedientesadjudicacion);
                        Report.RunModal(50004, true, false, tlExpedientesadjudicacion);
                    end;
                }
            }
        }
    }

    var
        tlExpedientesadjudicacion: Record 50001;
}