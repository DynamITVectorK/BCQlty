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
    SourceTableView = WHERE (Tipo Contratación=FILTER(Compras));

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
                        IF AssistEdit(xRec) THEN
                          CurrPage.UPDATE;
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
            part(PurchReceiptLines;50028)
            {
                SubPageLink = No. Expediente=FIELD(No.);
            }
            group("Aprobaciones Factura")
            {
                Caption = 'Aprobaciones Factura';
                field("Aprobador 1"; Rec."Aprobador 1")
                {
                    ApplicationArea = All;
                }
                field("Aprobador 2"; Rec."Aprobador 2")
                {
                    ApplicationArea = All;
                }
                field("Aprobador 3"; Rec."Aprobador 3")
                {
                    ApplicationArea = All;
                }
                field("Aprobador 4"; Rec."Aprobador 4")
                {
                    ApplicationArea = All;
                }
                field("Aprobador 5"; Rec."Aprobador 5")
                {
                    ApplicationArea = All;
                }
            }
            group("Aprobaciones Expedientes")
            {
                Caption = 'Aprobaciones Expedientes';
                field("Aprobador 1 Exp"; Rec."Aprobador 1 Exp")
                {
                    ApplicationArea = All;
                }
                field("Aprobador 2 Exp"; Rec."Aprobador 2 Exp")
                {
                    ApplicationArea = All;
                }
                field("Aprobador 3 Exp"; Rec."Aprobador 3 Exp")
                {
                    ApplicationArea = All;
                }
                field("Aprobador 4 Exp"; Rec."Aprobador 4 Exp")
                {
                    ApplicationArea = All;
                }
                field("Aprobador 5 Exp"; Rec."Aprobador 5 Exp")
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
            group(Approval)
            {
                Caption = 'Approval';
                action(ArchivarOf)
                {
                    ApplicationArea = All;
                    Caption = 'Archivar ofertas expediente';
                    Image = Archive;
                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        //***Z004 - 400 - AT- 25/10/2016 - Inicio
                        IF CONFIRM('Esta acción archivará todas las ofertas del expediente. Previamente se debería haber adjudicado la oferta ganadora. ¿Está seguro de continuar?') THEN BEGIN
                          fArchivarOfertas;
                        END;

                        //***Z004 - 400 - AT- 25/10/2016 - Fin
                    end;
                }
                action(ImprimirDocumentoAsignacionExpediente)
                {
                    ApplicationArea = All;
                    Caption = 'Imprimir Documento Asignacion Expediente';
                    Image = Print;
                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = true;

                    trigger OnAction()
                    var
                        tlExpedientesadjudicacion: Record 50001;
                    begin
                        CLEAR(tlExpedientesadjudicacion);
                        tlExpedientesadjudicacion.SETRANGE("Tipo Contratación",tlExpedientesadjudicacion."Tipo Contratación"::Compras);
                        tlExpedientesadjudicacion.SETRANGE("No.","No.");
                        tlExpedientesadjudicacion.Print;
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
                        //INICIO Z035 - JRB - 05/05/2020 - Aprobaciones en expedientes
                        //zam038 IAG 220720  COMENTADO IF ("Aprobador 1 Exp"='') THEN   ERROR(Text50000);
                        IF Estado IN [Estado::"Adj.Provisional",Estado::"Adj.Definitiva"] THEN
                          IF NOT CONFIRM(CONFIRM001) THEN
                              ERROR(ERROR0001);
                        NUMAPROBACION:=0;
                        IF "Aprobador 1 Exp" <>'' THEN
                          BEGIN
                          fCrearMovAprobExp(Rec,"Aprobador 1 Exp",1);
                          NUMAPROBACION:=1;  //zam038 IAG 220720
                          END;
                        IF "Aprobador 2 Exp" <>'' THEN
                          BEGIN
                          fCrearMovAprobExp(Rec,"Aprobador 2 Exp",2);
                          IF NUMAPROBACION = 0 THEN  NUMAPROBACION := 2;  //zam038 IAG 220720
                          END;
                        IF "Aprobador 3 Exp" <>'' THEN
                          BEGIN
                          fCrearMovAprobExp(Rec,"Aprobador 3 Exp",3);
                          IF NUMAPROBACION = 0 THEN  NUMAPROBACION := 3; //zam038 IAG 220720
                          END;
                        IF "Aprobador 4 Exp" <>'' THEN
                          BEGIN
                          fCrearMovAprobExp(Rec,"Aprobador 4 Exp",4);
                          IF NUMAPROBACION = 0 THEN  NUMAPROBACION := 4; //zam038 IAG 220720
                          END;
                        IF "Aprobador 5 Exp" <>'' THEN
                          BEGIN
                          fCrearMovAprobExp(Rec,"Aprobador 5 Exp",5);
                          IF NUMAPROBACION = 0 THEN  NUMAPROBACION := 5; //zam038 IAG 220720
                          END;
                        //Mandar email a todos los aprobadores
                        CLEAR(ApprovalsMgt);
                        // //zam038 IAG 220720  linea comentada sustituida por debajo ApprovalsMgt.SendExpApprovalsMail(Rec,0);
                        ApprovalsMgt.SendExpApprovalsMail(Rec,NUMAPROBACION);  //zam038 IAG 220720

                        MESSAGE(Text50001);
                        Rec.VALIDATE(Estado,Estado::"Adj.Provisional");
                        //FIN Z035 - JRB - 05/05/2020 - Aprobaciones en expedientes
                    end;
                }
                action("Crear Lote")
                {
                    ApplicationArea = All;
                    Caption = 'Crear Lote';

                    trigger OnAction()
                    var
                        Tlotes: Record 50011;
                        inputdialogbox: Integer;
                        tlotes2: Record 50011;
                        tlotes3: Record 50011;
                        numerolote: Integer;
                        tlotes4: Record 50011;
                        okinteger: Boolean;
                    begin
                        //ZAM0038 IAG 21072020 inicio
                        CLEAR(Tlotes);
                        Tlotes.SETRANGE(Tlotes."No. Expediente","No.");
                        IF Tlotes.FINDFIRST THEN

                          BEGIN
                             IF CONFIRM('Ya existen lotes creados para éste expediente , desea continuar creando el lote?',TRUE) THEN
                             BEGIN

                             CLEAR(tlotes2);
                             IF NOT (tlotes2.GET("No.",1)) THEN
                               BEGIN
                                  tlotes2.INIT;
                                  tlotes2.Lote:='1';
                                  //tlotes2."No. Expediente":= Rec."No.";
                                  tlotes2.VALIDATE("No. Expediente",Rec."No.");
                                  tlotes2."Descripción expediente":= Rec.Descripción;
                                  tlotes2."Descripción lote":=Rec.Descripción;
                                  tlotes2."Organo de decisión":=Rec."Organo de decisión";
                                  tlotes2."Importe lote":=Rec."Importe adjudicado";
                                  tlotes2."Fecha adjudicacion":=Rec."Fecha adjudicación";
                                  tlotes2.INSERT;
                                  EXIT;
                               END ELSE
                                tlotes4.SETCURRENTKEY(Lote);
                                tlotes4.SETRANGE(tlotes4."No. Expediente","No.");
                                IF tlotes4.FINDLAST THEN
                                  BEGIN
                                      CLEAR(tlotes3);
                                      numerolote:=0;
                                      okinteger:=FALSE;
                                      okinteger:= EVALUATE(numerolote,tlotes4.Lote);
                                      IF okinteger= FALSE THEN ERROR('NO SE PUEDEN CREAR LOTES DESDE ESTE BOTÓN DEBIDO A QUE HAY LOTES EXISTENTES CON CÓDIGO ALFANUMÉRICO, DÉ DE ALTA EL LOTE A TRAVÉS DEL BOTÓN LOTES (PESTAÑA INICIO)');
                                      numerolote:= numerolote + 1;
                                      tlotes3.INIT;
                                      tlotes3.Lote:=FORMAT(numerolote);
                                      //tlotes3."No. Expediente":= Rec."No.";
                                      tlotes3.VALIDATE("No. Expediente",Rec."No.");
                                      tlotes3."Descripción expediente":= Rec.Descripción;
                                      tlotes3."Descripción lote":=Rec.Descripción;
                                      tlotes3."Organo de decisión":=Rec."Organo de decisión";
                                      tlotes3."Importe lote":=Rec."Importe adjudicado";
                                      tlotes3."Fecha adjudicacion":=Rec."Fecha adjudicación";
                                      tlotes3.INSERT;
                                      EXIT;
                                  END;
                            END ELSE EXIT;
                          END ELSE
                             Tlotes.INIT;
                             Tlotes.Lote:='1';
                             //Tlotes."No. Expediente":= Rec."No.";
                             Tlotes.VALIDATE("No. Expediente",Rec."No.");
                             Tlotes."Descripción expediente":= Rec.Descripción;
                             Tlotes."Descripción lote":=Rec.Descripción;
                             Tlotes."Organo de decisión":=Rec."Organo de decisión";
                             Tlotes."Importe lote":=Rec."Importe adjudicado";
                             Tlotes."Fecha adjudicacion":=Rec."Fecha adjudicación";
                             Tlotes.INSERT;
                        //ZAM0038 IAG 21072020 fin
                    end;
                }
                action("Seleccionar carpeta")
                {
                    ApplicationArea = All;
                    Image = Import;

                    trigger OnAction()
                    begin
                        //INICIO JRB 29/07/2020 Poder elegir una carpeta
                        IF ISCLEAR(ShellControl) THEN
                          CREATE(ShellControl,FALSE,TRUE);

                        Folder := ShellControl.BrowseForFolder(0,'Seleccione carpeta',0);
                        FolderItems := Folder.Items();
                        FolderItem := FolderItems.Item;
                        FolderTxt := FORMAT(FolderItem.Path);
                        Rec."Bases expediente":=FolderTxt;
                        factualizarVinculoCompras;
                        CLEAR(ShellControl);

                        //FIN JRB 29/07/2020 Poder elegir una carpeta
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
                RunObject = Page 50028;
                                RunPageLink = No. Expediente=FIELD(No.);
            }
            action(OfertasRel)
            {
                ApplicationArea = All;
                Caption = 'Ofertas relacionadas';
                Image = Quote;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";
                RunObject = Page 9306;
                                RunPageLink = Document Type=FILTER(Quote),
                              No. expediente adjudicacion=FIELD(No.);
            }
            action(OfertasRelArch)
            {
                ApplicationArea = All;
                Caption = 'Ofertas relacionadas Archivadas';
                Image = Archive;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";
                RunObject = Page 9346;
                                RunPageLink = Document Type=FILTER(Quote),
                              No. expediente adjudicacion=FIELD(No.);
            }
            action("Pedidos relacionados")
            {
                ApplicationArea = All;
                Image = OrderList;
                RunObject = Page 56;
                                RunPageLink = No. expediente adjudicacion=FIELD(No.);
            }
            action("Prefacturas relacionadas")
            {
                ApplicationArea = All;
                Image = Invoice;
                RunObject = Page 9308;
                                RunPageLink = No. expediente adjudicacion=FIELD(No.);
            }
            action("Facturas registradas relacionados")
            {
                ApplicationArea = All;
                Image = Archive;
                RunObject = Page 146;
                                RunPageLink = No. expediente adjudicacion=FIELD(No.);
            }
            action("Preabonos relacionadas")
            {
                ApplicationArea = All;
                Image = Invoice;
                RunObject = Page 9309;
                                RunPageLink = No. expediente adjudicacion=FIELD(No.);
            }
            action("Abonos registradas relacionados")
            {
                ApplicationArea = All;
                Image = Archive;
                RunObject = Page 147;
                                RunPageLink = No. expediente adjudicacion=FIELD(No.);
            }
            action("Facturas electrónicas")
            {
                ApplicationArea = All;
                Image = ElectronicDoc;
                RunObject = Page 50066;
                                RunPageLink = EXPEDIENTE=FIELD(No.);
            }
            action(Dimensions)
            {
                ApplicationArea = All;
                AccessByPermission = TableData 348=R;
                Caption = 'Dimensions';
                Image = Dimensions;
                ShortCutKey = 'Shift+Ctrl+D';

                trigger OnAction()
                begin
                    //Z035 - INICIO 28/04/2020 JRB Dimensiones en expedientes
                    ShowDocDim;
                    CurrPage.SAVERECORD;
                    //Z035 - FIN 28/04/2020 JRB Dimensiones en expedientes
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        //ZAM0038 IAG 20072020 campo prorroga puesto a flowfield
        Rec.CALCFIELDS(Prórroga);
    end;

    var
        vEditarProrroga: Boolean;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        // TODO SaaS: Automation/COM no es compatible con Business Central SaaS; sustituir por APIs AL nativas de XML/HTTP manteniendo el comportamiento original.
        ShellControl: Automation ;
        // TODO SaaS: Automation/COM no es compatible con Business Central SaaS; sustituir por APIs AL nativas de XML/HTTP manteniendo el comportamiento original.
        Folder: Automation ;
        // TODO SaaS: Automation/COM no es compatible con Business Central SaaS; sustituir por APIs AL nativas de XML/HTTP manteniendo el comportamiento original.
        FolderItems: Automation ;
        // TODO SaaS: Automation/COM no es compatible con Business Central SaaS; sustituir por APIs AL nativas de XML/HTTP manteniendo el comportamiento original.
        FolderItem: Automation ;
        FolderTxt: Text[1024];
        ERROR0001: Label 'Proceso cancelado por el usuario';
        CONFIRM001: Label 'En este expediente ya se ha lanzado la aprobacion, ¿desea volver a lanzar la aprobacion?';

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

    local procedure fCrearMovAprobExp(tExpediente: Record 50001;vIdAprobador: Code[20];vNumAprob: Integer)
    var
        rlMovAprob: Record "Approval Entry";
        numAprob: Integer;
    begin
        //INICIO JRB 04/05/2020 Crear movimientos aprobacion para expedientes
        numAprob:=0;
        CLEAR(rlMovAprob);
        IF rlMovAprob.FINDLAST THEN
          numAprob:=rlMovAprob."Entry No."+1
        ELSE
          numAprob:=1;

        rlMovAprob.INIT;
        rlMovAprob.VALIDATE("Entry No.",numAprob);
        rlMovAprob.INSERT;
        rlMovAprob.VALIDATE("Table ID",50001);
        rlMovAprob.VALIDATE("Document Type",rlMovAprob."Document Type"::Expediente);
        rlMovAprob.VALIDATE("Document No.",tExpediente."No.");
        rlMovAprob.VALIDATE("Sequence No.",vNumAprob);
        rlMovAprob.VALIDATE("Sender ID",USERID);
        rlMovAprob.VALIDATE("Approver ID",vIdAprobador);
        IF vNumAprob=1 THEN
           rlMovAprob.VALIDATE(Status,rlMovAprob.Status::Open)
        ELSE
           rlMovAprob.VALIDATE(Status,rlMovAprob.Status::Created);
        rlMovAprob.VALIDATE("Date-Time Sent for Approval",CREATEDATETIME(TODAY,TIME));
        rlMovAprob.VALIDATE("Last Date-Time Modified",CREATEDATETIME(TODAY,TIME));
        rlMovAprob.VALIDATE("Last Modified By User ID",USERID);
        //rlMovAprob.VALIDATE("Due Date",);
        rlMovAprob.VALIDATE(Amount,tExpediente."Importe adjudicado");
        rlMovAprob.MODIFY;
        //FIN JRB 04/05/2020 Crear movimientos aprobacion para expedientes
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
        //ZAM0039 IAG 17/7/29 ruta servidor documentos PARA VINCULOS
        posicion:=0;
        longitud:=0;
        nuevotexto:='';
        nuevaurl:='';
        tconfcompras.GET();
        textoabuscar:='\NAV\Expedientes';
        posicion:=STRPOS("Bases expediente",textoabuscar);
        IF posicion>1 THEN
        BEGIN
          longitud:=STRLEN("Bases expediente");
          nuevotexto:=COPYSTR("Bases expediente",posicion + 4,longitud);
          nuevaurl:=tconfcompras."Ruta servidor documentos" + nuevotexto;
          "Bases expediente":= nuevaurl;
        END;
    end;
}

