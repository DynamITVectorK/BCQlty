page 50035 "Expedientes - Lotes"
{
    // ZAM0041 iag 180521 nueva pagina 50035 expedients lotes

    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    UsageCategory = Administration;
    SourceTable = 50011;
    SourceTableView = SORTING("No. Expediente", Lote)
                      ORDER(Ascending);

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No. Expediente"; Rec."No. Expediente")
                {
                    ApplicationArea = All;
                }
                field(Lote; Rec.Lote)
                {
                    ApplicationArea = All;
                }
                field("Descripción lote"; Rec."Descripción lote")
                {
                    ApplicationArea = All;
                }
                field("Descripción expediente"; Rec."Descripción expediente")
                {
                    ApplicationArea = All;
                }
                field("Fecha expediente"; Rec."Fecha expediente")
                {
                    ApplicationArea = All;
                }
                field("Importe lote"; Rec."Importe lote")
                {
                    ApplicationArea = All;
                }
                field("Importe pdte. convertir"; Rec."Importe pdte. convertir")
                {
                    ApplicationArea = All;
                }
                field("Importe prefacturas"; Rec."Importe prefacturas")
                {
                    ApplicationArea = All;
                }
                field("Importe facturas registradas"; Rec."Importe facturas registradas")
                {
                    ApplicationArea = All;
                }
                field("Importe abonos registrados"; Rec."Importe abonos registrados")
                {
                    ApplicationArea = All;
                }
                field(Adjudicatario; Rec.Adjudicatario)
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
                field("Nombre Adjudicatario"; Rec."Nombre Adjudicatario")
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
                field("Estado Expediente"; Rec."Estado Expediente")
                {
                    ApplicationArea = All;
                }
                field("Fecha adjudicacion"; Rec."Fecha adjudicacion")
                {
                    ApplicationArea = All;
                }
                field("Organo de decisión"; Rec."Organo de decisión")
                {
                    ApplicationArea = All;
                }
                field(Desviación; Rec.Desviación)
                {
                    ApplicationArea = All;
                }
                field("Importe prorroga"; Rec."Importe prorroga")
                {
                    ApplicationArea = All;
                }
                field(Lote_Expediente; Rec.Lote_Expediente)
                {
                    ApplicationArea = All;
                }
                field("Cuenta Contable Imputacion"; Rec."Cuenta Contable Imputacion")
                {
                    ApplicationArea = All;
                }
                field(Ejercicio; Ejercicio)
                {
                    ApplicationArea = All;
                    Caption = 'Ejercicio';
                    Description = 'Ejercicio';
                    OptionCaption = 'Ejercicio';
                    StyleExpr = true;
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
        Clear(tExpedientesadjudicacion);
        tExpedientesadjudicacion.SetRange("Tipo Contratación", tExpedientesadjudicacion."Tipo Contratación"::Compras);
        tExpedientesadjudicacion.SetRange("No.", Rec."No. Expediente");
        if tExpedientesadjudicacion.FindFirst() then begin
            tExpedientesadjudicacion.CalcFields("Num Lotes", "Total Importe Lotes");
            Ejercicio := tExpedientesadjudicacion.Ejercicio;
            tipotrabajo := Format(tExpedientesadjudicacion."Tipo trabajo");
            dptosolicitante := tExpedientesadjudicacion."Dpto. solicitante";
            estado := Format(tExpedientesadjudicacion.Estado);
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
        end;
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