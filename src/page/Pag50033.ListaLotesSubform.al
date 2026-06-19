page 50033 "Lista Lotes Subform"
{
    // //Zam0004 - IAG - 04/06/20: CAMPOS EXPEDIENTE DE ADJUDICACION Y LOTE

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
                        fEditarProrroga();
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
                field(("Importe lote" + "Importe prorroga") - "Importe facturas registradas" + "Importe abonos registrados"; (Rec."Importe lote" + Rec."Importe prorroga") - Rec."Importe facturas registradas" + Rec."Importe abonos registrados")
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
                RunObject = Page "Purchase Quotes";
                RunPageLink = "No. expediente adjudicacion" = FIELD("No. Expediente"),
                              "Document Type" = CONST(Quote),
                              Lote = FIELD(Lote);
            }
            action(OfertasRelArch)
            {
                ApplicationArea = All;
                Caption = 'Ofertas relacionadas Archivadas';
                Image = Archive;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                RunObject = Page "Purchase Quote Archives";
                RunPageLink = Lote = FIELD(Lote),
                              "Document Type" = FILTER(Quote),
                              "No. expediente adjudicacion" = FIELD("No. Expediente");
            }
            action("Pedidos relacionados")
            {
                ApplicationArea = All;
                Image = OrderList;
                RunObject = Page "Purchase Order List";
                RunPageLink = "No. expediente adjudicacion" = FIELD("No. Expediente"),
                              Lote = FIELD(Lote);
            }
            action("Prefacturas relacionadas")
            {
                ApplicationArea = All;
                Image = Invoice;
                RunObject = Page "Purchase Invoices";
                RunPageLink = "No. expediente adjudicacion" = FIELD("No. Expediente"),
                              Lote = FIELD(Lote);
            }
            action("Facturas registradas relacionados")
            {
                ApplicationArea = All;
                Image = Archive;
                RunObject = Page "Posted Purchase Invoices";
                RunPageLink = "No. expediente adjudicacion" = FIELD("No. Expediente"),
                              Lote = FIELD(Lote);
            }
            action("Preabonos relacionadas")
            {
                ApplicationArea = All;
                Image = Invoice;
                RunObject = Page "Purchase Credit Memos";
                RunPageLink = "No. expediente adjudicacion" = FIELD("No. Expediente"),
                              Lote = FIELD(Lote);
            }
            action("Abonos registradas relacionados")
            {
                ApplicationArea = All;
                Image = Archive;
                RunObject = Page "Posted Purchase Credit Memos";
                RunPageLink = "No. expediente adjudicacion" = FIELD("No. Expediente"),
                              Lote = FIELD(Lote);
            }
            action("Facturas electrónicas")
            {
                ApplicationArea = All;
                Image = ElectronicDoc;
                RunObject = Page "Lista Factura Electrónica";
                RunPageLink = EXPEDIENTE = FIELD("No. Expediente"),
                              Lote = FIELD(Lote);
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        Rec.CalcFields("Nombre Adjudicatario", "Fecha adjudicacion", "Organo de decisión");
    end;

    trigger OnAfterGetRecord()
    begin
        Rec.CalcFields("Nombre Adjudicatario", "Fecha adjudicacion", "Organo de decisión");
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        if Rec.Lote = '0' then
            Error(Text50000);
    end;

    var
        vEditarProrroga: Boolean;
        Text50000: Label 'No es posible eliminar el Lote 0';

    [Scope('Internal')]
    procedure fEditarProrroga()
    begin
        if Rec.Prórroga then
            vEditarProrroga := true
        else begin
            Rec."Fecha prórroga" := 0D;
            Rec."No. prórroga" := 0;
            Rec."Importe prorroga" := 0;
            vEditarProrroga := false;
        end;
    end;
}