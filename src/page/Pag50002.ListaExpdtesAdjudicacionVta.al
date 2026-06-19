page 50002 "Lista Expdtes Adjudicacion Vta"
{
    // //***Z004 - 400 - AT- 25/10/2016 - Gestión de expedientes de adjudicación - Compras

    Caption = 'Lista Expedientes de Adjudicacion Venta';
    CardPageID = "Expedientes adjudicación Vta";
    Editable = false;
    PageType = List;
    UsageCategory = Administration;
    SourceTable = 50001;
    SourceTableView = WHERE (Tipo Contratación=FILTER(Ventas));

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
                field("Adjudicatario Vta";"Adjudicatario Vta")
                {
                    ApplicationArea = All;
                }
                field("Nombre Adjudicatario Vta";"Nombre Adjudicatario Vta")
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
                }
                field("Fecha prórroga";"Fecha prórroga")
                {
                    ApplicationArea = All;
                }
                field("No. prórroga";"No. prórroga")
                {
                    ApplicationArea = All;
                }
                field("Fecha cierre expediente";"Fecha cierre expediente")
                {
                    ApplicationArea = All;
                }
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
    }

    trigger OnAfterGetCurrRecord()
    begin
        CALCFIELDS("Nombre Adjudicatario","Nombre Adjudicatario Vta");
    end;

    trigger OnAfterGetRecord()
    begin
        CALCFIELDS("Nombre Adjudicatario","Nombre Adjudicatario Vta");
    end;
}

