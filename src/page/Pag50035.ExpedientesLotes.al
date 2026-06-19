page 50035 "Expedientes - Lotes"
{
    // ZAM0041 iag 180521 nueva pagina 50035 expedients lotes

    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    UsageCategory = Administration;
    SourceTable = 50011;
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
                    ApplicationArea = All;
                }
                field(Lote; Lote)
                {
                    ApplicationArea = All;
                }
                field("Descripción lote"; "Descripción lote")
                {
                    ApplicationArea = All;
                }
                field("Descripción expediente"; "Descripción expediente")
                {
                    ApplicationArea = All;
                }
                field("Fecha expediente"; "Fecha expediente")
                {
                    ApplicationArea = All;
                }
                field("Importe lote"; "Importe lote")
                {
                    ApplicationArea = All;
                }
                field("Importe pdte. convertir"; "Importe pdte. convertir")
                {
                    ApplicationArea = All;
                }
                field("Importe prefacturas"; "Importe prefacturas")
                {
                    ApplicationArea = All;
                }
                field("Importe facturas registradas"; "Importe facturas registradas")
                {
                    ApplicationArea = All;
                }
                field("Importe abonos registrados"; "Importe abonos registrados")
                {
                    ApplicationArea = All;
                }
                field(Adjudicatario; Adjudicatario)
                {
                    ApplicationArea = All;
                }
                field(Prórroga; Prórroga)
                {
                    ApplicationArea = All;
                }
                field("Fecha prórroga"; "Fecha prórroga")
                {
                    ApplicationArea = All;
                }
                field("No. prórroga"; "No. prórroga")
                {
                    ApplicationArea = All;
                }
                field("Nombre Adjudicatario"; "Nombre Adjudicatario")
                {
                    ApplicationArea = All;
                }
                field("Adjudicatario Vta"; "Adjudicatario Vta")
                {
                    ApplicationArea = All;
                }
                field("Nombre Adjudicatario Vta"; "Nombre Adjudicatario Vta")
                {
                    ApplicationArea = All;
                }
                field("Estado Expediente"; "Estado Expediente")
                {
                    ApplicationArea = All;
                }
                field("Fecha adjudicacion"; "Fecha adjudicacion")
                {
                    ApplicationArea = All;
                }
                field("Organo de decisión"; "Organo de decisión")
                {
                    ApplicationArea = All;
                }
                field(Desviación; Desviación)
                {
                    ApplicationArea = All;
                }
                field("Importe prorroga"; "Importe prorroga")
                {
                    ApplicationArea = All;
                }
                field(Lote_Expediente; Lote_Expediente)
                {
                    ApplicationArea = All;
                }
                field("Cuenta Contable Imputacion"; "Cuenta Contable Imputacion")
                {
                    ApplicationArea = All;
                }
                field(Ejercicio; Ejercicio)
                {
                    ApplicationArea = All;
                    Caption = 'Ejercicio';
                    Description = 'Ejercicio';
                    OptionCaption = 'Ejercicio';
                    StyleExpr = TRUE;
                }
                field(tipotrabajo; tipotrabajo)
                {
                    ApplicationArea = All;
                    Caption = 'Tipo trabajo';
                }
                field(dptosolicitante; dptosolicitante)
                {
                    ApplicationArea = All;
                    Caption = 'Dpto. solicitante';
                }
                field(estado; estado)
                {
                    ApplicationArea = All;
                    Caption = 'Estado';
                }
                field(fechapublicacion; fechapublicacion)
                {
                    ApplicationArea = All;
                    Caption = 'Fecha publicación';
                }
                field(fechapropuesta; fechapropuesta)
                {
                    ApplicationArea = All;
                    Caption = 'Fecha propuesta';
                }
                field(fechaaperturaplicas; fechaaperturaplicas)
                {
                    ApplicationArea = All;
                    Caption = 'Fecha apertura plicas';
                }
                field(importepresupuesto; importepresupuesto)
                {
                    ApplicationArea = All;
                    Caption = 'Importe del presupuesto';
                }
                field(basesexpediente; basesexpediente)
                {
                    ApplicationArea = All;
                    Caption = 'Bases expediente';
                }
                field(lotesnumero; lotesnumero)
                {
                    ApplicationArea = All;
                    Caption = 'Lotes';
                }
                field(importelotes; importelotes)
                {
                    ApplicationArea = All;
                    Caption = '<Total Importe Lotes>';
                }
                field(importeadjudicado; importeadjudicado)
                {
                    ApplicationArea = All;
                    Caption = 'Importe adjudicado';
                }
                field(fechainiciocontrato; fechainiciocontrato)
                {
                    ApplicationArea = All;
                    Caption = 'Fecha inicio del contrato';
                }
                field(fechafincontrato; fechafincontrato)
                {
                    ApplicationArea = All;
                    Caption = 'Fecha finalización contrato';
                }
                field(fechacierreexpediente; fechacierreexpediente)
                {
                    ApplicationArea = All;
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
        tExpedientesadjudicacion: Record 50001;
}

