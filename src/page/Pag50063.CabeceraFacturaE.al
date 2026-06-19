page 50063 "Cabecera FacturaE"
{
    // Mod. S2G (FTD) 21-01-14: Envio de email de "Facturas recibidas rechazadas" (botón Rechazar)
    // Mod. S2G (JMG) 11-09-14: Añadir en calcfields el nombre de proveedor.
    // Mod. S2G (JMG) 11-09-14: Añade un filtro para los CIFs con prefijo de país.
    // I00103 Mod. S2G (MGL) 22-10-14: Incluir Fecha recepción documento
    // I00109 Mod. S2G (JSM) 22-10-14: Permitir creación de líneas de activo fijo en Factura Elec.
    // I00124 Mod. S2G (MGL) 07-11-14: No validar líneas sin cantidad, precio e importe.
    // I00189 Mod. S2G (EGR) 15-05-15: Enlazar el documento en curso con abonos además de con facturas y filtrar para no mostrar abono reg.
    // I00218 Mod. S2G (EGR) 07-07-15: Completar Nº abono proveedor cuando lo que se genera es un abono.
    // I00235 Mod. S2G (EGR) 06-10-15: Pasar el descuento con IVA.
    // I00253 Mod. S2G (APL) 01-02-16: Completar Fecha registro con Fecha entrada.
    // I00263 Mod. S2G (APL) 03-05-16: Cambiar CCC Pago por IBAN Pago.
    // I00279 Mod. S2G (MGL) 16-11-16: Recodificar formularios para que entren en licencia
    // 
    // Mod   Nr  Task        Dev Date       Comments
    // ====================================================================================================================================
    // Z004      CIMUBISA-08 IPP 2018.01.26 Gestión de FacturaE
    //   Added button
    //     Aprobar
    //   Added controls
    //     "Approval Status"
    //     "Area"
    //     "Approval Area User"
    //     "Approval Area User Name"
    //     "Approval Area Date"
    //   Added code
    //     OnAferGerRecord
    //     fRegistrar
    //     fCrearModificar
    // 
    // Z004  02              BGS 2018.01.30  Notificaciones Rechazos
    //   Added Code
    //     Rechazar
    // 
    // Z004  04  CIMUBISA-08 BGS 2018.02.08  Al aprobar una FacturaE, firmar el Documento PDF
    //   Added button
    //     OpenPDFDocumentSigned
    // 
    // //Z035 INICIO JRB 28/04/2020 Si el Lote tiene marcado Prorroga contar con el importe del campo Importe Prorroga

    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    UsageCategory = Administration;
    Permissions = TableData 50102 = rimd;
    SourceTable = 50007;
    SourceTableView = SORTING (Fecha Importación, Hora Importación)
                      ORDER(Descending);

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(ID_PLATAFORMA; Rec.ID_PLATAFORMA)
                {
                    ApplicationArea = All;
                    Editable = ID_PLATAFORMAEditable;
                }
                field(NUM; Rec.NUM)
                {
                    ApplicationArea = All;
                    Editable = NUMEditable;
                }
                field(SERIE; Rec.SERIE)
                {
                    ApplicationArea = All;
                    Editable = SERIEEditable;
                }
                field(FECHA_ENTRADA; Rec.FECHA_ENTRADA)
                {
                    ApplicationArea = All;
                    Editable = FECHA_ENTRADAEditable;
                }
                field(FECHA_DEVENGO; Rec.FECHA_DEVENGO)
                {
                    ApplicationArea = All;
                    Editable = FECHA_DEVENGOEditable;
                }
                field(EMISOR_CIF; Rec.EMISOR_CIF)
                {
                    ApplicationArea = All;
                    Editable = EMISOR_CIFEditable;
                }
                field(EMISOR_NOMBRE; Rec.EMISOR_NOMBRE)
                {
                    ApplicationArea = All;
                    Editable = EMISOR_NOMBREEditable;
                }
                field(TOTAL_BASES; Rec.TOTAL_BASES)
                {
                    ApplicationArea = All;
                    Editable = TOTAL_BASESEditable;
                }
                field(TOTAL_TASAS; Rec.TOTAL_TASAS)
                {
                    ApplicationArea = All;
                    Editable = TOTAL_TASASEditable;
                }
                field(TOTAL_PAGAR; Rec.TOTAL_PAGAR)
                {
                    ApplicationArea = All;
                    Editable = TOTAL_PAGAREditable;
                }
                field(RECEPTOR_CIF; Rec.RECEPTOR_CIF)
                {
                    ApplicationArea = All;
                    Editable = RECEPTOR_CIFEditable;
                }
                field("Proveedor NAV"; Rec."Proveedor NAV")
                {
                    ApplicationArea = All;
                    Editable = VNuevo;

                    trigger OnValidate()
                    begin
                        ProveedorNAVOnAfterValidate;
                    end;
                }
                field("Nombre proveedor"; Rec."Nombre proveedor")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Documento en Curso"; Rec."Documento en Curso")
                {
                    ApplicationArea = All;

                    trigger OnAssistEdit()
                    begin
                        CLEAR(rPurchaseHeader);
                        IF rPurchaseHeader.GET(rPurchaseHeader."Document Type"::Invoice, "Documento en Curso") THEN BEGIN
                            PAGE.RUN(51, rPurchaseHeader);
                        END
                        //I00189 Mod. S2G (EGR) 15-05-15: Enlazar el documento en curso con abonos además de con facturas.
                        ELSE BEGIN
                            CLEAR(rPurchaseHeader);
                            IF rPurchaseHeader.GET(rPurchaseHeader."Document Type"::"Credit Memo", "Documento en Curso") THEN
                                PAGE.RUN(52, rPurchaseHeader);
                        END;
                        //I00189 Mod. S2G (EGR) 15-05-15: Fin.
                    end;
                }
                field(EXPEDIENTE; Rec.EXPEDIENTE)
                {
                    ApplicationArea = All;
                }
                field(Lote; Rec.Lote)
                {
                    ApplicationArea = All;
                }
                field(Rechazada; Rec.Rechazada)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Fecha Importación"; Rec."Fecha Importación")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Hora Importación"; Rec."Hora Importación")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(FORMA_PAGO; Rec.FORMA_PAGO)
                {
                    ApplicationArea = All;
                    Editable = FORMA_PAGOEditable;
                }
                field(FECHA_PAGO; Rec.FECHA_PAGO)
                {
                    ApplicationArea = All;
                    Editable = FECHA_PAGOEditable;
                }
                field(CCC_PAGO; Rec.CCC_PAGO)
                {
                    ApplicationArea = All;
                    Editable = CCC_PAGOEditable;
                }
                field(NOTAS; Rec.NOTAS)
                {
                    ApplicationArea = All;
                    Editable = NOTASEditable;
                }
                field(CONTACTO_NOMBRE; Rec.CONTACTO_NOMBRE)
                {
                    ApplicationArea = All;
                    Editable = CONTACTO_NOMBREEditable;
                }
                field(CONTACTO_TELEFONO; Rec.CONTACTO_TELEFONO)
                {
                    ApplicationArea = All;
                    Editable = CONTACTO_TELEFONOEditable;
                }
                field(CONTACTO_EMAIL; Rec.CONTACTO_EMAIL)
                {
                    ApplicationArea = All;
                    Editable = CONTACTO_EMAILEditable;
                }
                field("DOCUMENTACIÓN ADJUNTA"; Rec."DOCUMENTACIÓN ADJUNTA")
                {
                    ApplicationArea = All;
                    Editable = "DOCUMENTACIÓN ADJUNTAEditable";

                    trigger OnAssistEdit()
                    begin
                        fAbrirContenedorAlfresco("DOCUMENTACIÓN ADJUNTA");

                        //HYPERLINK('http://pregesdoc31/alfresco/download/direct?path='+fQuitarCodigoRuta("DOCUMENTACIÓN ADJUNTA"));
                        //HYPERLINK("DOCUMENTACIÓN ADJUNTA");
                        //HYPERLINK('http://pregesdoc31/alfresco'+"DOCUMENTACIÓN ADJUNTA");
                    end;
                }
                field("DOCUMENTO PDF"; Rec."DOCUMENTO PDF")
                {
                    ApplicationArea = All;
                    Editable = "DOCUMENTO PDFEditable";

                    trigger OnAssistEdit()
                    begin
                        fAbrirDocumentoAlfresco("DOCUMENTO PDF");
                    end;
                }
                field("DOCUMENTO FACTURA"; Rec."DOCUMENTO FACTURA")
                {
                    ApplicationArea = All;
                    Editable = "DOCUMENTO FACTURAEditable";

                    trigger OnAssistEdit()
                    begin
                        fAbrirDocumentoAlfresco("DOCUMENTO FACTURA");
                    end;
                }
                field("Documento Registrado"; Rec."Documento Registrado")
                {
                    ApplicationArea = All;

                    trigger OnAssistEdit()
                    begin
                        CLEAR(rPurchInvHeader);
                        IF rPurchInvHeader.GET("Documento Registrado") THEN BEGIN
                            PAGE.RUN(138, rPurchInvHeader);
                        END;
                    end;
                }
                field("Motivo rechazo"; Rec."Motivo rechazo")
                {
                    ApplicationArea = All;
                    Editable = VPteAprobar;
                }
                field("Descripción Rechazo"; Rec."Descripción Rechazo")
                {
                    ApplicationArea = All;
                    Editable = false;
                    MultiLine = true;
                }
                field("CIF Proveedor"; Rec."CIF Proveedor")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
            part(Lineas; 50064)
            {
                SubPageLink = ID Factura=FIELD(ID_PLATAFORMA);
            }
            group("Datos Emisor")
            {
                Caption = 'Datos Emisor';
                field(EMISOR_DIRECCION; Rec.EMISOR_DIRECCION)
                {
                    ApplicationArea = All;
                    Editable = EMISOR_DIRECCIONEditable;
                }
                field(EMISOR_CIUDAD; Rec.EMISOR_CIUDAD)
                {
                    ApplicationArea = All;
                    Editable = EMISOR_CIUDADEditable;
                }
                field(EMISOR_PROVINCIA; Rec.EMISOR_PROVINCIA)
                {
                    ApplicationArea = All;
                    Editable = EMISOR_PROVINCIAEditable;
                }
                field(EMISOR_CP; Rec.EMISOR_CP)
                {
                    ApplicationArea = All;
                    Editable = EMISOR_CPEditable;
                }
                field(EMISOR_TELEFONO; Rec.EMISOR_TELEFONO)
                {
                    ApplicationArea = All;
                    Editable = EMISOR_TELEFONOEditable;
                }
                field(EMISOR_EMAIL; Rec.EMISOR_EMAIL)
                {
                    ApplicationArea = All;
                    Editable = EMISOR_EMAILEditable;
                }
            }
        }
        area(factboxes)
        {
            systempart(; Links)
            {
                Visible = true;
            }
            systempart(; Notes)
            {
                Visible = true;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Rechazar)
            {
                ApplicationArea = All;
                Caption = 'Rechazar';
                Image = Reject;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    CFileManagementL: Codeunit "File Management";
                    clNotificationEntryDispatcher: Codeunit "Notification Entry Dispatcher";
                    tlCabeceraFacturaERecibida: Record 50007;
                begin
                    //***AOC PASAR TODO A LA TABLA
                    /*
                    Rec.TESTFIELD(Rechazada,FALSE);
                    
                    Rec.CALCFIELDS("Documento en Curso","Documento Registrado");
                    Rec.TESTFIELD("Documento en Curso",'');
                    Rec.TESTFIELD("Documento Registrado",'');
                    Rec.TESTFIELD("Motivo rechazo");
                    IF NOT CONFIRM(vText50001) THEN
                       ERROR(vText50002);
                    Rechazada := TRUE;
                    Rec.MODIFY;
                    
                    //Mod. S2G (FTD) 21-01-14: Envio de email de "Facturas recibidas rechazadas" (botón Rechazar)
                    IF CONFIRM((vText50004),TRUE) THEN BEGIN
                      //>Z004  02              BGS 2018.01.30
                      CLEAR(tlCabeceraFacturaERecibida);
                      tlCabeceraFacturaERecibida.SETRANGE(ID_PLATAFORMA,ID_PLATAFORMA);
                      tlCabeceraFacturaERecibida.SETRANGE(NUM,NUM);
                      tlCabeceraFacturaERecibida.FINDFIRST;
                      clNotificationEntryDispatcher.fEnviarMailFacturasE(tlCabeceraFacturaERecibida,USERID);
                      //<Z004  02              BGS 2018.01.30
                    END;
                    //Mod. S2G (FTD) 21-01-14: FIN
                    
                    PfRechazarFacturaE(Rec);
                    
                    
                    MESSAGE(vText50003);
                    */
                    fRechazarFacturaEPaso1;
                    //FIN AOC PASAR A LA TABLA

                end;
            }
            action("Datos Respaldo")
            {
                ApplicationArea = All;
                Caption = 'Datos Respaldo';
                Image = TestDatabase;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    vlDatosNuevos: Boolean;
                    lText50000: Label 'No existe ningún registro sin traspasar en la Base de Datos de Respaldo.';
                    lText50001: Label 'Proceso cancelado por el usuario.';
                    lText50002: Label '¿Desea importar los datos que estén pendientes en la base de datos de respaldo?';
                    lText50003: Label 'Datos importados correctamente.';
                begin
                    //AOC; PASAR TODO A LA TABLA
                    /*
                    CLEAR(vlDatosNuevos);
                    //Pregunta de confirmación
                    IF NOT CONFIRM(lText50002) THEN
                       ERROR(lText50001);
                    //Llamada a la función que importa los datos de la base de datos de respaldo.
                    vlDatosNuevos := fTraerDatosRespaldo;
                    
                    IF NOT vlDatosNuevos THEN BEGIN
                       MESSAGE(lText50000);
                    END
                    ELSE BEGIN
                       MESSAGE(lText50003);
                    END;
                    */

                    fTraerDatosRespaldoPaso1;
                    //FIN AOC

                end;
            }
            action("Generate invoice")
            {
                ApplicationArea = All;
                Caption = 'Generate invoice';
                Enabled = GenerateInvoiceEnabled;
                Image = PostedTaxInvoice;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    CurrPage.UPDATE;

                    //>Z004      CIMUBISA-08 JLF 2018.03.23 Gestión de FacturaE
                    TesteoImportes;
                    //<Z004      CIMUBISA-08 JLF 2018.03.23 Gestión de FacturaE

                    fRegistrar(Rec, FALSE);
                    CurrPage.UPDATE;
                end;
            }
            action(Approve)
            {
                ApplicationArea = All;
                Caption = 'Approve';
                Enabled = false;
                Image = Approve;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = false;

                trigger OnAction()
                begin
                    ApproveEInvoice;
                    CurrPage.CLOSE;
                end;
            }
            action("Mandar para aprobar")
            {
                ApplicationArea = All;
                Enabled = false;
                Image = ChangeStatus;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = false;

                trigger OnAction()
                begin
                    //>Z004      CIMUBISA-08 JLF 2018.03.23 Gestión de FacturaE
                    TesteoImportes;
                    //<Z004      CIMUBISA-08 JLF 2018.03.23 Gestión de FacturaE

                    ApproveEInvoice;
                    CurrPage.CLOSE;
                end;
            }
            action(Sign)
            {
                ApplicationArea = All;
                Caption = 'Sign';
                Enabled = false;
                Image = Signature;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = false;

                trigger OnAction()
                begin
                    fSignDocument("DOCUMENTO PDF");
                    //CurrPage.CLOSE;
                end;
            }
            action(OpenPDFDocumentSigned)
            {
                ApplicationArea = All;
                Caption = 'Sign';
                Image = Signature;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = "Approval Status" = "Approval Status"::"Approved";

                trigger OnAction()
                begin
                    CConfigProgressBar.Init(1, 0, Text5000);
                    fOpenSignedPDFDocument;
                    CConfigProgressBar.Close;
                end;
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
        fEditables;
        CIFProveedorOnFormat;

        /*
        //>IPP Z004      CIMUBISA-08 IPP 2018.01.26 Gestión de FacturaE
        GenerateInvoiceEnabled := ("Approval Status" = "Approval Status"::Approved);
        //<IPP Z004      CIMUBISA-08 IPP 2018.01.26 Gestión de FacturaE
        */
        GenerateInvoiceEnabled := TRUE;

    end;

    trigger OnInit()
    begin
        "DOCUMENTO FACTURAEditable" := TRUE;
        "DOCUMENTO PDFEditable" := TRUE;
        "DOCUMENTACIÓN ADJUNTAEditable" := TRUE;
        TOTAL_PAGAREditable := TRUE;
        TOTAL_TASASEditable := TRUE;
        TOTAL_BASESEditable := TRUE;
        CONTACTO_EMAILEditable := TRUE;
        CONTACTO_TELEFONOEditable := TRUE;
        CONTACTO_NOMBREEditable := TRUE;
        NOTASEditable := TRUE;
        CCC_PAGOEditable := TRUE;
        FECHA_PAGOEditable := TRUE;
        FORMA_PAGOEditable := TRUE;
        RECEPTOR_CIFEditable := TRUE;
        EMISOR_EMAILEditable := TRUE;
        EMISOR_TELEFONOEditable := TRUE;
        EMISOR_CPEditable := TRUE;
        EMISOR_PROVINCIAEditable := TRUE;
        EMISOR_CIUDADEditable := TRUE;
        EMISOR_DIRECCIONEditable := TRUE;
        EMISOR_NOMBREEditable := TRUE;
        EMISOR_CIFEditable := TRUE;
        FECHA_DEVENGOEditable := TRUE;
        FECHA_ENTRADAEditable := TRUE;
        SERIEEditable := TRUE;
        NUMEditable := TRUE;
        ID_PLATAFORMAEditable := TRUE;
    end;

    trigger OnOpenPage()
    begin
        fEditables;
    end;

    var
        vText50000: Label 'Se ha generado la factura %1. Puede proceder a su revisión.';
        vText50001: Label '¿Desea rechazar esta factura?';
        vText50002: Label 'Proceso cancelado por el usuario.';
        vText50003: Label 'Factura rechazada correctamente.';
        rPurchaseHeader: Record "Purchase Header";
        rPurchInvHeader: Record "Purch. Inv. Header";
        vText50004: Label '¿ Desea enviar un correo de rechazo ?';
        vPasado: Boolean;
        [InDataSet]
        "CIF ProveedorEmphasize": Boolean;
        [InDataSet]
        ID_PLATAFORMAEditable: Boolean;
        [InDataSet]
        NUMEditable: Boolean;
        [InDataSet]
        SERIEEditable: Boolean;
        [InDataSet]
        FECHA_ENTRADAEditable: Boolean;
        [InDataSet]
        FECHA_DEVENGOEditable: Boolean;
        [InDataSet]
        EMISOR_CIFEditable: Boolean;
        [InDataSet]
        EMISOR_NOMBREEditable: Boolean;
        [InDataSet]
        EMISOR_DIRECCIONEditable: Boolean;
        [InDataSet]
        EMISOR_CIUDADEditable: Boolean;
        [InDataSet]
        EMISOR_PROVINCIAEditable: Boolean;
        [InDataSet]
        EMISOR_CPEditable: Boolean;
        [InDataSet]
        EMISOR_TELEFONOEditable: Boolean;
        [InDataSet]
        EMISOR_EMAILEditable: Boolean;
        [InDataSet]
        RECEPTOR_CIFEditable: Boolean;
        [InDataSet]
        FORMA_PAGOEditable: Boolean;
        [InDataSet]
        FECHA_PAGOEditable: Boolean;
        [InDataSet]
        CCC_PAGOEditable: Boolean;
        [InDataSet]
        NOTASEditable: Boolean;
        [InDataSet]
        CONTACTO_NOMBREEditable: Boolean;
        [InDataSet]
        CONTACTO_TELEFONOEditable: Boolean;
        [InDataSet]
        CONTACTO_EMAILEditable: Boolean;
        [InDataSet]
        TOTAL_BASESEditable: Boolean;
        [InDataSet]
        TOTAL_TASASEditable: Boolean;
        [InDataSet]
        TOTAL_PAGAREditable: Boolean;
        [InDataSet]
        "DOCUMENTACIÓN ADJUNTAEditable": Boolean;
        [InDataSet]
        "DOCUMENTO PDFEditable": Boolean;
        [InDataSet]
        "DOCUMENTO FACTURAEditable": Boolean;
        [InDataSet]
        GenerateInvoiceEnabled: Boolean;
        VPteAprobar: Boolean;
        VNuevo: Boolean;
        vText50005: Label '%1 (%2) debe ser igual a %3 (%4) de las líneas';
        CConfigProgressBar: Codeunit "Config. Progress Bar";
        Text5000: Label 'Opening documents';
        vText50006: Label 'El importe total de la factura supera el del lote';
        vText50007: Label 'Debe indicar %1';

    [Scope('Internal')]
    procedure PfRegistrar(pFactura: Record 50007; pRegistrar: Boolean)
    var
        rlPurchaseHeader: Record "Purchase Header";
        rlPurchaseLine: Record "Purchase Line";
        rlVendor: Record "Vendor";
        rlLineasFacturaERecibida: Record 50008;
        rlTasasyRetencionesFacturaE: Record 50009;
        lText50000: Label 'Esta factura ya está registrada.';
        lText50001: Label 'Proceso cancelado por el usuario.';
        lText50002: Label '¿Desea registrar esta factura?';
        rlTasasyRetencionesFacturaERet: Record 50009;
        rlPurchInvHeader: Record "Purch. Inv. Header";
        lText50003: Label 'Esta factura ya está cargada como factura en curso.';
        lText50004: Label '¿Desea generar esta factura?';
        rlPurchCommentLine: Record "Purch. Comment Line";
        vlLinea: Integer;
        rlCabeceraContratacion: Record 50002;
        rlLineasContratacion: Record 50003;
        vlCodigoContratacion: Code[20];
        vlLineaContratacion: Integer;
        vlLimpiar: Boolean;
        lText50005: Label 'El CIF del proveedor elegido es distinto al original\\¿Desea continuar?';
        lText50006: Label 'Esta factura está rechazada, no se puede registrar.';
        ExpAdjudicacion: Record 50001;
    begin
        //Genera y registra la factura de compra correspondiente.
        //Comprueba si está registrada
        IF Registrada THEN
            ERROR(lText50000);

        IF Rechazada THEN
            ERROR(lText50006);

        //>IPP Z004      CIMUBISA-08 IPP 2018.01.26 Gestión de FacturaE
        Rec.TESTFIELD("Approval Status", "Approval Status"::Approved);
        //<IPP Z004      CIMUBISA-08 IPP 2018.01.26 Gestión de FacturaE

        CLEAR(rlPurchInvHeader);
        rlPurchInvHeader.SETRANGE("ID Plataforma FacturaE", pFactura.ID_PLATAFORMA);
        rlPurchInvHeader.SETRANGE("Numero FacturaE", pFactura.NUM);
        IF rlPurchInvHeader.FINDFIRST THEN
            ERROR(lText50000);

        CLEAR(rlPurchaseHeader);
        //rlPurchaseHeader.SETRANGE("Document Type",rlPurchaseHeader."Document Type"::Invoice);
        rlPurchaseHeader.SETFILTER("Document Type", '%1|%2', rlPurchaseHeader."Document Type"::Invoice
                                              , rlPurchaseHeader."Document Type"::"Credit Memo");
        rlPurchaseHeader.SETRANGE("ID Plataforma FacturaE", pFactura.ID_PLATAFORMA);
        rlPurchaseHeader.SETRANGE("Numero FacturaE", pFactura.NUM);
        IF rlPurchaseHeader.FINDFIRST THEN
            ERROR(lText50003);

        //Pregunta de confirmación
        IF pRegistrar THEN BEGIN
            IF NOT CONFIRM(lText50002) THEN
                ERROR(lText50001);
        END
        ELSE BEGIN
            IF NOT CONFIRM(lText50004) THEN
                ERROR(lText50001);
        END;

        Rec.CALCFIELDS("CIF Proveedor");
        //Mod. S2G (JMG) 11-09-14: Añade un filtro para los CIFs con prefijo de país.
        //IF "CIF Proveedor" <> EMISOR_CIF THEN
        IF ("CIF Proveedor" <> EMISOR_CIF) AND ("CIF Proveedor" <> rlLineasFacturaERecibida.fQuitarPaisCIF(EMISOR_CIF)) THEN
            //Mod. S2G (JMG) 11-09-14: Fin.
            IF NOT CONFIRM(lText50005) THEN
                ERROR(lText50001);

        //Rellena los datos de cabecera.
        CLEAR(rlPurchaseHeader);
        rlPurchaseHeader.INIT;
        //rlPurchaseHeader.VALIDATE("Document Type",rlPurchaseHeader."Document Type"::Invoice);
        IF pFactura.TOTAL_PAGAR > 0 THEN
            rlPurchaseHeader.VALIDATE("Document Type", rlPurchaseHeader."Document Type"::Invoice)
        ELSE
            rlPurchaseHeader.VALIDATE("Document Type", rlPurchaseHeader."Document Type"::"Credit Memo");
        rlPurchaseHeader.INSERT(TRUE);
        /*
        CLEAR(rlVendor);
        rlVendor.SETRANGE("VAT Registration No.",pFactura.EMISOR_CIF);
        rlVendor.FINDFIRST;
        */
        Rec.TESTFIELD("Proveedor NAV");
        rlPurchaseHeader.VALIDATE("Buy-from Vendor No.", "Proveedor NAV");
        //I00218 Mod. S2G (EGR) 07-07-15: Completar Nº abono proveedor cuando lo que se genera es un abono.
        IF pFactura.TOTAL_PAGAR > 0 THEN
            //I00218 Mod. S2G (EGR) 07-07-15: Fin.
            rlPurchaseHeader.VALIDATE("Vendor Invoice No.", pFactura.NUM)
        //I00218 Mod. S2G (EGR) 07-07-15: Completar Nº abono proveedor cuando lo que se genera es un abono.
        ELSE
            rlPurchaseHeader.VALIDATE("Vendor Cr. Memo No.", pFactura.NUM);
        //I00218 Mod. S2G (EGR) 07-07-15: Fin.
        rlPurchaseHeader.VALIDATE("ID Plataforma FacturaE", pFactura.ID_PLATAFORMA);
        rlPurchaseHeader.VALIDATE("Numero FacturaE", pFactura.NUM);
        rlPurchaseHeader.VALIDATE("Document Date", pFactura.FECHA_DEVENGO);

        //I00103 Mod. S2G (MGL) 22-10-14: Incluir Fecha recepción documento
        rlPurchaseHeader.VALIDATE("Fecha recepcion documento", pFactura.FECHA_ENTRADA);
        //I00103 Mod. S2G (MGL) 22-10-14: Fin

        //I00253 Mod. S2G (APL) 01-02-16: Completar Fecha registro con Fecha entrada.
        rlPurchaseHeader.VALIDATE("Posting Date", pFactura.FECHA_ENTRADA);
        //I00253 Mod. S2G (APL) 01-02-16: Fin.

        //Z035 - JLF - 19/07/19: Inicio
        CLEAR(ExpAdjudicacion);
        IF ExpAdjudicacion.GET(ExpAdjudicacion."Tipo Contratación"::Compras, pFactura.EXPEDIENTE) THEN BEGIN
            rlPurchaseHeader.VALIDATE("Aprobador 1", ExpAdjudicacion."Aprobador 1");
            rlPurchaseHeader.VALIDATE("Aprobador 2", ExpAdjudicacion."Aprobador 2");
            rlPurchaseHeader.VALIDATE("Aprobador 3", ExpAdjudicacion."Aprobador 3");
            rlPurchaseHeader.VALIDATE("Aprobador 4", ExpAdjudicacion."Aprobador 4");
        END;
        //Z035 - JLF - 19/07/19: Fin

        rlPurchaseHeader.MODIFY(TRUE);
        /*
        IF pFactura."DOCUMENTACIÓN ADJUNTA" <> '' THEN
           rlPurchaseHeader.ADDLINK(pFactura."DOCUMENTACIÓN ADJUNTA");
        IF pFactura."DOCUMENTO PDF" <> '' THEN
           rlPurchaseHeader.ADDLINK(pFactura."DOCUMENTO PDF");
        IF pFactura."DOCUMENTO FACTURA" <> '' THEN
           rlPurchaseHeader.ADDLINK(pFactura."DOCUMENTO FACTURA");
        */
        fCopiarDocumentosAlfresco(Rec, rlPurchaseHeader);

        //Rellena los datos de línea.
        vlLinea := 10000;
        vlLimpiar := FALSE;
        CLEAR(rlLineasFacturaERecibida);
        rlLineasFacturaERecibida.SETRANGE("ID Factura", pFactura.ID_PLATAFORMA);
        IF rlLineasFacturaERecibida.FINDSET THEN
            REPEAT
                rlLineasFacturaERecibida.CALCFIELDS(Tasas, Retenciones);
                //I00124 Mod. S2G (MGL) 07-11-14: No validar líneas sin cantidad, precio e importe.
                IF (rlLineasFacturaERecibida.CANTIDAD <> 0) AND (rlLineasFacturaERecibida.PRECIO <> 0) THEN
                    //I00124 Mod. S2G (MGL) 07-11-14: Fin.
                    rlLineasFacturaERecibida.TESTFIELD("Cuenta NAV");
                CLEAR(rlPurchaseLine);
                rlPurchaseLine.INIT;
                rlPurchaseLine."Document Type" := rlPurchaseHeader."Document Type";
                rlPurchaseLine."Document No." := rlPurchaseHeader."No.";
                rlPurchaseLine."Line No." := vlLinea;
                IF NOT vlLimpiar THEN
                    rlPurchaseLine.INSERT(TRUE);
                rlPurchaseLine."Buy-from Vendor No." := rlPurchaseHeader."Buy-from Vendor No.";

                //I00109 Mod. S2G (JSM) 22-10-14: Permitir creación de líneas de activo fijo en Factura Elec.
                IF (rlLineasFacturaERecibida."Cod Activo" <> '') THEN BEGIN
                    rlPurchaseLine.VALIDATE(Type, rlPurchaseLine.Type::"Fixed Asset");
                    rlPurchaseLine.VALIDATE("No.", rlLineasFacturaERecibida."Cod Activo");
                END ELSE BEGIN
                    //I00109 Mod. S2G (JSM) 22-10-14: Fin.
                    //I00124 Mod. S2G (MGL) 07-11-14: No validar líneas sin cantidad, precio e importe.
                    IF (rlLineasFacturaERecibida.CANTIDAD <> 0) AND (rlLineasFacturaERecibida.PRECIO <> 0) THEN BEGIN
                        //I00124 Mod. S2G (MGL) 07-11-14: Fin.
                        rlPurchaseLine.VALIDATE(Type, rlPurchaseLine.Type::"G/L Account");
                        rlPurchaseLine.VALIDATE("No.", rlLineasFacturaERecibida."Cuenta NAV");
                        //I00124 Mod. S2G (MGL) 07-11-14: No validar líneas sin cantidad, precio e importe.
                    END;
                    //I00124 Mod. S2G (MGL) 07-11-14: Fin.
                END;

                rlPurchaseLine.VALIDATE(Description, COPYSTR(rlLineasFacturaERecibida.DESCRIPCION, 1, 50));
                rlPurchaseLine.VALIDATE("Description 2", COPYSTR(rlLineasFacturaERecibida.DESCRIPCION, 51, 50));
                //I00124 Mod. S2G (MGL) 07-11-14: No validar líneas sin cantidad, precio e importe.
                IF (rlLineasFacturaERecibida.CANTIDAD <> 0) THEN
                    //I00124 Mod. S2G (MGL) 07-11-14: Fin.
                    IF rlPurchaseHeader."Document Type" = rlPurchaseHeader."Document Type"::Invoice THEN
                        rlPurchaseLine.VALIDATE(Quantity, rlLineasFacturaERecibida.CANTIDAD)
                    ELSE
                        rlPurchaseLine.VALIDATE(Quantity, -rlLineasFacturaERecibida.CANTIDAD);
                //   rlPurchaseLine.VALIDATE("Direct Unit Cost",rlLineasFacturaERecibida.PRECIO);
                //   rlPurchaseLine.VALIDATE("Amount",(rlLineasFacturaERecibida.CANTIDAD * rlLineasFacturaERecibida.PRECIO) *
                //                                  (1+ (rlLineasFacturaERecibida.Tasas / 100)));
                //I00124 Mod. S2G (MGL) 07-11-14: No validar líneas sin cantidad, precio e importe.
                IF (rlLineasFacturaERecibida.PRECIO <> 0) THEN
                    //I00124 Mod. S2G (MGL) 07-11-14: Fin.
                    rlPurchaseLine.VALIDATE("Direct Unit Cost", (rlLineasFacturaERecibida.PRECIO) *
                                             (1 + (rlLineasFacturaERecibida.Tasas / 100)));
                //I00124 Mod. S2G (MGL) 07-11-14: No validar líneas sin cantidad, precio e importe.
                IF (rlLineasFacturaERecibida.DESCUENTO <> 0) THEN
                    //I00124 Mod. S2G (MGL) 07-11-14: Fin.
                    //I00235 Mod. S2G (EGR) 06-10-15: Pasar el descuento con IVA.
                    //   rlPurchaseLine.VALIDATE("Line Discount Amount",rlLineasFacturaERecibida.DESCUENTO);
                    rlPurchaseLine.VALIDATE("Line Discount Amount", (rlLineasFacturaERecibida.DESCUENTO) *
                                             (1 + (rlLineasFacturaERecibida.Tasas / 100)));
                //I00235 Mod. S2G (EGR) 06-10-15: Pasar el descuento con IVA. FIN
                rlPurchaseLine.VALIDATE("ID Plataforma FacturaE", rlPurchaseHeader."ID Plataforma FacturaE");
                rlPurchaseLine.VALIDATE("Numero FacturaE", rlPurchaseHeader."Numero FacturaE");
                rlPurchaseLine.VALIDATE("Linea FacturaE", rlLineasFacturaERecibida.Linea);

                //***ZAM0004; AOC; 13/02/18; Unir E-factura con necesidades
                /*
                vlCodigoContratacion := '';

                IF rlLineasFacturaERecibida."Pedido NAV" <> '' THEN BEGIN
                   CLEAR(rlCabeceraContratacion);
                   rlCabeceraContratacion.SETRANGE("No. Pedido Proveedor",rlLineasFacturaERecibida."Pedido NAV");
                   IF rlCabeceraContratacion.FINDFIRST THEN BEGIN
                      CLEAR(rlLineasContratacion);
                      rlLineasContratacion.SETRANGE("Cod. Contratacion",rlCabeceraContratacion."Cod. Contratacion");
                      IF rlLineasContratacion.COUNT = 1 THEN BEGIN
                         IF rlLineasContratacion.FINDFIRST THEN BEGIN
                            vlCodigoContratacion := rlCabeceraContratacion."Cod. Contratacion";
                            vlLineaContratacion := rlLineasContratacion."Line No.";
                         END;
                      END;
                   END;
                END
                ELSE IF rlLineasFacturaERecibida."REFERENCIA DEL RECEPTOR" <> '' THEN BEGIN
                   CLEAR(rlCabeceraContratacion);
                   rlCabeceraContratacion.SETRANGE("No. Pedido Proveedor",rlLineasFacturaERecibida."REFERENCIA DEL RECEPTOR");
                   IF rlCabeceraContratacion.FINDFIRST THEN BEGIN
                      CLEAR(rlLineasContratacion);
                      rlLineasContratacion.SETRANGE("Cod. Contratacion",rlCabeceraContratacion."Cod. Contratacion");
                      rlLineasContratacion.SETRANGE("No. Cuenta",rlLineasFacturaERecibida."Cuenta NAV");
                      IF rlLineasContratacion.FINDFIRST THEN
                         vlCodigoContratacion := rlCabeceraContratacion."Cod. Contratacion";
                         vlLineaContratacion := rlLineasContratacion."Line No.";
                   END;
                END;
                */
                //***ZAM0004; AOC; 13/02/18; fin
                CLEAR(rlTasasyRetencionesFacturaE);
                rlTasasyRetencionesFacturaE.SETRANGE("ID Factura", rlLineasFacturaERecibida."ID Factura");
                rlTasasyRetencionesFacturaE.SETRANGE(Linea, rlLineasFacturaERecibida.Linea);
                rlTasasyRetencionesFacturaE.SETFILTER(TASA, '<>%1', 0);
                IF (rlTasasyRetencionesFacturaE.COUNT <= 1) THEN BEGIN
                    //I00124 Mod. S2G (MGL) 07-11-14: No validar líneas sin cantidad, precio e importe.
                    IF (rlLineasFacturaERecibida.PRECIO <> 0) THEN BEGIN
                        //I00124 Mod. S2G (MGL) 07-11-14: Fin.
                        rlLineasFacturaERecibida.TESTFIELD("Código IVA NAV");
                        rlPurchaseLine.VALIDATE("VAT Prod. Posting Group", rlLineasFacturaERecibida."Código IVA NAV");
                        rlPurchaseLine.VALIDATE("Direct Unit Cost", (rlLineasFacturaERecibida.PRECIO) *
                                                    (1 + (rlLineasFacturaERecibida.Tasas / 100)));
                        //       rlPurchaseLine.VALIDATE(Amount,(rlLineasFacturaERecibida.CANTIDAD * rlLineasFacturaERecibida.PRECIO) *
                        //                                     (1+ (rlLineasFacturaERecibida.Tasas / 100)));
                        //       rlPurchaseLine.VALIDATE("Line Amount",(rlLineasFacturaERecibida.CANTIDAD * rlLineasFacturaERecibida.PRECIO) *
                        //                                     (1+ (rlLineasFacturaERecibida.Tasas / 100)));
                        //***ZAM0004; AOC; 13/02/18; Unir E-factura con necesidades
                        /*
                        IF vlCodigoContratacion <> '' THEN BEGIN
                           rlPurchaseLine."No. Linea contratacion" := vlLineaContratacion;
                           rlPurchaseLine.VALIDATE("Shortcut Dimension 1 Code",rlLineasContratacion."Shortcut Dimension 1 Code");
                           rlPurchaseLine.VALIDATE("Shortcut Dimension 2 Code",rlLineasContratacion."Shortcut Dimension 2 Code");
                           rlPurchaseLine.VALIDATE("Cod. contratacion",vlCodigoContratacion);
                        END;
                        */
                        /*
                        rlPurchaseLine.VALIDATE("Purchase Need No.",rlLineasFacturaERecibida."Purchase Need No.");
                        rlPurchaseLine.VALIDATE("Purchase Need Line No.",rlLineasFacturaERecibida."Purchase Need Line No.");
                        //meter las dimensiones
                        IF TPurchaseNeedLineL.GET(rlLineasFacturaERecibida."Purchase Need No.",rlLineasFacturaERecibida."Purchase Need Line No.") THEN BEGIN
                          rlPurchaseLine.VALIDATE("Shortcut Dimension 1 Code",TPurchaseNeedLineL."Shortcut Dimension 1 Code");
                          rlPurchaseLine.VALIDATE("Shortcut Dimension 2 Code",TPurchaseNeedLineL."Shortcut Dimension 2 Code");
                          rlPurchaseLine."Dimension Set ID":= TPurchaseNeedLineL."Dimension Set ID";
                        END;
                        */
                        //***ZAM0004; AOC; 13/02/18; fin
                        rlPurchaseLine.VALIDATE("Shortcut Dimension 1 Code", rlLineasFacturaERecibida."Shortcut Dimension 1 Code");
                        rlPurchaseLine.VALIDATE("Shortcut Dimension 2 Code", rlLineasFacturaERecibida."Shortcut Dimension 2 Code");
                        //I00124 Mod. S2G (MGL) 07-11-14: No validar líneas sin cantidad, precio e importe.
                    END;
                    //I00124 Mod. S2G (MGL) 07-11-14: Fin.
                    PfCrearModificar(rlLineasFacturaERecibida, rlPurchaseHeader, rlPurchaseLine, vlLinea);

                    CLEAR(rlTasasyRetencionesFacturaERet);
                    rlTasasyRetencionesFacturaERet.SETRANGE("ID Factura", rlLineasFacturaERecibida."ID Factura");
                    rlTasasyRetencionesFacturaERet.SETRANGE(Linea, rlLineasFacturaERecibida.Linea);
                    rlTasasyRetencionesFacturaERet.SETFILTER(RETENCION, '<>%1', 0);
                    IF (rlTasasyRetencionesFacturaERet.COUNT <= 1) THEN BEGIN
                        IF (rlTasasyRetencionesFacturaERet.COUNT = 1) THEN
                            //I00124 Mod. S2G (MGL) 07-11-14: No validar líneas sin cantidad, precio e importe.
                            IF (rlLineasFacturaERecibida.PRECIO <> 0) THEN BEGIN
                                //I00124 Mod. S2G (MGL) 07-11-14: Fin.
                                rlLineasFacturaERecibida.TESTFIELD("Código IRPF NAV");
                                IF rlLineasFacturaERecibida."Código IRPF NAV" <> '' THEN BEGIN
                                    rlPurchaseLine.VALIDATE("No.", rlLineasFacturaERecibida."Cuenta NAV");
                                    rlPurchaseLine.VALIDATE(Description, 'Retención ' + rlLineasFacturaERecibida.DESCRIPCION);
                                    rlPurchaseLine.VALIDATE("Direct Unit Cost", -(rlLineasFacturaERecibida.PRECIO) *
                                                                (rlLineasFacturaERecibida.Retenciones / 100));
                                    //                rlPurchaseLine.VALIDATE(Amount,-(rlLineasFacturaERecibida.CANTIDAD * rlLineasFacturaERecibida.PRECIO) *
                                    //                                           (rlLineasFacturaERecibida.Retenciones / 100));
                                    //                rlPurchaseLine.VALIDATE("Codigo retencion IRPF",rlLineasFacturaERecibida."Código IRPF NAV");
                                    //***ZAM0004; AOC; 13/02/18; Unir E-factura con necesidades
                                    /*
                                    IF vlCodigoContratacion <> '' THEN BEGIN
                                      rlPurchaseLine."No. Linea contratacion" := vlLineaContratacion;
                                      rlPurchaseLine.VALIDATE("Shortcut Dimension 1 Code",rlLineasContratacion."Shortcut Dimension 1 Code");
                                      rlPurchaseLine.VALIDATE("Shortcut Dimension 2 Code",rlLineasContratacion."Shortcut Dimension 2 Code");
                                      rlPurchaseLine.VALIDATE("Cod. contratacion",vlCodigoContratacion);
                                    END;
                                    */
                                    /*
                                    rlPurchaseLine.VALIDATE("Purchase Need No.",rlLineasFacturaERecibida."Purchase Need No.");
                                    rlPurchaseLine.VALIDATE("Purchase Need Line No.",rlLineasFacturaERecibida."Purchase Need Line No.");
                                    //meter las dimensiones
                                    IF TPurchaseNeedLineL.GET(rlLineasFacturaERecibida."Purchase Need No.",rlLineasFacturaERecibida."Purchase Need Line No.") THEN BEGIN
                                      rlPurchaseLine.VALIDATE("Shortcut Dimension 1 Code",TPurchaseNeedLineL."Shortcut Dimension 1 Code");
                                      rlPurchaseLine.VALIDATE("Shortcut Dimension 2 Code",TPurchaseNeedLineL."Shortcut Dimension 2 Code");
                                      rlPurchaseLine."Dimension Set ID":= TPurchaseNeedLineL."Dimension Set ID";
                                    END;
                                    */
                                    //***ZAM0004; AOC; 13/02/18; fin
                                    rlPurchaseLine.VALIDATE("Shortcut Dimension 1 Code", rlLineasFacturaERecibida."Shortcut Dimension 1 Code");
                                    rlPurchaseLine.VALIDATE("Shortcut Dimension 2 Code", rlLineasFacturaERecibida."Shortcut Dimension 2 Code");

                                    PfCrearModificar(rlLineasFacturaERecibida, rlPurchaseHeader, rlPurchaseLine, vlLinea);
                                END;
                                //I00124 Mod. S2G (MGL) 07-11-14: No validar líneas sin cantidad, precio e importe.
                            END;
                        //I00124 Mod. S2G (MGL) 07-11-14: Fin.
                    END
                    ELSE
                        IF rlTasasyRetencionesFacturaERet.FINDSET THEN
                            REPEAT
                                //I00124 Mod. S2G (MGL) 07-11-14: No validar líneas sin cantidad, precio e importe.
                                IF (rlLineasFacturaERecibida.PRECIO <> 0) THEN BEGIN
                                    //I00124 Mod. S2G (MGL) 07-11-14: Fin.
                                    rlTasasyRetencionesFacturaERet.TESTFIELD("Código IRPF NAV");
                                    //             rlPurchaseLine.VALIDATE("Codigo retencion IRPF",rlTasasyRetencionesFacturaERet."Código IRPF NAV");
                                    rlPurchaseLine.VALIDATE("No.", rlLineasFacturaERecibida."Cuenta NAV");
                                    rlPurchaseLine.VALIDATE(Description, 'Retención ' + rlLineasFacturaERecibida.DESCRIPCION);
                                    rlPurchaseLine.VALIDATE("Direct Unit Cost", -(rlLineasFacturaERecibida.PRECIO) *
                                                                   (rlTasasyRetencionesFacturaE.RETENCION / 100));
                                    //             rlPurchaseLine.VALIDATE(Amount,-(rlLineasFacturaERecibida.CANTIDAD * rlLineasFacturaERecibida.PRECIO) *
                                    //                                           (rlTasasyRetencionesFacturaE.RETENCION / 100));
                                    //***ZAM0004; AOC; 13/02/18; Unir E-factura con necesidades
                                    /*
                                    IF vlCodigoContratacion <> '' THEN BEGIN
                                      rlPurchaseLine."No. Linea contratacion" := vlLineaContratacion;
                                      rlPurchaseLine.VALIDATE("Shortcut Dimension 1 Code",rlLineasContratacion."Shortcut Dimension 1 Code");
                                      rlPurchaseLine.VALIDATE("Shortcut Dimension 2 Code",rlLineasContratacion."Shortcut Dimension 2 Code");
                                      rlPurchaseLine.VALIDATE("Cod. contratacion",vlCodigoContratacion);
                                    END;
                                    */
                                    /*
                                    rlPurchaseLine.VALIDATE("Purchase Need No.",rlLineasFacturaERecibida."Purchase Need No.");
                                    rlPurchaseLine.VALIDATE("Purchase Need Line No.",rlLineasFacturaERecibida."Purchase Need Line No.");
                                    //meter las dimensiones
                                    IF TPurchaseNeedLineL.GET(rlLineasFacturaERecibida."Purchase Need No.",rlLineasFacturaERecibida."Purchase Need Line No.") THEN BEGIN
                                      rlPurchaseLine.VALIDATE("Shortcut Dimension 1 Code",TPurchaseNeedLineL."Shortcut Dimension 1 Code");
                                      rlPurchaseLine.VALIDATE("Shortcut Dimension 2 Code",TPurchaseNeedLineL."Shortcut Dimension 2 Code");
                                      rlPurchaseLine."Dimension Set ID":= TPurchaseNeedLineL."Dimension Set ID";
                                    END;
                                    */
                                    //***ZAM0004; AOC; 13/02/18; fin
                                    rlPurchaseLine.VALIDATE("Shortcut Dimension 1 Code", rlLineasFacturaERecibida."Shortcut Dimension 1 Code");
                                    rlPurchaseLine.VALIDATE("Shortcut Dimension 2 Code", rlLineasFacturaERecibida."Shortcut Dimension 2 Code");

                                    //I00124 Mod. S2G (MGL) 07-11-14: No validar líneas sin cantidad, precio e importe.
                                END;
                                //I00124 Mod. S2G (MGL) 07-11-14: Fin.
                                PfCrearModificar(rlLineasFacturaERecibida, rlPurchaseHeader, rlPurchaseLine, vlLinea);
                            UNTIL rlTasasyRetencionesFacturaERet.NEXT = 0;
                END
                ELSE
                    IF rlTasasyRetencionesFacturaE.FINDSET THEN
                        REPEAT
                            rlTasasyRetencionesFacturaE.TESTFIELD("Código IVA NAV");
                            rlPurchaseLine.VALIDATE("VAT Prod. Posting Group", rlTasasyRetencionesFacturaE."Código IVA NAV");
                            PfCrearModificar(rlLineasFacturaERecibida, rlPurchaseHeader, rlPurchaseLine, vlLinea);
                            CLEAR(rlTasasyRetencionesFacturaERet);
                            rlTasasyRetencionesFacturaERet.SETRANGE("ID Factura", rlLineasFacturaERecibida."ID Factura");
                            rlTasasyRetencionesFacturaERet.SETRANGE(Linea, rlLineasFacturaERecibida.Linea);
                            rlTasasyRetencionesFacturaERet.SETFILTER(RETENCION, '<>%1', 0);
                            IF (rlTasasyRetencionesFacturaERet.COUNT <= 1) THEN BEGIN
                                IF (rlTasasyRetencionesFacturaERet.COUNT = 1) THEN
                                    rlLineasFacturaERecibida.TESTFIELD("Código IRPF NAV");
                                IF rlLineasFacturaERecibida."Código IRPF NAV" <> '' THEN BEGIN
                                    rlPurchaseLine.VALIDATE("No.", rlLineasFacturaERecibida."Cuenta NAV");
                                    rlPurchaseLine.VALIDATE(Description, 'Retención ' + rlLineasFacturaERecibida.DESCRIPCION);
                                    //I00124 Mod. S2G (MGL) 07-11-14: No validar líneas sin cantidad, precio e importe.
                                    IF (rlLineasFacturaERecibida.PRECIO <> 0) THEN
                                        //I00124 Mod. S2G (MGL) 07-11-14: Fin.
                                        rlPurchaseLine.VALIDATE("Direct Unit Cost", -(rlLineasFacturaERecibida.PRECIO) *
                                                         (rlLineasFacturaERecibida.Retenciones / 100));
                                    //               rlPurchaseLine.VALIDATE(Amount,-(rlLineasFacturaERecibida.CANTIDAD * rlLineasFacturaERecibida.PRECIO) *
                                    //                                              (rlLineasFacturaERecibida.Retenciones / 100));
                                    //               rlPurchaseLine.VALIDATE("Codigo retencion IRPF",rlLineasFacturaERecibida."Código IRPF NAV");
                                    //***ZAM0004; AOC; 13/02/18; Unir E-factura con necesidades
                                    /*
                                    IF vlCodigoContratacion <> '' THEN BEGIN
                                       rlPurchaseLine."No. Linea contratacion" := vlLineaContratacion;
                                       rlPurchaseLine.VALIDATE("Shortcut Dimension 1 Code",rlLineasContratacion."Shortcut Dimension 1 Code");
                                       rlPurchaseLine.VALIDATE("Shortcut Dimension 2 Code",rlLineasContratacion."Shortcut Dimension 2 Code");
                                       rlPurchaseLine.VALIDATE("Cod. contratacion",vlCodigoContratacion);
                                    END;
                                    */
                                    /*
                                    rlPurchaseLine.VALIDATE("Purchase Need No.",rlLineasFacturaERecibida."Purchase Need No.");
                                    rlPurchaseLine.VALIDATE("Purchase Need Line No.",rlLineasFacturaERecibida."Purchase Need Line No.");
                                    //meter las dimensiones
                                    IF TPurchaseNeedLineL.GET(rlLineasFacturaERecibida."Purchase Need No.",rlLineasFacturaERecibida."Purchase Need Line No.") THEN BEGIN
                                      rlPurchaseLine.VALIDATE("Shortcut Dimension 1 Code",TPurchaseNeedLineL."Shortcut Dimension 1 Code");
                                      rlPurchaseLine.VALIDATE("Shortcut Dimension 2 Code",TPurchaseNeedLineL."Shortcut Dimension 2 Code");
                                      rlPurchaseLine."Dimension Set ID":= TPurchaseNeedLineL."Dimension Set ID";
                                    END;
                                    */
                                    //***ZAM0004; AOC; 13/02/18; fin
                                    rlPurchaseLine.VALIDATE("Shortcut Dimension 1 Code", rlLineasFacturaERecibida."Shortcut Dimension 1 Code");
                                    rlPurchaseLine.VALIDATE("Shortcut Dimension 2 Code", rlLineasFacturaERecibida."Shortcut Dimension 2 Code");
                                    PfCrearModificar(rlLineasFacturaERecibida, rlPurchaseHeader, rlPurchaseLine, vlLinea);
                                END;
                            END
                            ELSE
                                IF rlTasasyRetencionesFacturaERet.FINDSET THEN
                                    REPEAT
                                        rlTasasyRetencionesFacturaERet.TESTFIELD("Código IRPF NAV");
                                        rlPurchaseLine.VALIDATE("No.", rlLineasFacturaERecibida."Cuenta NAV");
                                        rlPurchaseLine.VALIDATE(Description, 'Retención ' + rlLineasFacturaERecibida.DESCRIPCION);
                                        //I00124 Mod. S2G (MGL) 07-11-14: No validar líneas sin cantidad, precio e importe.
                                        IF (rlLineasFacturaERecibida.PRECIO <> 0) THEN
                                            //I00124 Mod. S2G (MGL) 07-11-14: Fin.
                                            rlPurchaseLine.VALIDATE("Direct Unit Cost", -(rlLineasFacturaERecibida.PRECIO) *
                                                         (rlTasasyRetencionesFacturaERet.RETENCION / 100));
                                        //               rlPurchaseLine.VALIDATE(Amount,-(rlLineasFacturaERecibida.CANTIDAD * rlLineasFacturaERecibida.PRECIO) *
                                        //                                              (rlTasasyRetencionesFacturaERet.RETENCION / 100));
                                        //               rlPurchaseLine.VALIDATE("Codigo retencion IRPF",rlTasasyRetencionesFacturaERet."Código IRPF NAV");

                                        //***ZAM0004; AOC; 13/02/18; Unir E-factura con necesidades
                                        /*
                                        IF vlCodigoContratacion <> '' THEN BEGIN
                                           rlPurchaseLine."No. Linea contratacion" := vlLineaContratacion;
                                           rlPurchaseLine.VALIDATE("Shortcut Dimension 1 Code",rlLineasContratacion."Shortcut Dimension 1 Code");
                                           rlPurchaseLine.VALIDATE("Shortcut Dimension 2 Code",rlLineasContratacion."Shortcut Dimension 2 Code");
                                           rlPurchaseLine.VALIDATE("Cod. contratacion",vlCodigoContratacion);
                                        END;
                                        */
                                        /*
                                        rlPurchaseLine.VALIDATE("Purchase Need No.",rlLineasFacturaERecibida."Purchase Need No.");
                                        rlPurchaseLine.VALIDATE("Purchase Need Line No.",rlLineasFacturaERecibida."Purchase Need Line No.");
                                        //meter las dimensiones
                                        IF TPurchaseNeedLineL.GET(rlLineasFacturaERecibida."Purchase Need No.",rlLineasFacturaERecibida."Purchase Need Line No.") THEN BEGIN
                                          rlPurchaseLine.VALIDATE("Shortcut Dimension 1 Code",TPurchaseNeedLineL."Shortcut Dimension 1 Code");
                                          rlPurchaseLine.VALIDATE("Shortcut Dimension 2 Code",TPurchaseNeedLineL."Shortcut Dimension 2 Code");
                                          rlPurchaseLine."Dimension Set ID":= TPurchaseNeedLineL."Dimension Set ID";
                                        END;
                                        */
                                        //***ZAM0004; AOC; 13/02/18; fin
                                        rlPurchaseLine.VALIDATE("Shortcut Dimension 1 Code", rlLineasFacturaERecibida."Shortcut Dimension 1 Code");
                                        rlPurchaseLine.VALIDATE("Shortcut Dimension 2 Code", rlLineasFacturaERecibida."Shortcut Dimension 2 Code");

                                        PfCrearModificar(rlLineasFacturaERecibida, rlPurchaseHeader, rlPurchaseLine, vlLinea);
                                    UNTIL rlTasasyRetencionesFacturaERet.NEXT = 0;
                        UNTIL rlTasasyRetencionesFacturaE.NEXT = 0;
                vlLimpiar := TRUE;
            UNTIL rlLineasFacturaERecibida.NEXT = 0;

        rlPurchaseLine.DELETE;

        CLEAR(rlPurchCommentLine);
        rlPurchCommentLine.INIT;
        rlPurchCommentLine."Document Type" := rlPurchaseHeader."Document Type";
        rlPurchCommentLine."No." := rlPurchaseHeader."No.";
        rlPurchCommentLine."Document Line No." := 0;
        rlPurchCommentLine."Line No." := 10000;
        rlPurchCommentLine.Date := TODAY;
        rlPurchCommentLine.Comment := COPYSTR(pFactura.NOTAS, 1, MAXSTRLEN(rlPurchCommentLine.Comment));
        rlPurchCommentLine.INSERT;
        IF STRLEN(pFactura.NOTAS) > 80 THEN BEGIN
            CLEAR(rlPurchCommentLine);
            rlPurchCommentLine.INIT;
            rlPurchCommentLine."Document Type" := rlPurchaseHeader."Document Type";
            rlPurchCommentLine."No." := rlPurchaseHeader."No.";
            rlPurchCommentLine."Document Line No." := 0;
            rlPurchCommentLine."Line No." := 20000;
            rlPurchCommentLine.Date := TODAY;
            rlPurchCommentLine.Comment := COPYSTR(pFactura.NOTAS, 81, 20);
            rlPurchCommentLine.INSERT;
        END;

        IF pRegistrar THEN BEGIN
            CODEUNIT.RUN(CODEUNIT::"Purch.-Post (Yes/No)", rlPurchaseHeader);
            Registrada := TRUE;
            Rec.MODIFY;
        END
        ELSE BEGIN
            MESSAGE(vText50000, rlPurchaseHeader."No.");
        END;

        CurrPage.UPDATE;

    end;

    [Scope('Internal')]
    procedure fEditables()
    begin
        ID_PLATAFORMAEditable := FALSE;
        NUMEditable := FALSE;
        SERIEEditable := FALSE;
        FECHA_ENTRADAEditable := FALSE;
        FECHA_DEVENGOEditable := FALSE;
        EMISOR_CIFEditable := FALSE;
        EMISOR_NOMBREEditable := FALSE;
        EMISOR_DIRECCIONEditable := FALSE;
        EMISOR_CIUDADEditable := FALSE;
        EMISOR_PROVINCIAEditable := FALSE;
        EMISOR_CPEditable := FALSE;
        EMISOR_TELEFONOEditable := FALSE;
        EMISOR_EMAILEditable := FALSE;
        RECEPTOR_CIFEditable := FALSE;
        FORMA_PAGOEditable := FALSE;
        FECHA_PAGOEditable := FALSE;
        CCC_PAGOEditable := FALSE;
        NOTASEditable := FALSE;
        CONTACTO_NOMBREEditable := FALSE;
        CONTACTO_TELEFONOEditable := FALSE;
        CONTACTO_EMAILEditable := FALSE;
        TOTAL_BASESEditable := FALSE;
        TOTAL_TASASEditable := FALSE;
        TOTAL_PAGAREditable := FALSE;
        "DOCUMENTACIÓN ADJUNTAEditable" := FALSE;
        "DOCUMENTO PDFEditable" := FALSE;
        "DOCUMENTO FACTURAEditable" := FALSE;

        VNuevo := "Approval Status" = 0;
        VPteAprobar := ("Approval Status" = "Approval Status"::"Approval Pending") OR ("Approval Status" = 0);

        CurrPage.EDITABLE(("Documento en Curso" = '') AND ("Documento Registrado" = ''));
        //aoc
        //CurrPage.Lineas.EDITABLE(("Documento en Curso" = '') AND ("Documento Registrado" = ''));
    end;

    [Scope('Internal')]
    procedure PfCrearModificar(pLineasFacturaERecibida: Record 50008; pPurchaseHeader: Record "Purchase Header"; var pPurchaseLine: Record "Purchase Line"; var pLinea: Integer)
    begin
        pPurchaseLine.MODIFY(TRUE);

        pLinea += 10000;

        PfPasarDescripciones(pLineasFacturaERecibida, pLinea, pPurchaseLine);

        pPurchaseLine.INIT;
        pPurchaseLine."Document Type" := pPurchaseHeader."Document Type";
        pPurchaseLine."Document No." := pPurchaseHeader."No.";
        pPurchaseLine."Line No." := pLinea;
        pPurchaseLine.INSERT(TRUE);

        pPurchaseLine."Buy-from Vendor No." := pPurchaseHeader."Buy-from Vendor No.";
        //I00109 Mod. S2G (JSM) 22-10-14: Permitir creación de líneas de activo fijo en Factura Elec.
        IF (pLineasFacturaERecibida."Cod Activo" <> '') THEN BEGIN
            pPurchaseLine.VALIDATE(Type, pPurchaseLine.Type::"Fixed Asset");
            pPurchaseLine.VALIDATE("No.", pLineasFacturaERecibida."Cod Activo");
        END ELSE BEGIN
            //I00109 Mod. S2G (JSM) 22-10-14: Fin.
            //I00124 Mod. S2G (MGL) 07-11-14: No validar líneas sin cantidad, precio e importe.
            IF (pLineasFacturaERecibida.CANTIDAD <> 0) AND (pLineasFacturaERecibida.PRECIO <> 0) THEN BEGIN
                //I00124 Mod. S2G (MGL) 07-11-14: Fin.
                pPurchaseLine.VALIDATE(Type, pPurchaseLine.Type::"G/L Account");
                pPurchaseLine.VALIDATE("No.", pLineasFacturaERecibida."Cuenta NAV");
                //I00124 Mod. S2G (MGL) 07-11-14: No validar líneas sin cantidad, precio e importe.
            END;
            //I00124 Mod. S2G (MGL) 07-11-14: Fin.
        END;
        pPurchaseLine.VALIDATE(Description, COPYSTR(pLineasFacturaERecibida.DESCRIPCION, 1, 50));
        pPurchaseLine.VALIDATE("Description 2", COPYSTR(pLineasFacturaERecibida.DESCRIPCION, 51, 50));
        //I00124 Mod. S2G (MGL) 07-11-14: No validar líneas sin cantidad, precio e importe.
        IF (pLineasFacturaERecibida.CANTIDAD <> 0) AND (pLineasFacturaERecibida.PRECIO <> 0) THEN BEGIN
            //I00124 Mod. S2G (MGL) 07-11-14: Fin.
            IF pPurchaseHeader."Document Type" = pPurchaseHeader."Document Type"::Invoice THEN
                pPurchaseLine.VALIDATE(Quantity, pLineasFacturaERecibida.CANTIDAD)
            ELSE
                pPurchaseLine.VALIDATE(Quantity, -pLineasFacturaERecibida.CANTIDAD);
            pPurchaseLine.VALIDATE("Direct Unit Cost", pLineasFacturaERecibida.PRECIO);
            pPurchaseLine.VALIDATE(Amount, (pLineasFacturaERecibida.CANTIDAD * pLineasFacturaERecibida.PRECIO) *
                                           (1 + (pLineasFacturaERecibida.Tasas / 100)));
            //I00124 Mod. S2G (MGL) 07-11-14: No validar líneas sin cantidad, precio e importe.
        END;
        IF (pLineasFacturaERecibida.DESCUENTO <> 0) THEN
            //I00124 Mod. S2G (MGL) 07-11-14: Fin.
            //I00235 Mod. S2G (EGR) 06-10-15: Pasar el descuento con IVA.
            //pPurchaseLine.VALIDATE("Line Discount Amount",pLineasFacturaERecibida.DESCUENTO);
            pPurchaseLine.VALIDATE("Line Discount Amount", (pLineasFacturaERecibida.DESCUENTO) *
                                             (1 + (pLineasFacturaERecibida.Tasas / 100)));
        //I00235 Mod. S2G (EGR) 06-10-15: Pasar el descuento con IVA. FIN

        pPurchaseLine.VALIDATE("ID Plataforma FacturaE", pPurchaseHeader."ID Plataforma FacturaE");
        pPurchaseLine.VALIDATE("Numero FacturaE", pPurchaseHeader."Numero FacturaE");
        pPurchaseLine.VALIDATE("Linea FacturaE", pLineasFacturaERecibida.Linea);
    end;

    [Scope('Internal')]
    procedure PfRechazarFacturaE(pCabeceraFacturaERecibida: Record 50007)
    var
        // TODO SaaS: Automation/COM no es compatible con Business Central SaaS; sustituir por APIs AL nativas de XML/HTTP manteniendo el comportamiento original.
        locautXmlHttp: Automation;
        // TODO SaaS: Automation/COM no es compatible con Business Central SaaS; sustituir por APIs AL nativas de XML/HTTP manteniendo el comportamiento original.
        locautXmlDoc: Automation;
        vlRequestText: Text[1024];
        rlGeneralLedgerSetup: Record "General Ledger Setup";
        // TODO SaaS: File con rutas locales/servidor no es compatible con Business Central SaaS; sustituir por Temp Blob/streams manteniendo el flujo original.
        vlFichero: File;
        vlTextSOAPBegin: Label '<?xml version="1.0" encoding="utf-8"?> <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/">';
        vlTextSOAPEnd: Label '</soapenv:Body> </soapenv:Envelope>';
        vlTextSOAPBegin2: Label '<soapenv:Header /><soapenv:Body>';
        vlBigText: BigText;
        vlInStream: InStream;
        "vlContraseña": Text[1024];
        // TODO SaaS: Automation/COM no es compatible con Business Central SaaS; sustituir por APIs AL nativas de XML/HTTP manteniendo el comportamiento original.
        vlXMLDomNode: Automation;
        rlPurchasesPayablesSetup: Record "Purchases & Payables Setup";
        XMLtxt: Text;
    begin
        //Rechaza la factura en FacturaE
        /*
        //Comprobación datos necesarios.
        CLEAR(rlGeneralLedgerSetup);
        rlGeneralLedgerSetup.GET;
        rlGeneralLedgerSetup.CALCFIELDS("Contraseña Synergy");
        rlGeneralLedgerSetup.TESTFIELD("URL Servicio Solicitudes");
        rlGeneralLedgerSetup.TESTFIELD("Usuario Synergy");
        IF NOT rlGeneralLedgerSetup."Contraseña Synergy".HASVALUE THEN
           ERROR(Text50000);
        //Mod. S2G (JMG) 11-06-13: Añade máscara para contraseña.INICIO
        CLEAR(vlBigText);
        rlGeneralLedgerSetup.CALCFIELDS("Contraseña Synergy");
        IF rlGeneralLedgerSetup."Contraseña Synergy".HASVALUE THEN BEGIN
          rlGeneralLedgerSetup."Contraseña Synergy".CREATEINSTREAM(vlInStream);
          vlBigText.READ(vlInStream);
          vlBigText.GETSUBTEXT(vlContraseña,1,1024);
        END;
        //Mod. S2G (JMG) 11-06-13: Añade máscara para contraseña.FIN
        */

        CLEAR(rlPurchasesPayablesSetup);
        rlPurchasesPayablesSetup.GET;
        rlPurchasesPayablesSetup.TESTFIELD("URL Servicio Rechazo Facturae");

        //Creación del mensaje SOAP.
        CLEAR(locautXmlDoc);
        CREATE(locautXmlDoc, FALSE, TRUE);
        CLEAR(locautXmlHttp);
        CREATE(locautXmlHttp, FALSE, TRUE);

        XMLtxt := vlTextSOAPBegin + vlTextSOAPBegin2 +
                           '<setDocumentStatus>' +
                             '<arg0>' +
                             pCabeceraFacturaERecibida.ID_PLATAFORMA +
                             '</arg0>' +
                             '<arg1>' +
                             'REJECTED' +
                             '</arg1>' +
                             '<arg2>' +
                             pCabeceraFacturaERecibida."Motivo rechazo" +
                             '</arg2>' +
                           '</setDocumentStatus>' +
                             vlTextSOAPEnd;

        //MESSAGE(XMLtxt);

        // locautXmlDoc.loadXML(vlTextSOAPBegin + vlTextSOAPBegin2 +
        //                   '<setDocumentStatus>' +
        //                     '<arg0>' +
        //                     pCabeceraFacturaERecibida.ID_PLATAFORMA +
        //                     '</arg0>' +
        //                     '<arg1>' +
        //                     'REJECTED' +
        //                     '</arg1>' +
        //                     '<arg2>' +
        //                     pCabeceraFacturaERecibida."Motivo rechazo" +
        //                     '</arg2>' +
        //                   '</setDocumentStatus>' +
        //                     vlTextSOAPEnd);

        //locautXmlDoc.loadXML(XMLtxt);
        locautXmlDoc.load(XMLtxt);


        //locautXmlDoc.load('\\tsclient\C\Compartida\CambioEstado.xml');
        //locautXmlDoc.save('\\tsclient\C\Compartida\MensajeCambioEstado.xml');

        //Creación cabecera mensaje SOAP.
        locautXmlHttp.Open('POST', rlPurchasesPayablesSetup."URL Servicio Rechazo Facturae");
        //locautXmlHttp.SetCredentials(rlGeneralLedgerSetup."Usuario Synergy",vlContraseña,0);
        locautXmlHttp.SetRequestHeader('Content-Type', 'text/xml; charset=utf-8');
        locautXmlHttp.SetRequestHeader('SOAPAction', 'setDocumentStatus');

        //MESSAGE(FORMAT(locautXmlDoc.text));
        //MESSAGE(locautXmlDoc.xml);
        //MESSAGE(FORMAT(locautXmlDoc.xml));


        locautXmlHttp.Send(locautXmlDoc);

        //Guarda datos
        CLEAR(locautXmlDoc);
        CREATE(locautXmlDoc, FALSE, TRUE);
        locautXmlDoc.async := FALSE;
        locautXmlDoc.load(locautXmlHttp.ResponseStream);
        //locautXmlDoc.save('\\tsclient\C\Users\DTUser\Documents\RespuestaCambioEstado.xml');
        //locautXmlDoc.save('\\tsclient\C\Compartida\RespuestaCambioEstado.xml');


        vlXMLDomNode := locautXmlDoc.documentElement.selectSingleNode
                            ('/soap:Envelope/soap:Body/ns2:setDocumentStatusResponse/return/errorMsg');
        IF NOT ISCLEAR(vlXMLDomNode) THEN
            ERROR(vlXMLDomNode.text);
        /*
        vlXMLDomNode := locautXmlDoc.documentElement.selectSingleNode
                               ('/s:Envelope/s:Body/CreateResponse');
        IF NOT ISCLEAR(vlXMLDomNode) THEN BEGIN
           vlXMLDomNode := locautXmlDoc.documentElement.selectSingleNode
                               ('//ErrorMsg');
           MESSAGE(vlXMLDomNode.text);
        END
        ELSE BEGIN
           ERROR(locautXmlDoc.documentElement.selectSingleNode
                 ('/s:Envelope/s:Body/s:Fault').text);
        END;
        */

    end;

    [Scope('Internal')]
    procedure PfVerFacturaE(pCabeceraFacturaERecibida: Record 50007)
    var
        // TODO SaaS: Automation/COM no es compatible con Business Central SaaS; sustituir por APIs AL nativas de XML/HTTP manteniendo el comportamiento original.
        locautXmlHttp: Automation;
        // TODO SaaS: Automation/COM no es compatible con Business Central SaaS; sustituir por APIs AL nativas de XML/HTTP manteniendo el comportamiento original.
        locautXmlDoc: Automation;
        vlRequestText: Text[1024];
        rlGeneralLedgerSetup: Record "General Ledger Setup";
        // TODO SaaS: File con rutas locales/servidor no es compatible con Business Central SaaS; sustituir por Temp Blob/streams manteniendo el flujo original.
        vlFichero: File;
        vlTextSOAPBegin: Label '<?xml version="1.0" encoding="utf-8"?> <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/">';
        vlTextSOAPEnd: Label '</soapenv:Body> </soapenv:Envelope>';
        vlTextSOAPBegin2: Label '<soapenv:Header /><soapenv:Body>';
        vlBigText: BigText;
        vlInStream: InStream;
        "vlContraseña": Text[1024];
        // TODO SaaS: Automation/COM no es compatible con Business Central SaaS; sustituir por APIs AL nativas de XML/HTTP manteniendo el comportamiento original.
        vlXMLDomNode: Automation;
    begin
        //Rechaza la factura en FacturaE
        /*
        //Comprobación datos necesarios.
        CLEAR(rlGeneralLedgerSetup);
        rlGeneralLedgerSetup.GET;
        rlGeneralLedgerSetup.CALCFIELDS("Contraseña Synergy");
        rlGeneralLedgerSetup.TESTFIELD("URL Servicio Solicitudes");
        rlGeneralLedgerSetup.TESTFIELD("Usuario Synergy");
        IF NOT rlGeneralLedgerSetup."Contraseña Synergy".HASVALUE THEN
           ERROR(Text50000);
        //Mod. S2G (JMG) 11-06-13: Añade máscara para contraseña.INICIO
        CLEAR(vlBigText);
        rlGeneralLedgerSetup.CALCFIELDS("Contraseña Synergy");
        IF rlGeneralLedgerSetup."Contraseña Synergy".HASVALUE THEN BEGIN
          rlGeneralLedgerSetup."Contraseña Synergy".CREATEINSTREAM(vlInStream);
          vlBigText.READ(vlInStream);
          vlBigText.GETSUBTEXT(vlContraseña,1,1024);
        END;
        //Mod. S2G (JMG) 11-06-13: Añade máscara para contraseña.FIN
        */

        //Creación del mensaje SOAP.
        CLEAR(locautXmlDoc);
        CREATE(locautXmlDoc, FALSE, TRUE);
        CLEAR(locautXmlHttp);
        CREATE(locautXmlHttp, FALSE, TRUE);
        locautXmlDoc.loadXML(vlTextSOAPBegin + vlTextSOAPBegin2 +
                           '<visualizeDocument>' +
                             '<arg0>' +
                             pCabeceraFacturaERecibida.ID_PLATAFORMA +
                             '</arg0>' +
                           '</visualizeDocument>' +
                             vlTextSOAPEnd);

        //locautXmlDoc.load('\\tsclient\C\Compartida\CambioEstado.xml');
        //locautXmlDoc.save('\\tsclient\C\Compartida\MensajeCambioEstado.xml');

        //Creación cabecera mensaje SOAP.
        locautXmlHttp.Open('POST', 'http://pre.bilbokoudala.lan/aif/ws/DocumentFormattingServices');
        //locautXmlHttp.SetCredentials(rlGeneralLedgerSetup."Usuario Synergy",vlContraseña,0);
        locautXmlHttp.SetRequestHeader('Content-Type', 'text/xml; charset=utf-8');
        locautXmlHttp.SetRequestHeader('SOAPAction', 'getDocument');
        locautXmlHttp.Send(locautXmlDoc);

        //Guarda datos
        CLEAR(locautXmlDoc);
        CREATE(locautXmlDoc, FALSE, TRUE);
        locautXmlDoc.async := FALSE;
        locautXmlDoc.load(locautXmlHttp.ResponseStream);
        //locautXmlDoc.save('\\tsclient\C\Users\DTUser\Documents\RespuestaCambioEstado.xml');
        locautXmlDoc.save('\\tsclient\C\Compartida\RespuestaVisualizeDocument.xml');


        vlXMLDomNode := locautXmlDoc.documentElement.selectSingleNode
                            ('/soap:Envelope/soap:Body/ns2:setDocumentStatusResponse/return/errorMsg');
        IF NOT ISCLEAR(vlXMLDomNode) THEN
            ERROR(vlXMLDomNode.text);
        /*
        vlXMLDomNode := locautXmlDoc.documentElement.selectSingleNode
                               ('/s:Envelope/s:Body/CreateResponse');
        IF NOT ISCLEAR(vlXMLDomNode) THEN BEGIN
           vlXMLDomNode := locautXmlDoc.documentElement.selectSingleNode
                               ('//ErrorMsg');
           MESSAGE(vlXMLDomNode.text);
        END
        ELSE BEGIN
           ERROR(locautXmlDoc.documentElement.selectSingleNode
                 ('/s:Envelope/s:Body/s:Fault').text);
        END;
        */

    end;

    [Scope('Internal')]
    procedure PfSiguienteEstadoFacturaE(pCabeceraFacturaERecibida: Record 50007)
    var
        // TODO SaaS: Automation/COM no es compatible con Business Central SaaS; sustituir por APIs AL nativas de XML/HTTP manteniendo el comportamiento original.
        locautXmlHttp: Automation;
        // TODO SaaS: Automation/COM no es compatible con Business Central SaaS; sustituir por APIs AL nativas de XML/HTTP manteniendo el comportamiento original.
        locautXmlDoc: Automation;
        vlRequestText: Text[1024];
        rlGeneralLedgerSetup: Record "General Ledger Setup";
        // TODO SaaS: File con rutas locales/servidor no es compatible con Business Central SaaS; sustituir por Temp Blob/streams manteniendo el flujo original.
        vlFichero: File;
        vlTextSOAPBegin: Label '<?xml version="1.0" encoding="utf-8"?> <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/">';
        vlTextSOAPEnd: Label '</soapenv:Body> </soapenv:Envelope>';
        vlTextSOAPBegin2: Label '<soapenv:Header /><soapenv:Body>';
        vlBigText: BigText;
        vlInStream: InStream;
        "vlContraseña": Text[1024];
        // TODO SaaS: Automation/COM no es compatible con Business Central SaaS; sustituir por APIs AL nativas de XML/HTTP manteniendo el comportamiento original.
        vlXMLDomNode: Automation;
    begin
        //Rechaza la factura en FacturaE
        /*
        //Comprobación datos necesarios.
        CLEAR(rlGeneralLedgerSetup);
        rlGeneralLedgerSetup.GET;
        rlGeneralLedgerSetup.CALCFIELDS("Contraseña Synergy");
        rlGeneralLedgerSetup.TESTFIELD("URL Servicio Solicitudes");
        rlGeneralLedgerSetup.TESTFIELD("Usuario Synergy");
        IF NOT rlGeneralLedgerSetup."Contraseña Synergy".HASVALUE THEN
           ERROR(Text50000);
        //Mod. S2G (JMG) 11-06-13: Añade máscara para contraseña.INICIO
        CLEAR(vlBigText);
        rlGeneralLedgerSetup.CALCFIELDS("Contraseña Synergy");
        IF rlGeneralLedgerSetup."Contraseña Synergy".HASVALUE THEN BEGIN
          rlGeneralLedgerSetup."Contraseña Synergy".CREATEINSTREAM(vlInStream);
          vlBigText.READ(vlInStream);
          vlBigText.GETSUBTEXT(vlContraseña,1,1024);
        END;
        //Mod. S2G (JMG) 11-06-13: Añade máscara para contraseña.FIN
        */

        //Creación del mensaje SOAP.
        CLEAR(locautXmlDoc);
        CREATE(locautXmlDoc, FALSE, TRUE);
        CLEAR(locautXmlHttp);
        CREATE(locautXmlHttp, FALSE, TRUE);
        locautXmlDoc.loadXML(vlTextSOAPBegin + vlTextSOAPBegin2 +
                           '<getNextAllowedStatusList>' +
                             '<arg0>' +
                             pCabeceraFacturaERecibida.ID_PLATAFORMA +
                             '</arg0>' +
                           '</getNextAllowedStatusList>' +
                             vlTextSOAPEnd);

        //locautXmlDoc.load('\\tsclient\C\Compartida\CambioEstado.xml');
        //locautXmlDoc.save('\\tsclient\C\Compartida\MensajeCambioEstado.xml');

        //Creación cabecera mensaje SOAP.
        locautXmlHttp.Open('POST', 'http://pre.bilbokoudala.lan/aif/ws/DocumentAdministrationServices');
        //locautXmlHttp.SetCredentials(rlGeneralLedgerSetup."Usuario Synergy",vlContraseña,0);
        locautXmlHttp.SetRequestHeader('Content-Type', 'text/xml; charset=utf-8');
        locautXmlHttp.SetRequestHeader('SOAPAction', 'getNextAllowedStatusList');
        locautXmlHttp.Send(locautXmlDoc);

        //Guarda datos
        CLEAR(locautXmlDoc);
        CREATE(locautXmlDoc, FALSE, TRUE);
        locautXmlDoc.async := FALSE;
        locautXmlDoc.load(locautXmlHttp.ResponseStream);
        //locautXmlDoc.save('\\tsclient\C\Users\DTUser\Documents\RespuestaCambioEstado.xml');
        locautXmlDoc.save('\\tsclient\C\Compartida\RespuestaSiguienteEstado.xml');


        vlXMLDomNode := locautXmlDoc.documentElement.selectSingleNode
                            ('/soap:Envelope/soap:Body/ns2:setDocumentStatusResponse/return/errorMsg');
        IF NOT ISCLEAR(vlXMLDomNode) THEN
            ERROR(vlXMLDomNode.text);
        /*
        vlXMLDomNode := locautXmlDoc.documentElement.selectSingleNode
                               ('/s:Envelope/s:Body/CreateResponse');
        IF NOT ISCLEAR(vlXMLDomNode) THEN BEGIN
           vlXMLDomNode := locautXmlDoc.documentElement.selectSingleNode
                               ('//ErrorMsg');
           MESSAGE(vlXMLDomNode.text);
        END
        ELSE BEGIN
           ERROR(locautXmlDoc.documentElement.selectSingleNode
                 ('/s:Envelope/s:Body/s:Fault').text);
        END;
        */

    end;

    [Scope('Internal')]
    procedure PfVolverARecibidaFacturaE(pCabeceraFacturaERecibida: Record 50007)
    var
        // TODO SaaS: Automation/COM no es compatible con Business Central SaaS; sustituir por APIs AL nativas de XML/HTTP manteniendo el comportamiento original.
        locautXmlHttp: Automation;
        // TODO SaaS: Automation/COM no es compatible con Business Central SaaS; sustituir por APIs AL nativas de XML/HTTP manteniendo el comportamiento original.
        locautXmlDoc: Automation;
        vlRequestText: Text[1024];
        rlGeneralLedgerSetup: Record "General Ledger Setup";
        // TODO SaaS: File con rutas locales/servidor no es compatible con Business Central SaaS; sustituir por Temp Blob/streams manteniendo el flujo original.
        vlFichero: File;
        vlTextSOAPBegin: Label '<?xml version="1.0" encoding="utf-8"?> <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/">';
        vlTextSOAPEnd: Label '</soapenv:Body> </soapenv:Envelope>';
        vlTextSOAPBegin2: Label '<soapenv:Header /><soapenv:Body>';
        vlBigText: BigText;
        vlInStream: InStream;
        "vlContraseña": Text[1024];
        // TODO SaaS: Automation/COM no es compatible con Business Central SaaS; sustituir por APIs AL nativas de XML/HTTP manteniendo el comportamiento original.
        vlXMLDomNode: Automation;
        rlPurchasesPayablesSetup: Record "Purchases & Payables Setup";
    begin
        //Rechaza la factura en FacturaE
        /*
        //Comprobación datos necesarios.
        CLEAR(rlGeneralLedgerSetup);
        rlGeneralLedgerSetup.GET;
        rlGeneralLedgerSetup.CALCFIELDS("Contraseña Synergy");
        rlGeneralLedgerSetup.TESTFIELD("URL Servicio Solicitudes");
        rlGeneralLedgerSetup.TESTFIELD("Usuario Synergy");
        IF NOT rlGeneralLedgerSetup."Contraseña Synergy".HASVALUE THEN
           ERROR(Text50000);
        //Mod. S2G (JMG) 11-06-13: Añade máscara para contraseña.INICIO
        CLEAR(vlBigText);
        rlGeneralLedgerSetup.CALCFIELDS("Contraseña Synergy");
        IF rlGeneralLedgerSetup."Contraseña Synergy".HASVALUE THEN BEGIN
          rlGeneralLedgerSetup."Contraseña Synergy".CREATEINSTREAM(vlInStream);
          vlBigText.READ(vlInStream);
          vlBigText.GETSUBTEXT(vlContraseña,1,1024);
        END;
        //Mod. S2G (JMG) 11-06-13: Añade máscara para contraseña.FIN
        */

        CLEAR(rlPurchasesPayablesSetup);
        rlPurchasesPayablesSetup.GET;
        rlPurchasesPayablesSetup.TESTFIELD("URL Servicio Rechazo Facturae");

        //Creación del mensaje SOAP.
        CLEAR(locautXmlDoc);
        CREATE(locautXmlDoc, FALSE, TRUE);
        CLEAR(locautXmlHttp);
        CREATE(locautXmlHttp, FALSE, TRUE);
        locautXmlDoc.loadXML(vlTextSOAPBegin + vlTextSOAPBegin2 +
                           '<setDocumentStatus>' +
                             '<arg0>' +
                             pCabeceraFacturaERecibida.ID_PLATAFORMA +
                             '</arg0>' +
                             '<arg1>' +
                             'RECEIVED' +
                             '</arg1>' +
                             '<arg2>' +
                             'Prueba Volver a estado recibido' +
                             '</arg2>' +
                           '</setDocumentStatus>' +
                             vlTextSOAPEnd);

        //locautXmlDoc.load('\\tsclient\C\Compartida\CambioEstado.xml');
        //locautXmlDoc.save('\\tsclient\C\Compartida\MensajeCambioEstado.xml');

        //Creación cabecera mensaje SOAP.
        locautXmlHttp.Open('POST', rlPurchasesPayablesSetup."URL Servicio Rechazo Facturae");
        //locautXmlHttp.SetCredentials(rlGeneralLedgerSetup."Usuario Synergy",vlContraseña,0);
        locautXmlHttp.SetRequestHeader('Content-Type', 'text/xml; charset=utf-8');
        locautXmlHttp.SetRequestHeader('SOAPAction', 'setDocumentStatus');
        locautXmlHttp.Send(locautXmlDoc);
        /*
        //Guarda datos
        CLEAR(locautXmlDoc);
        CREATE(locautXmlDoc);
        locautXmlDoc.async:=FALSE;
        locautXmlDoc.load(locautXmlHttp.ResponseStream);
        //locautXmlDoc.save('\\tsclient\C\Users\DTUser\Documents\RespuestaCambioEstado.xml');
        locautXmlDoc.save('\\tsclient\C\Compartida\RespuestaCambioEstadoRecibida.xml');
        
        
        vlXMLDomNode := locautXmlDoc.documentElement.selectSingleNode
                            ('/soap:Envelope/soap:Body/ns2:setDocumentStatusResponse/return/errorMsg');
        IF NOT ISCLEAR(vlXMLDomNode) THEN
           ERROR(vlXMLDomNode.text);
        */
        /*
        vlXMLDomNode := locautXmlDoc.documentElement.selectSingleNode
                               ('/s:Envelope/s:Body/CreateResponse');
        IF NOT ISCLEAR(vlXMLDomNode) THEN BEGIN
           vlXMLDomNode := locautXmlDoc.documentElement.selectSingleNode
                               ('//ErrorMsg');
           MESSAGE(vlXMLDomNode.text);
        END
        ELSE BEGIN
           ERROR(locautXmlDoc.documentElement.selectSingleNode
                 ('/s:Envelope/s:Body/s:Fault').text);
        END;
        */

    end;

    [Scope('Internal')]
    procedure PfPasarDescripciones(pLineasFacturaERecibida: Record 50008; var pLinea: Integer; pPurchaseLine: Record "Purchase Line")
    var
        vlRuta: Text[1024];
        rlBDRespaldoFacturaRecibida: Record 50010;
    begin
        CLEAR(rlBDRespaldoFacturaRecibida);
        IF rlBDRespaldoFacturaRecibida.GET(pLineasFacturaERecibida."ID Factura") THEN BEGIN
            // TODO SaaS: TEMPORARYPATH usaba una ruta temporal local/servidor en NAV; sustituir por Temp Blob/streams conservando la generación y lectura funcional del XML.
            vlRuta := TEMPORARYPATH + 'XMLFactura' + pLineasFacturaERecibida."ID Factura" + '.xml';
            rlBDRespaldoFacturaRecibida.CALCFIELDS("Datos XML Original");
            rlBDRespaldoFacturaRecibida."Datos XML Original".EXPORT(vlRuta);
            PfLeerXMLDescripcion(vlRuta, 'CONCEPTO', 'DESCRIPCION', pLineasFacturaERecibida, pLinea, pPurchaseLine);
        END;
    end;

    [Scope('Internal')]
    procedure PfLeerXMLDescripcion(pDirectorio: Text[250]; pRaiz: Text[250]; pElemento: Text[250]; pLineasFacturaERecibida: Record 50008; var pLinea: Integer; pPurchaseLine: Record "Purchase Line")
    var
        // TODO SaaS: Automation/COM no es compatible con Business Central SaaS; sustituir por APIs AL nativas de XML/HTTP manteniendo el comportamiento original.
        XMLNodeList: Automation;
        // TODO SaaS: Automation/COM no es compatible con Business Central SaaS; sustituir por APIs AL nativas de XML/HTTP manteniendo el comportamiento original.
        XMLDocument: Automation;
        strInStream: InStream;
        // TODO SaaS: File con rutas locales/servidor no es compatible con Business Central SaaS; sustituir por Temp Blob/streams manteniendo el flujo original.
        File: File;
        i: Integer;
    begin

        IF ISCLEAR(XMLDocument) THEN
            CREATE(XMLDocument, FALSE, TRUE);
        XMLDocument.load(pDirectorio); //se carga el fichero
        IF XMLDocument.hasChildNodes THEN
            XMLNodeList := XMLDocument.getElementsByTagName(pRaiz);//'ns3:Facturae');
        /*
        IF USERID = 'uciadmin' THEN
           fRecorrerXMLJMG('',XMLNodeList,pElemento,pLineasFacturaERecibida,pLinea,FALSE,pPurchaseLine)
        ELSE
        */
        PfRecorrerXMLDescripcion('', XMLNodeList, pElemento, pLineasFacturaERecibida, pLinea, FALSE, pPurchaseLine);
        XMLDocument.save(pDirectorio);

    end;

    [Scope('Internal')]
    // TODO SaaS: Automation/COM no es compatible con Business Central SaaS; sustituir por APIs AL nativas de XML/HTTP manteniendo el comportamiento original.
    procedure PfRecorrerXMLDescripcion(pElemento: Text[250]; pXMLNodeList: Automation; pElementomodificar: Text[30]; pLineasFacturaERecibida: Record 50008; var pLinea: Integer; pModificar: Boolean; pPurchaseLine: Record "Purchase Line")
    var
        // TODO SaaS: Automation/COM no es compatible con Business Central SaaS; sustituir por APIs AL nativas de XML/HTTP manteniendo el comportamiento original.
        XMLNodeList: Automation;
        // TODO SaaS: Automation/COM no es compatible con Business Central SaaS; sustituir por APIs AL nativas de XML/HTTP manteniendo el comportamiento original.
        XMLNode: Automation;
        i: Integer;
        j: Integer;
        k: Integer;
        // TODO SaaS: Automation/COM no es compatible con Business Central SaaS; sustituir por APIs AL nativas de XML/HTTP manteniendo el comportamiento original.
        XMLNodeList2: Automation;
        // TODO SaaS: Automation/COM no es compatible con Business Central SaaS; sustituir por APIs AL nativas de XML/HTTP manteniendo el comportamiento original.
        XMLNode2: Automation;
        vlBigText: BigText;
        // TODO SaaS: Automation/COM no es compatible con Business Central SaaS; sustituir por APIs AL nativas de XML/HTTP manteniendo el comportamiento original.
        XMLNodeText: Automation;
        rlPurchaseLine: Record "Purchase Line";
        vlLongitud: Integer;
        vlDescripcion: Text[1024];
        vlTexto: Text[1024];
    begin
        //Recorrer Nodos XML
        vPasado := FALSE;
        XMLNodeList := pXMLNodeList;
        FOR i := 0 TO XMLNodeList.length() - 1 DO BEGIN
            XMLNode := XMLNodeList.item(i);
            IF pModificar OR (pLineasFacturaERecibida.Linea - 1 = i) THEN BEGIN
                IF XMLNode.hasChildNodes THEN BEGIN
                    XMLNodeList2 := XMLNode.childNodes;
                    IF XMLNode.nodeName = pElementomodificar THEN BEGIN
                        XMLNode2 := XMLNode.parentNode;
                        XMLNodeText := XMLNode.childNodes.item(0);
                        j := 0;
                        WHILE j < XMLNodeText.length DO BEGIN
                            vlLongitud := 1024;
                            k := 1;

                            WHILE vlLongitud > 0 DO BEGIN

                                vlTexto := PfCortarLineas(XMLNodeText.substringData(j, 1024), k, MAXSTRLEN(rlPurchaseLine.Description));
                                IF vlLongitud <= MAXSTRLEN(rlPurchaseLine.Description) THEN
                                    vlLongitud := 0
                                ELSE
                                    vlLongitud -= MAXSTRLEN(rlPurchaseLine.Description);
                                IF vlTexto <> '' THEN BEGIN
                                    IF vPasado = FALSE THEN BEGIN
                                        pPurchaseLine.Description := vlTexto;
                                        pPurchaseLine.MODIFY(TRUE);
                                        vPasado := TRUE;
                                    END ELSE BEGIN
                                        rlPurchaseLine.INIT;
                                        rlPurchaseLine."Document Type" := pPurchaseLine."Document Type";
                                        rlPurchaseLine."Document No." := pPurchaseLine."Document No.";
                                        rlPurchaseLine."Line No." := pLinea;
                                        rlPurchaseLine.Description := vlTexto;
                                        rlPurchaseLine."Attached to Line No." := pPurchaseLine."Line No.";
                                        rlPurchaseLine.INSERT(TRUE);
                                        pLinea += 10000;
                                    END;
                                END;
                            END;
                            j += k;
                        END;

                        /*
                                    j := 50;
                                    WHILE j < XMLNodeText.length DO BEGIN
                                       rlPurchaseLine.INIT;
                                       rlPurchaseLine."Document Type" := pPurchaseLine."Document Type";
                                       rlPurchaseLine."Document No." := pPurchaseLine."Document No.";
                                       rlPurchaseLine."Line No." := pLinea;
                                       rlPurchaseLine.Description := XMLNodeText.substringData(j,50);
                                       rlPurchaseLine.INSERT(TRUE);
                                       pLinea += 10000;
                                       j += 50;
                                    END;
                        */
                        EXIT;
                    END
                    ELSE
                        PfRecorrerXMLDescripcion(XMLNode.nodeName, XMLNodeList2, pElementomodificar,
                                                pLineasFacturaERecibida, pLinea, TRUE, pPurchaseLine);
                END
                ELSE BEGIN
                    IF XMLNode.nodeName = pElementomodificar THEN BEGIN
                        XMLNode2 := XMLNode.parentNode;
                        XMLNodeText := XMLNode.childNodes.item(0);
                        j := 0;
                        WHILE j < XMLNodeText.length DO BEGIN
                            vlLongitud := 1024;
                            k := 1;

                            WHILE vlLongitud > 0 DO BEGIN

                                vlTexto := PfCortarLineas(XMLNodeText.substringData(j, 1024), k, MAXSTRLEN(rlPurchaseLine.Description));
                                IF vlLongitud <= MAXSTRLEN(rlPurchaseLine.Description) THEN
                                    vlLongitud := 0
                                ELSE
                                    vlLongitud -= MAXSTRLEN(rlPurchaseLine.Description);
                                IF vlTexto <> '' THEN BEGIN
                                    IF vPasado = FALSE THEN BEGIN
                                        pPurchaseLine.Description := vlTexto;
                                        pPurchaseLine.MODIFY(TRUE);
                                        vPasado := TRUE;
                                    END ELSE BEGIN
                                        rlPurchaseLine.INIT;
                                        rlPurchaseLine."Document Type" := pPurchaseLine."Document Type";
                                        rlPurchaseLine."Document No." := pPurchaseLine."Document No.";
                                        rlPurchaseLine."Line No." := pLinea;
                                        rlPurchaseLine.Description := vlTexto;
                                        rlPurchaseLine."Attached to Line No." := pPurchaseLine."Line No.";
                                        rlPurchaseLine.INSERT(TRUE);
                                        pLinea += 10000;
                                    END;
                                END;
                            END;
                            j += k;
                        END;

                        /*
                        j := 50;
                        WHILE j < XMLNodeText.length DO BEGIN
                           rlPurchaseLine.INIT;
                           rlPurchaseLine."Document Type" := pPurchaseLine."Document Type";
                           rlPurchaseLine."Document No." := pPurchaseLine."Document No.";
                           rlPurchaseLine."Line No." := pLinea;
                           rlPurchaseLine.Description := XMLNodeText.substringData(j + 1,50);
                           rlPurchaseLine.INSERT;
                           pLinea += 10000;
                           j += 50;
                        END;
                        */
                        EXIT;
                    END;
                END;
            END;
        END;

    end;

    [Scope('Internal')]
    procedure PfCortarLineas(pTextoOrigen: Text[1024]; var pPosicion: Integer; "pTamañoMaximo": Integer): Text[1024]
    var
        vlTextoRetorno: Text[1024];
        vlTextoNoCortar: Text[1024];
        vlTextoPosicion: Text[1024];
        vlPosicionBlanco: Integer;
        vlPosicionTotal: Integer;
        vlInicio: Boolean;
        vlLongitud: Integer;
    begin
        IF COPYSTR(pTextoOrigen, pPosicion + pTamañoMaximo, 1) = ' ' THEN
            vlTextoRetorno := COPYSTR(pTextoOrigen, pPosicion, pTamañoMaximo)
        ELSE BEGIN
            vlTextoNoCortar := COPYSTR(pTextoOrigen, pPosicion, pTamañoMaximo);
            vlTextoPosicion := vlTextoNoCortar;
            vlPosicionBlanco := 0;
            vlPosicionTotal := 0;
            vlInicio := TRUE;
            WHILE (vlPosicionBlanco <> 0) OR (vlInicio = TRUE) DO BEGIN
                vlPosicionBlanco := STRPOS(vlTextoPosicion, ' ');
                vlPosicionTotal += vlPosicionBlanco;
                vlTextoPosicion := COPYSTR(vlTextoPosicion, vlPosicionBlanco + 1, pTamañoMaximo);
                vlInicio := FALSE;
            END;
            IF (vlPosicionBlanco = 0) AND (vlInicio = TRUE) THEN
                vlTextoRetorno := COPYSTR(pTextoOrigen, pPosicion, pTamañoMaximo)
            ELSE
                IF vlPosicionTotal <> 0 THEN
                    IF STRLEN(vlTextoNoCortar) < pTamañoMaximo THEN
                        vlTextoRetorno := COPYSTR(pTextoOrigen, pPosicion, pTamañoMaximo)
                    ELSE
                        vlTextoRetorno := COPYSTR(pTextoOrigen, pPosicion, vlPosicionTotal)
                ELSE
                    vlTextoRetorno := COPYSTR(pTextoOrigen, pPosicion, pTamañoMaximo);
        END;

        pPosicion += STRLEN(vlTextoRetorno);

        EXIT(vlTextoRetorno);
    end;

    local procedure ProveedorNAVOnAfterValidate()
    begin
        CurrPage.UPDATE;
    end;

    local procedure CIFProveedorOnFormat()
    begin
        Rec.CALCFIELDS("CIF Proveedor");
        IF "CIF Proveedor" <> EMISOR_CIF THEN BEGIN
            "CIF ProveedorEmphasize" := TRUE;
        END
        ELSE BEGIN
            "CIF ProveedorEmphasize" := FALSE;
        END;
    end;

    local procedure TesteoImportes()
    var
        TotalIVAIncl: Decimal;
        LinFacturaE: Record 50008;
        TotalSinIVA: Decimal;
        tLotes: Record 50011;
    begin
        //>Z004      CIMUBISA-08 JLF 2018.03.23 Gestión de FacturaE
        TotalIVAIncl := 0;
        TotalSinIVA := 0;
        CLEAR(LinFacturaE);
        LinFacturaE.SETRANGE(LinFacturaE."ID Factura", ID_PLATAFORMA);
        IF LinFacturaE.FINDSET THEN
            REPEAT
                TotalIVAIncl += LinFacturaE."Amount Including VAT";
                TotalSinIVA += LinFacturaE.Importe;
            UNTIL LinFacturaE.NEXT = 0;
        IF TOTAL_PAGAR <> TotalIVAIncl THEN
            ERROR(vText50005, FIELDCAPTION(TOTAL_PAGAR), TOTAL_PAGAR, LinFacturaE.FIELDCAPTION("Amount Including VAT"), TotalIVAIncl);
        //<Z004      CIMUBISA-08 JLF 2018.03.23 Gestión de FacturaE

        //JLF
        IF EXPEDIENTE = '' THEN
            ERROR(vText50007, FIELDCAPTION(EXPEDIENTE));
        IF Lote = '' THEN
            ERROR(vText50007, FIELDCAPTION(Lote));
        IF Lote <> '' THEN BEGIN
            CLEAR(tLotes);
            tLotes.GET(EXPEDIENTE, Lote);
            tLotes.CALCFIELDS("Importe facturas registradas", "Importe abonos registrados");
            //Z035 INICIO JRB 28/04/2020 Si el Lote tiene marcado Prorroga contar con el importe del campo Importe Prorroga
            //IF TotalSinIVA>(tLotes."Importe lote"-tLotes."Importe facturas registradas"+tLotes."Importe abonos registrados") THEN
            //  ERROR(vText50006);
            IF tLotes.Prórroga THEN BEGIN
                IF TotalSinIVA > ((tLotes."Importe lote" + tLotes."Importe prorroga") - tLotes."Importe facturas registradas" + tLotes."Importe abonos registrados") THEN
                    ERROR(vText50006);
            END ELSE BEGIN
                IF TotalSinIVA > (tLotes."Importe lote" - tLotes."Importe facturas registradas" + tLotes."Importe abonos registrados") THEN
                    ERROR(vText50006);
            END;
            //Z035 FIN JRB 28/04/2020 Si el Lote tiene marcado Prorroga contar con el importe del campo Importe Prorroga
        END;
        //JLF
    end;
}

