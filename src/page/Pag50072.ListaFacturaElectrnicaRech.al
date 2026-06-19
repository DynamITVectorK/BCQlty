page 50072 "Lista Factura Electrónica Rech"
{
    // ZAM0040 IAG 130521

    Caption = 'Lista Facturacion Electrónica Rechazada';
    CardPageID = "Cabecera FacturaE";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    UsageCategory = Administration;
    SourceTable = 50007;
    SourceTableView = SORTING (Fecha Importación, Hora Importación)
                      ORDER(Descending)
                      WHERE (Rechazada = FILTER (Yes));

    layout
    {
        area(content)
        {
            repeater()
            {
                field(ID_PLATAFORMA; Rec.ID_PLATAFORMA)
                {
                    ApplicationArea = All;
                }
                field(NUM; Rec.NUM)
                {
                    ApplicationArea = All;
                }
                field(SERIE; Rec.SERIE)
                {
                    ApplicationArea = All;
                }
                field(FECHA_ENTRADA; Rec.FECHA_ENTRADA)
                {
                    ApplicationArea = All;
                }
                field("Approval Status"; Rec."Approval Status")
                {
                    ApplicationArea = All;
                }
                field(FECHA_DEVENGO; Rec.FECHA_DEVENGO)
                {
                    ApplicationArea = All;
                }
                field(EMISOR_CIF; Rec.EMISOR_CIF)
                {
                    ApplicationArea = All;
                }
                field(EMISOR_NOMBRE; Rec.EMISOR_NOMBRE)
                {
                    ApplicationArea = All;
                }
                field(EMISOR_DIRECCION; Rec.EMISOR_DIRECCION)
                {
                    ApplicationArea = All;
                }
                field(EMISOR_CIUDAD; Rec.EMISOR_CIUDAD)
                {
                    ApplicationArea = All;
                }
                field(EMISOR_PROVINCIA; Rec.EMISOR_PROVINCIA)
                {
                    ApplicationArea = All;
                }
                field(EMISOR_CP; Rec.EMISOR_CP)
                {
                    ApplicationArea = All;
                }
                field(EMISOR_TELEFONO; Rec.EMISOR_TELEFONO)
                {
                    ApplicationArea = All;
                }
                field(EMISOR_EMAIL; Rec.EMISOR_EMAIL)
                {
                    ApplicationArea = All;
                }
                field(RECEPTOR_CIF; Rec.RECEPTOR_CIF)
                {
                    ApplicationArea = All;
                }
                field(FORMA_PAGO; Rec.FORMA_PAGO)
                {
                    ApplicationArea = All;
                }
                field(FECHA_PAGO; Rec.FECHA_PAGO)
                {
                    ApplicationArea = All;
                }
                field(CCC_PAGO; Rec.CCC_PAGO)
                {
                    ApplicationArea = All;
                }
                field(NOTAS; Rec.NOTAS)
                {
                    ApplicationArea = All;
                }
                field(CONTACTO_NOMBRE; Rec.CONTACTO_NOMBRE)
                {
                    ApplicationArea = All;
                }
                field(CONTACTO_TELEFONO; Rec.CONTACTO_TELEFONO)
                {
                    ApplicationArea = All;
                }
                field(CONTACTO_EMAIL; Rec.CONTACTO_EMAIL)
                {
                    ApplicationArea = All;
                }
                field(TOTAL_BASES; Rec.TOTAL_BASES)
                {
                    ApplicationArea = All;
                }
                field(TOTAL_TASAS; Rec.TOTAL_TASAS)
                {
                    ApplicationArea = All;
                }
                field(TOTAL_PAGAR; Rec.TOTAL_PAGAR)
                {
                    ApplicationArea = All;
                }
                field("Documento Registrado"; Rec."Documento Registrado")
                {
                    ApplicationArea = All;
                }
                field("Abono Registrado"; Rec."Abono Registrado")
                {
                    ApplicationArea = All;
                }
                field("Documento en Curso"; Rec."Documento en Curso")
                {
                    ApplicationArea = All;
                }
                field("Fecha Importación"; Rec."Fecha Importación")
                {
                    ApplicationArea = All;
                }
                field("Hora Importación"; Rec."Hora Importación")
                {
                    ApplicationArea = All;
                }
                field(EXPEDIENTE; Rec.EXPEDIENTE)
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
            action("Importar FacturaE")
            {
                ApplicationArea = All;
                Caption = 'Importar FacturaE';
                Image = Import;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = XMLport 50001;
                Visible = false;
            }
        }
    }

    var
        vText50001: Label '¿Desea rechazar esta factura?';
        vText50002: Label 'Proceso cancelado por el usuario.';
        vText50004: Label '¿ Desea enviar un correo de rechazo ?';

    [Scope('Internal')]
    procedure fRechazarFacturaE(pCabeceraFacturaERecibida: Record 50007)
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
                             'REJECTED' +
                             '</arg1>' +
                             '<arg2>' +
                             pCabeceraFacturaERecibida."Motivo rechazo" +
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
}

