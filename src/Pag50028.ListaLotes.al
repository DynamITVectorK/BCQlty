page 50028 "Lista Lotes"
{
    // //Zam0004 - IAG - 04/06/20: CAMPOS EXPEDIENTE DE ADJUDICACION Y LOTE
    // //ZAM0038 iag linea comentada 220720

    PageType = List;
    SourceTable = Table50011;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No. Expediente"; "No. Expediente")
                {
                    Editable = false;
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
                field("Fecha adjudicacion"; "Fecha adjudicacion")
                {
                }
                field(Adjudicatario; Adjudicatario)
                {
                }
                field("Nombre Adjudicatario"; "Nombre Adjudicatario")
                {
                    Editable = false;
                }
                field(Prórroga; Prórroga)
                {

                    trigger OnValidate()
                    begin
                        fEditarProrroga;
                    end;
                }
                field("Fecha prórroga"; "Fecha prórroga")
                {
                    Editable = vEditarProrroga;
                }
                field("Importe prorroga"; "Importe prorroga")
                {
                    Editable = vEditarProrroga;
                }
                field("No. prórroga"; "No. prórroga")
                {
                    Editable = vEditarProrroga;
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
                field("Importe lote"-"Importe facturas registradas" + "Importe abonos registrados"; "Importe lote"-"Importe facturas registradas"+"Importe abonos registrados")
                {
                    Caption = 'Importe pendiente';
                }
                field(("Importe lote" + "Importe prorroga") - "Importe facturas registradas" + "Importe abonos registrados";("Importe lote"+"Importe prorroga")-"Importe facturas registradas"+"Importe abonos registrados")
                {
                    Caption = 'Importe pendiente con prorroga';
                }
                field("Organo de decisión";"Organo de decisión")
                {
                }
                field(Desviación;Desviación)
                {
                }
                field(Lote_Expediente;Lote_Expediente)
                {
                    Editable = false;
                }
                field("Cuenta Contable Imputacion";"Cuenta Contable Imputacion")
                {
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
                Image = OrderList;
                RunObject = Page 9307;
                                RunPageLink = No. expediente adjudicacion=FIELD(No. Expediente),
                              Lote=FIELD(Lote),
                              Lote=FIELD(Lote);
            }
            action("Prefacturas relacionadas")
            {
                Image = Invoice;
                RunObject = Page 9308;
                                RunPageLink = No. expediente adjudicacion=FIELD(No. Expediente),
                              Lote=FIELD(Lote),
                              Lote=FIELD(Lote);
            }
            action("Facturas registradas relacionados")
            {
                Image = Archive;
                RunObject = Page 146;
                                RunPageLink = No. expediente adjudicacion=FIELD(No. Expediente),
                              Lote=FIELD(Lote),
                              Lote=FIELD(Lote);
            }
            action("Preabonos relacionadas")
            {
                Image = Invoice;
                RunObject = Page 9309;
                                RunPageLink = No. expediente adjudicacion=FIELD(No. Expediente),
                              Lote=FIELD(Lote),
                              Lote=FIELD(Lote);
            }
            action("Abonos registradas relacionados")
            {
                Image = Archive;
                RunObject = Page 147;
                                RunPageLink = No. expediente adjudicacion=FIELD(No. Expediente),
                              Lote=FIELD(Lote),
                              Lote=FIELD(Lote);
            }
            action("Facturas electrónicas")
            {
                Image = ElectronicDoc;
                RunObject = Page 50066;
                                RunPageLink = EXPEDIENTE=FIELD(No. Expediente),
                              Lote=FIELD(Lote);
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        CALCFIELDS("Nombre Adjudicatario","Fecha adjudicacion","Organo de decisión");
    end;

    trigger OnAfterGetRecord()
    begin
        CALCFIELDS("Nombre Adjudicatario","Fecha adjudicacion","Organo de decisión");
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

