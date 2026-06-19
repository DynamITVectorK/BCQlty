page 50003 "Expedientes adjudicación Compr"
{
    // //***Z004 - 400 - AT- 25/10/2016 - Gestión de expedientes de adjudicación - Compras
    // 
    // //Z035 - JLF - 19/07/19: Facturación electrónica
    //                            Nuevo grupo "Aprobaciones" y mostrar campos nuevos:
    //                             "Aprobador 1"
    //                             "Aprobador 2"
    //                             "Aprobador 3"
    //                             "Aprobador 4"
    // 
    // //Z035 - INICIO 28/04/2020 JRB Dimensiones en expedientes
    // //INICIO Z035 - JRB - 05/05/2020 - Aprobaciones en expedientes
    // 
    // 
    // //ZAM0038 IAG 20072020 campo prorroga puesto a flowfield(no hacia nada) ahora si los lotes tienen prorroga a true entonces este valor se actualiza a true mas boton de crear lote,
    // //mas botones de enviar solicitud y crear lote
    // 
    // //INICIO JRB 29/07/2020 Poder elegir una carpeta

    PageType = Card;
    UsageCategory = Administration;
    Permissions = TableData 454 = rimd;
    SourceTable = 50001;
    SourceTableView = WHERE("Tipo Contratación" = FILTER(Compras));

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;

                    trigger OnAssistEdit()
                    begin
                        if Rec.AssistEdit(xRec) then
                            CurrPage.Update();
                    end;
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
                field("Dpto. solicitante Fact"; Rec."Dpto. solicitante")
                {
                    ApplicationArea = All;
                    Caption = 'Dpto. solicitante Fact';
                }
                field("Dpto. solicitante Exp"; Rec."Dpto. solicitante Exp")
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
                    Caption = 'Bases expediente';
                    Editable = false;
                }
                field("Organo de decisión"; Rec."Organo de decisión")
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
                field("Cuenta Contable"; Rec."Cuenta Contable")
                {
                    ApplicationArea = All;
                }
            }
            part(PurchReceiptLines; "Lista Lotes")
            {
                ApplicationArea = All;
                SubPageLink = "No. Expediente" = FIELD("No.");
            }
            group("Aprobaciones Factura")
            {
                Caption = 'Aprobaciones Factura';
                field("Aprobador 1"; Rec."Aprobador 1") { ApplicationArea = All; }
                field("Aprobador 2"; Rec."Aprobador 2") { ApplicationArea = All; }
                field("Aprobador 3"; Rec."Aprobador 3") { ApplicationArea = All; }
                field("Aprobador 4"; Rec."Aprobador 4") { ApplicationArea = All; }
                field("Aprobador 5"; Rec."Aprobador 5") { ApplicationArea = All; }
            }
            group("Aprobaciones Expedientes")
            {
                Caption = 'Aprobaciones Expedientes';
                field("Aprobador 1 Exp"; Rec."Aprobador 1 Exp") { ApplicationArea = All; }
                field("Aprobador 2 Exp"; Rec."Aprobador 2 Exp") { ApplicationArea = All; }
                field("Aprobador 3 Exp"; Rec."Aprobador 3 Exp") { ApplicationArea = All; }
                field("Aprobador 4 Exp"; Rec."Aprobador 4 Exp") { ApplicationArea = All; }
                field("Aprobador 5 Exp"; Rec."Aprobador 5 Exp") { ApplicationArea = All; }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(Approval)
            {
                Caption = 'Approval';
                action(ArchivarOf)
                {
                    ApplicationArea = All;
                    Caption = 'Archivar ofertas expediente';
                    Image = Archive;

                    trigger OnAction()
                    begin
                        if Confirm('Esta acción archivará todas las ofertas del expediente. Previamente se debería haber adjudicado la oferta ganadora. ¿Está seguro de continuar?') then
                            Rec.fArchivarOfertas();
                    end;
                }
                action(ImprimirDocumentoAsignacionExpediente)
                {
                    ApplicationArea = All;
                    Caption = 'Imprimir Documento Asignacion Expediente';
                    Image = Print;

                    trigger OnAction()
                    var
                        tlExpedientesadjudicacion: Record 50001;
                    begin
                        Clear(tlExpedientesadjudicacion);
                        tlExpedientesadjudicacion.SetRange("Tipo Contratación", tlExpedientesadjudicacion."Tipo Contratación"::Compras);
                        tlExpedientesadjudicacion.SetRange("No.", Rec."No.");
                        tlExpedientesadjudicacion.Print();
                    end;
                }
                action(LanzarAprobacion)
                {
                    ApplicationArea = All;
                    Caption = 'Lanzar Aprobacion Exp.';

                    trigger OnAction()
                    var
                        Text50000: Label 'Debe haber un aprobador configurado';
                        Text50001: Label 'Solicitud lanzada';
                        ApprovalsMgt: Codeunit "Approvals Mgmt.";
                        NUMAPROBACION: Integer;
                    begin
                        if Rec.Estado in [Rec.Estado::"Adj.Provisional", Rec.Estado::"Adj.Definitiva"] then
                            if not Confirm(CONFIRM001) then
                                Error(ERROR0001);

                        NUMAPROBACION := 0;
                        if Rec."Aprobador 1 Exp" <> '' then begin
                            fCrearMovAprobExp(Rec, Rec."Aprobador 1 Exp", 1);
                            NUMAPROBACION := 1;
                        end;
                        if Rec."Aprobador 2 Exp" <> '' then begin
                            fCrearMovAprobExp(Rec, Rec."Aprobador 2 Exp", 2);
                            if NUMAPROBACION = 0 then
                                NUMAPROBACION := 2;
                        end;
                        if Rec."Aprobador 3 Exp" <> '' then begin
                            fCrearMovAprobExp(Rec, Rec."Aprobador 3 Exp", 3);
                            if NUMAPROBACION = 0 then
                                NUMAPROBACION := 3;
                        end;
                        if Rec."Aprobador 4 Exp" <> '' then begin
                            fCrearMovAprobExp(Rec, Rec."Aprobador 4 Exp", 4);
                            if NUMAPROBACION = 0 then
                                NUMAPROBACION := 4;
                        end;
                        if Rec."Aprobador 5 Exp" <> '' then begin
                            fCrearMovAprobExp(Rec, Rec."Aprobador 5 Exp", 5);
                            if NUMAPROBACION = 0 then
                                NUMAPROBACION := 5;
                        end;

                        Clear(ApprovalsMgt);
                        ApprovalsMgt.SendExpApprovalsMail(Rec, NUMAPROBACION);
                        Message(Text50001);
                        Rec.Validate(Estado, Rec.Estado::"Adj.Provisional");
                    end;
                }
                action("Crear Lote")
                {
                    ApplicationArea = All;
                    Caption = 'Crear Lote';

                    trigger OnAction()
                    var
                        Tlotes: Record 50011;
                        tlotes2: Record 50011;
                        tlotes3: Record 50011;
                        numerolote: Integer;
                        tlotes4: Record 50011;
                        okinteger: Boolean;
                    begin
                        Clear(Tlotes);
                        Tlotes.SetRange("No. Expediente", Rec."No.");
                        if Tlotes.FindFirst() then begin
                            if Confirm('Ya existen lotes creados para éste expediente , desea continuar creando el lote?', true) then begin
                                Clear(tlotes2);
                                if not tlotes2.Get(Rec."No.", 1) then begin
                                    tlotes2.Init();
                                    tlotes2.Lote := '1';
                                    tlotes2.Validate("No. Expediente", Rec."No.");
                                    tlotes2."Descripción expediente" := Rec.Descripción;
                                    tlotes2."Descripción lote" := Rec.Descripción;
                                    tlotes2."Organo de decisión" := Rec."Organo de decisión";
                                    tlotes2."Importe lote" := Rec."Importe adjudicado";
                                    tlotes2."Fecha adjudicacion" := Rec."Fecha adjudicación";
                                    tlotes2.Insert();
                                    exit;
                                end else begin
                                    tlotes4.SetCurrentKey(Lote);
                                    tlotes4.SetRange("No. Expediente", Rec."No.");
                                    if tlotes4.FindLast() then begin
                                        Clear(tlotes3);
                                        numerolote := 0;
                                        okinteger := Evaluate(numerolote, tlotes4.Lote);
                                        if not okinteger then
                                            Error('NO SE PUEDEN CREAR LOTES DESDE ESTE BOTÓN DEBIDO A QUE HAY LOTES EXISTENTES CON CÓDIGO ALFANUMÉRICO, DÉ DE ALTA EL LOTE A TRAVÉS DEL BOTÓN LOTES (PESTAÑA INICIO)');
                                        numerolote := numerolote + 1;
                                        tlotes3.Init();
                                        tlotes3.Lote := Format(numerolote);
                                        tlotes3.Validate("No. Expediente", Rec."No.");
                                        tlotes3."Descripción expediente" := Rec.Descripción;
                                        tlotes3."Descripción lote" := Rec.Descripción;
                                        tlotes3."Organo de decisión" := Rec."Organo de decisión";
                                        tlotes3."Importe lote" := Rec."Importe adjudicado";
                                        tlotes3."Fecha adjudicacion" := Rec."Fecha adjudicación";
                                        tlotes3.Insert();
                                        exit;
                                    end;
                                end;
                            end else
                                exit;
                        end else begin
                            Tlotes.Init();
                            Tlotes.Lote := '1';
                            Tlotes.Validate("No. Expediente", Rec."No.");
                            Tlotes."Descripción expediente" := Rec.Descripción;
                            Tlotes."Descripción lote" := Rec.Descripción;
                            Tlotes."Organo de decisión" := Rec."Organo de decisión";
                            Tlotes."Importe lote" := Rec."Importe adjudicado";
                            Tlotes."Fecha adjudicacion" := Rec."Fecha adjudicación";
                            Tlotes.Insert();
                        end;
                    end;
                }
                action("Seleccionar carpeta")
                {
                    ApplicationArea = All;
                    Image = Import;

                    trigger OnAction()
                    begin
                        Error(SelectFolderNotSupportedErr);
                    end;
                }
            }
        }
        area(navigation)
        {
            action(Lotes)
            {
                ApplicationArea = All;
                Image = Lot;
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Page "Lista Lotes";
                RunPageLink = "No. Expediente" = FIELD("No.");
            }
            action(OfertasRel)
            {
                ApplicationArea = All;
                Caption = 'Ofertas relacionadas';
                Image = Quote;
                RunObject = Page "Purchase Quotes";
                RunPageLink = "Document Type" = FILTER(Quote),
                              "No. expediente adjudicacion" = FIELD("No.");
            }
            action(OfertasRelArch)
            {
                ApplicationArea = All;
                Caption = 'Ofertas relacionadas Archivadas';
                Image = Archive;
                RunObject = Page "Purchase Quote Archives";
                RunPageLink = "Document Type" = FILTER(Quote),
                              "No. expediente adjudicacion" = FIELD("No.");
            }
            action("Pedidos relacionados")
            {
                ApplicationArea = All;
                Image = OrderList;
                RunObject = Page "Purchase Order List";
                RunPageLink = "No. expediente adjudicacion" = FIELD("No.");
            }
            action("Prefacturas relacionadas")
            {
                ApplicationArea = All;
                Image = Invoice;
                RunObject = Page "Purchase Invoices";
                RunPageLink = "No. expediente adjudicacion" = FIELD("No.");
            }
            action("Facturas registradas relacionados")
            {
                ApplicationArea = All;
                Image = Archive;
                RunObject = Page "Posted Purchase Invoices";
                RunPageLink = "No. expediente adjudicacion" = FIELD("No.");
            }
            action("Preabonos relacionadas")
            {
                ApplicationArea = All;
                Image = Invoice;
                RunObject = Page "Purchase Credit Memos";
                RunPageLink = "No. expediente adjudicacion" = FIELD("No.");
            }
            action("Abonos registradas relacionados")
            {
                ApplicationArea = All;
                Image = Archive;
                RunObject = Page "Posted Purchase Credit Memos";
                RunPageLink = "No. expediente adjudicacion" = FIELD("No.");
            }
            action("Facturas electrónicas")
            {
                ApplicationArea = All;
                Image = ElectronicDoc;
                RunObject = Page "Lista Factura Electrónica";
                RunPageLink = EXPEDIENTE = FIELD("No.");
            }
            action(Dimensions)
            {
                ApplicationArea = All;
                AccessByPermission = TableData 348 = R;
                Caption = 'Dimensions';
                Image = Dimensions;
                ShortCutKey = 'Shift+Ctrl+D';

                trigger OnAction()
                begin
                    Rec.ShowDocDim();
                    CurrPage.SaveRecord();
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        Rec.CalcFields(Prórroga);
    end;

    var
        vEditarProrroga: Boolean;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        FolderTxt: Text[1024];
        ERROR0001: Label 'Proceso cancelado por el usuario';
        CONFIRM001: Label 'En este expediente ya se ha lanzado la aprobacion, ¿desea volver a lanzar la aprobacion?';
        SelectFolderNotSupportedErr: Label 'La selección de carpetas locales mediante Automation/COM no es compatible con Business Central SaaS. Informe manualmente el vínculo o sustituya este proceso por una carga/selección SaaS.';

    [Scope('Internal')]
    procedure fEditarProrroga()
    begin
        /*
        IF Prórroga THEN
          vEditarProrroga := TRUE
        ELSE BEGIN
          "Fecha prórroga"   := 0D;
          "No. prórroga" := 0;
          vEditarProrroga := FALSE;
        END;
        */
    end;

    local procedure fCrearMovAprobExp(tExpediente: Record 50001; vIdAprobador: Code[20]; vNumAprob: Integer)
    var
        rlMovAprob: Record "Approval Entry";
        numAprob: Integer;
    begin
        numAprob := 0;
        Clear(rlMovAprob);
        if rlMovAprob.FindLast() then
            numAprob := rlMovAprob."Entry No." + 1
        else
            numAprob := 1;

        rlMovAprob.Init();
        rlMovAprob.Validate("Entry No.", numAprob);
        rlMovAprob.Insert();
        rlMovAprob.Validate("Table ID", 50001);
        rlMovAprob.Validate("Document Type", rlMovAprob."Document Type"::Expediente);
        rlMovAprob.Validate("Document No.", tExpediente."No.");
        rlMovAprob.Validate("Sequence No.", vNumAprob);
        rlMovAprob.Validate("Sender ID", UserId());
        rlMovAprob.Validate("Approver ID", vIdAprobador);
        if vNumAprob = 1 then
            rlMovAprob.Validate(Status, rlMovAprob.Status::Open)
        else
            rlMovAprob.Validate(Status, rlMovAprob.Status::Created);
        rlMovAprob.Validate("Date-Time Sent for Approval", CreateDateTime(Today(), Time()));
        rlMovAprob.Validate("Last Date-Time Modified", CreateDateTime(Today(), Time()));
        rlMovAprob.Validate("Last Modified By User ID", UserId());
        rlMovAprob.Validate(Amount, tExpediente."Importe adjudicado");
        rlMovAprob.Modify();
    end;

    local procedure factualizarVinculoCompras()
    var
        posicion: Integer;
        textoabuscar: Text[50];
        nuevaurl: Text[250];
        tconfcompras: Record "Purchases & Payables Setup";
        nuevotexto: Text[250];
        longitud: Integer;
    begin
        posicion := 0;
        longitud := 0;
        nuevotexto := '';
        nuevaurl := '';
        tconfcompras.Get();
        textoabuscar := '\NAV\Expedientes';
        posicion := StrPos(Rec."Bases expediente", textoabuscar);
        if posicion > 1 then begin
            longitud := StrLen(Rec."Bases expediente");
            nuevotexto := CopyStr(Rec."Bases expediente", posicion + 4, longitud);
            nuevaurl := tconfcompras."Ruta servidor documentos" + nuevotexto;
            Rec."Bases expediente" := nuevaurl;
        end;
    end;
}