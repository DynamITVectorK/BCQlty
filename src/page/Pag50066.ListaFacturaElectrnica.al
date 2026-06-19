page 50066 "Lista Factura Electrónica"
{
    // I00263 Mod. S2G (APL) 03-05-16: Cambiar CCC Pago por IBAN Pago.
    // I00279 Mod. S2G (MGL) 08-11-16: Recodificar formularios para que entren en licencia
    // I00279 Mod. S2G (MGL) 26-12-16: Incluir formularios en licencia
    // 
    // Mod   Nr  Task        Dev Date       Comments
    // ====================================================================================================================================
    // Z004      CIMUBISA-08 IPP 2018.01.26 Gestión de FacturaE
    //   Added button
    //     Aprobar

    Caption = 'Lista Facturacion Electrónica';
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
                      WHERE (Documento Registrado=FILTER(''),
                            Rechazada=FILTER(No),
                            Abono Registrado=FILTER(''));

    layout
    {
        area(content)
        {
            repeater()
            {
                field(ID_PLATAFORMA;ID_PLATAFORMA)
                {
                    ApplicationArea = All;
                }
                field(NUM;NUM)
                {
                    ApplicationArea = All;
                }
                field(SERIE;SERIE)
                {
                    ApplicationArea = All;
                }
                field(FECHA_ENTRADA;FECHA_ENTRADA)
                {
                    ApplicationArea = All;
                }
                field("Approval Status";"Approval Status")
                {
                    ApplicationArea = All;
                }
                field(FECHA_DEVENGO;FECHA_DEVENGO)
                {
                    ApplicationArea = All;
                }
                field(EMISOR_CIF;EMISOR_CIF)
                {
                    ApplicationArea = All;
                }
                field(EMISOR_NOMBRE;EMISOR_NOMBRE)
                {
                    ApplicationArea = All;
                }
                field(EMISOR_DIRECCION;EMISOR_DIRECCION)
                {
                    ApplicationArea = All;
                }
                field(EMISOR_CIUDAD;EMISOR_CIUDAD)
                {
                    ApplicationArea = All;
                }
                field(EMISOR_PROVINCIA;EMISOR_PROVINCIA)
                {
                    ApplicationArea = All;
                }
                field(EMISOR_CP;EMISOR_CP)
                {
                    ApplicationArea = All;
                }
                field(EMISOR_TELEFONO;EMISOR_TELEFONO)
                {
                    ApplicationArea = All;
                }
                field(EMISOR_EMAIL;EMISOR_EMAIL)
                {
                    ApplicationArea = All;
                }
                field(RECEPTOR_CIF;RECEPTOR_CIF)
                {
                    ApplicationArea = All;
                }
                field(FORMA_PAGO;FORMA_PAGO)
                {
                    ApplicationArea = All;
                }
                field(FECHA_PAGO;FECHA_PAGO)
                {
                    ApplicationArea = All;
                }
                field(CCC_PAGO;CCC_PAGO)
                {
                    ApplicationArea = All;
                }
                field(NOTAS;NOTAS)
                {
                    ApplicationArea = All;
                }
                field(CONTACTO_NOMBRE;CONTACTO_NOMBRE)
                {
                    ApplicationArea = All;
                }
                field(CONTACTO_TELEFONO;CONTACTO_TELEFONO)
                {
                    ApplicationArea = All;
                }
                field(CONTACTO_EMAIL;CONTACTO_EMAIL)
                {
                    ApplicationArea = All;
                }
                field(TOTAL_BASES;TOTAL_BASES)
                {
                    ApplicationArea = All;
                }
                field(TOTAL_TASAS;TOTAL_TASAS)
                {
                    ApplicationArea = All;
                }
                field(TOTAL_PAGAR;TOTAL_PAGAR)
                {
                    ApplicationArea = All;
                }
                field("Documento Registrado";"Documento Registrado")
                {
                    ApplicationArea = All;
                }
                field("Abono Registrado";"Abono Registrado")
                {
                    ApplicationArea = All;
                }
                field("Documento en Curso";"Documento en Curso")
                {
                    ApplicationArea = All;
                }
                field("Fecha Importación";"Fecha Importación")
                {
                    ApplicationArea = All;
                }
                field("Hora Importación";"Hora Importación")
                {
                    ApplicationArea = All;
                }
                field(EXPEDIENTE;EXPEDIENTE)
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
        locautXmlHttp: Automation ;
        // TODO SaaS: Automation/COM no es compatible con Business Central SaaS; sustituir por APIs AL nativas de XML/HTTP manteniendo el comportamiento original.
        locautXmlDoc: Automation ;
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
        vlXMLDomNode: Automation ;
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
        CREATE(locautXmlDoc,FALSE,TRUE);
        CLEAR(locautXmlHttp);
        CREATE(locautXmlHttp,FALSE,TRUE);
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
        locautXmlHttp.Open('POST',rlPurchasesPayablesSetup."URL Servicio Rechazo Facturae");
        //locautXmlHttp.SetCredentials(rlGeneralLedgerSetup."Usuario Synergy",vlContraseña,0);
        locautXmlHttp.SetRequestHeader('Content-Type','text/xml; charset=utf-8');
        locautXmlHttp.SetRequestHeader('SOAPAction', 'setDocumentStatus');
        locautXmlHttp.Send(locautXmlDoc);
        
        //Guarda datos
        CLEAR(locautXmlDoc);
        CREATE(locautXmlDoc,FALSE,TRUE);
        locautXmlDoc.async:=FALSE;
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

