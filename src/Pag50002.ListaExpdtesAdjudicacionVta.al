page 50002 "Lista Expdtes Adjudicacion Vta"
{
    // //***Z004 - 400 - AT- 25/10/2016 - Gestión de expedientes de adjudicación - Compras

    Caption = 'Lista Expedientes de Adjudicacion Venta';
    CardPageID = "Expedientes adjudicación Vta";
    Editable = false;
    PageType = List;
    SourceTable = Table50001;
    SourceTableView = WHERE (Tipo Contratación=FILTER(Ventas));

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
                field("Adjudicatario Vta";"Adjudicatario Vta")
                {
                }
                field("Nombre Adjudicatario Vta";"Nombre Adjudicatario Vta")
                {
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
                }
                field("Fecha prórroga";"Fecha prórroga")
                {
                }
                field("No. prórroga";"No. prórroga")
                {
                }
                field("Fecha cierre expediente";"Fecha cierre expediente")
                {
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

