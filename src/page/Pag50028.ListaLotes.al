page 50028 "Lista Lotes"
{
    // //Zam0004 - IAG - 04/06/20: CAMPOS EXPEDIENTE DE ADJUDICACION Y LOTE
    // //ZAM0038 iag linea comentada 220720

    PageType = List;
    UsageCategory = Administration;
    SourceTable = 50011;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No. Expediente"; Rec."No. Expediente")
                {
                    ApplicationArea = All;
                    Editable = false;
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
                field("Fecha adjudicacion"; Rec."Fecha adjudicacion")
                {
                    ApplicationArea = All;
                }
                field(Adjudicatario; Rec.Adjudicatario)
                {
                    ApplicationArea = All;
                }
                field("Nombre Adjudicatario"; Rec."Nombre Adjudicatario")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Prórroga; Rec.Prórroga)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        fEditarProrroga;
                    end;
                }
                field("Fecha prórroga"; Rec."Fecha prórroga")
                {
                    ApplicationArea = All;
                    Editable = vEditarProrroga;
                }
                field("Importe prorroga"; Rec."Importe prorroga")
                {
                    ApplicationArea = All;
                    Editable = vEditarProrroga;
                }
                field("No. prórroga"; Rec."No. prórroga")
                {
                    ApplicationArea = All;
                    Editable = vEditarProrroga;
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
                field("Importe lote"-"Importe facturas registradas" + "Importe abonos registrados"; Rec."Importe lote" - Rec."Importe facturas registradas" + Rec."Importe abonos registrados")
                {
                    ApplicationArea = All;
                    Caption = 'Importe pendiente';
                }
                field(("Importe lote" + "Importe prorroga") - "Importe facturas registradas" + "Importe abonos registrados";(Rec."Importe lote" + Rec."Importe prorroga") - Rec."Importe facturas registradas" + Rec."Importe abonos registrados")
                {
                    ApplicationArea = All;
                    Caption = 'Importe pendiente con prorroga';
                }
                field("Organo de decisión"; Rec."Organo de decisión")
                {
                    ApplicationArea = All;
                }
                field(Desviación; Rec.Desviación)
                {
                    ApplicationArea = All;
                }
                field(Lote_Expediente; Rec.Lote_Expediente)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Cuenta Contable Imputacion"; Rec."Cuenta Contable Imputacion")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
        }
        area(navigation)
        {
            action(OfertasRel)
            {
                ApplicationArea = All;
                Caption = 'Ofertas relacionadas';
                Image = Quote;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                RunObject = Page 9306;
                                RunPageLink = No. expediente adjudicacion=FIELD(No. Expediente),
                              Document Type=CONST(Quote),
                              Lote=FIELD(Lote);
            }
            action(OfertasRelArch)
            {
                ApplicationArea = All;
                Caption = 'Ofertas relacionadas Archivadas';
                Image = Archive;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                RunObject = Page 9346;
                                RunPageLink = Lote=FIELD(Lote),
                              Document Type=FILTER(Quote),
                              No. expediente adjudicacion=FIELD(No. Expediente);
            }
            action("Pedidos relacionados")
            {
                ApplicationArea = All;
                Image = OrderList;
                RunObject = Page 9307;
                                RunPageLink = No. expediente adjudicacion=FIELD(No. Expediente),
                              Lote=FIELD(Lote),
                              Lote=FIELD(Lote);
            }
            action("Prefacturas relacionadas")
            {
                ApplicationArea = All;
                Image = Invoice;
                RunObject = Page 9308;
                                RunPageLink = No. expediente adjudicacion=FIELD(No. Expediente),
                              Lote=FIELD(Lote),
                              Lote=FIELD(Lote);
            }
            action("Facturas registradas relacionados")
            {
                ApplicationArea = All;
                Image = Archive;
                RunObject = Page 146;
                                RunPageLink = No. expediente adjudicacion=FIELD(No. Expediente),
                              Lote=FIELD(Lote),
                              Lote=FIELD(Lote);
            }
            action("Preabonos relacionadas")
            {
                ApplicationArea = All;
                Image = Invoice;
                RunObject = Page 9309;
                                RunPageLink = No. expediente adjudicacion=FIELD(No. Expediente),
                              Lote=FIELD(Lote),
                              Lote=FIELD(Lote);
            }
            action("Abonos registradas relacionados")
            {
                ApplicationArea = All;
                Image = Archive;
                RunObject = Page 147;
                                RunPageLink = No. expediente adjudicacion=FIELD(No. Expediente),
                              Lote=FIELD(Lote),
                              Lote=FIELD(Lote);
            }
            action("Facturas electrónicas")
            {
                ApplicationArea = All;
                Image = ElectronicDoc;
                RunObject = Page 50066;
                                RunPageLink = EXPEDIENTE=FIELD(No. Expediente),
                              Lote=FIELD(Lote);
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        Rec.CALCFIELDS("Nombre Adjudicatario","Fecha adjudicacion","Organo de decisión");
    end;

    trigger OnAfterGetRecord()
    begin
        Rec.CALCFIELDS("Nombre Adjudicatario","Fecha adjudicacion","Organo de decisión");
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        //ZAM0038 iag linea comentada 220720 IF Lote='0' THEN ERROR(Text50000);
    end;

    var
        vEditarProrroga: Boolean;
        Text50000: Label 'No es posible eliminar el Lote 0';

    [Scope('Internal')]
    procedure fEditarProrroga()
    begin
        IF Prórroga THEN
          vEditarProrroga := TRUE
        ELSE BEGIN
          "Fecha prórroga"   := 0D;
          "No. prórroga" := 0;
          "Importe prorroga" := 0;
          vEditarProrroga := FALSE;
        END;
    end;
}

