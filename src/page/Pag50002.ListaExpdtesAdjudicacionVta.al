page 50002 "Lista Expdtes Adjudicacion Vta"
{
    // //***Z004 - 400 - AT- 25/10/2016 - Gestión de expedientes de adjudicación - Compras

    Caption = 'Lista Expedientes de Adjudicacion Venta';
    CardPageID = "Expedientes adjudicación Vta";
    Editable = false;
    PageType = List;
    UsageCategory = Administration;
    SourceTable = 50001;
    SourceTableView = WHERE("Tipo Contratación" = FILTER(Ventas));

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
                field("Adjudicatario Vta"; Rec."Adjudicatario Vta")
                {
                    ApplicationArea = All;
                }
                field("Nombre Adjudicatario Vta"; Rec."Nombre Adjudicatario Vta")
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
                }
                field("Fecha prórroga"; Rec."Fecha prórroga")
                {
                    ApplicationArea = All;
                }
                field("No. prórroga"; Rec."No. prórroga")
                {
                    ApplicationArea = All;
                }
                field("Fecha cierre expediente"; Rec."Fecha cierre expediente")
                {
                    ApplicationArea = All;
                }
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
    }

    trigger OnAfterGetCurrRecord()
    begin
        Rec.CalcFields("Nombre Adjudicatario", "Nombre Adjudicatario Vta");
    end;

    trigger OnAfterGetRecord()
    begin
        Rec.CalcFields("Nombre Adjudicatario", "Nombre Adjudicatario Vta");
    end;
}