page 50035 "Expedientes - Lotes"
{
    // ZAM0041 iag 180521 nueva pagina 50035 expedients lotes

    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = Table50011;
    SourceTableView = SORTING (No. Expediente, Lote)
                      ORDER(Ascending);

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No. Expediente"; "No. Expediente")
                {
                }
                field(Lote; Lote)
                {
                }
                field("Descripción lote"; "Descripción lote")
                {
                }
                field("Descripción expediente"; "Descripción expediente")
                {
                }
                field("Fecha expediente"; "Fecha expediente")
                {
                }
                field("Importe lote"; "Importe lote")
                {
                }
                field("Importe pdte. convertir"; "Importe pdte. convertir")
                {
                }
                field("Importe prefacturas"; "Importe prefacturas")
                {
                }
                field("Importe facturas registradas"; "Importe facturas registradas")
                {
                }
                field("Importe abonos registrados"; "Importe abonos registrados")
                {
                }
                field(Adjudicatario; Adjudicatario)
                {
                }
                field(Prórroga; Prórroga)
                {
                }
                field("Fecha prórroga"; "Fecha prórroga")
                {
                }
                field("No. prórroga"; "No. prórroga")
                {
                }
                field("Nombre Adjudicatario"; "Nombre Adjudicatario")
                {
                }
                field("Adjudicatario Vta"; "Adjudicatario Vta")
                {
                }
                field("Nombre Adjudicatario Vta"; "Nombre Adjudicatario Vta")
                {
                }
                field("Estado Expediente"; "Estado Expediente")
                {
                }
                field("Fecha adjudicacion"; "Fecha adjudicacion")
                {
                }
                field("Organo de decisión"; "Organo de decisión")
                {
                }
                field(Desviación; Desviación)
                {
                }
                field("Importe prorroga"; "Importe prorroga")
                {
                }
                field(Lote_Expediente; Lote_Expediente)
                {
                }
                field("Cuenta Contable Imputacion"; "Cuenta Contable Imputacion")
                {
                }
                field(Ejercicio; Ejercicio)
                {
                    Caption = 'Ejercicio';
                    Description = 'Ejercicio';
                    OptionCaption = 'Ejercicio';
                    StyleExpr = TRUE;
                }
                field(tipotrabajo; tipotrabajo)
                {
                    Caption = 'Tipo trabajo';
                }
                field(dptosolicitante; dptosolicitante)
                {
                    Caption = 'Dpto. solicitante';
                }
                field(estado; estado)
                {
                    Caption = 'Estado';
                }
                field(fechapublicacion; fechapublicacion)
                {
                    Caption = 'Fecha publicación';
                }
                field(fechapropuesta; fechapropuesta)
                {
                    Caption = 'Fecha propuesta';
                }
                field(fechaaperturaplicas; fechaaperturaplicas)
                {
                    Caption = 'Fecha apertura plicas';
                }
                field(importepresupuesto; importepresupuesto)
                {
                    Caption = 'Importe del presupuesto';
                }
                field(basesexpediente; basesexpediente)
                {
                    Caption = 'Bases expediente';
                }
                field(lotesnumero; lotesnumero)
                {
                    Caption = 'Lotes';
                }
                field(importelotes; importelotes)
                {
                    Caption = '<Total Importe Lotes>';
                }
                field(importeadjudicado; importeadjudicado)
                {
                    Caption = 'Importe adjudicado';
                }
                field(fechainiciocontrato; fechainiciocontrato)
                {
                    Caption = 'Fecha inicio del contrato';
                }
                field(fechafincontrato; fechafincontrato)
                {
                    Caption = 'Fecha finalización contrato';
                }
                field(fechacierreexpediente; fechacierreexpediente)
                {
                    Caption = 'Fecha cierre expediente';
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        CLEAR(tExpedientesadjudicacion);
        tExpedientesadjudicacion.SETRANGE("Tipo Contratación", tExpedientesadjudicacion."Tipo Contratación"::Compras);
        tExpedientesadjudicacion.SETRANGE(tExpedientesadjudicacion."No.", "No. Expediente");
        IF tExpedientesadjudicacion.FINDFIRST THEN BEGIN
            tExpedientesadjudicacion.CALCFIELDS("Num Lotes", "Total Importe Lotes");
            Ejercicio := tExpedientesadjudicacion.Ejercicio;
            tipotrabajo := FORMAT(tExpedientesadjudicacion."Tipo trabajo");
            dptosolicitante := tExpedientesadjudicacion."Dpto. solicitante";
            estado := FORMAT(tExpedientesadjudicacion.Estado);
            fechapublicacion := tExpedientesadjudicacion."Fecha publicación";
            fechapropuesta := tExpedientesadjudicacion."Fecha propuesta";
            fechaaperturaplicas := tExpedientesadjudicacion."Fecha apertura plicas";
            importepresupuesto := tExpedientesadjudicacion."Importe del presupuesto";
            basesexpediente := tExpedientesadjudicacion."Bases expediente";
            lotesnumero := tExpedientesadjudicacion."Num Lotes";
            importelotes := tExpedientesadjudicacion."Total Importe Lotes";
            importeadjudicado := tExpedientesadjudicacion."Importe adjudicado";
            fechainiciocontrato := tExpedientesadjudicacion."Fecha inicio del contrato";
            fechafincontrato := tExpedientesadjudicacion."Fecha finalización contrato";
            fechacierreexpediente := tExpedientesadjudicacion."Fecha cierre expediente";

        END;
    end;

    var
        Ejercicio: Integer;
        tipotrabajo: Text[40];
        dptosolicitante: Text[40];
        estado: Text[40];
        fechapublicacion: Date;
        fechapropuesta: Date;
        fechaaperturaplicas: Date;
        importepresupuesto: Decimal;
        basesexpediente: Text[1024];
        lotesnumero: Integer;
        importelotes: Decimal;
        importeadjudicado: Decimal;
        fechainiciocontrato: Date;
        fechafincontrato: Date;
        fechacierreexpediente: Date;
        tExpedientesadjudicacion: Record "50001";
}

