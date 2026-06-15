table 50007 "Cabecera FacturaE Recibida"
{
    // //Z035 - JLF - 19/07/19: Facturación electrónica

    DrillDownPageID = 50066;
    LookupPageID = 50066;
    Permissions = TableData 50102 = rimd;

    fields
    {
        field(1; ID_PLATAFORMA; Text[50])
        {
            Caption = 'ID_Plataforma';
            DataClassification = CustomerContent;
        }
        field(2; NUM; Text[20])
        {
            Caption = 'Número';
            DataClassification = CustomerContent;
        }
        field(3; SERIE; Text[20])
        {
            Caption = 'Serie';
            DataClassification = CustomerContent;
        }
        field(4; FECHA_ENTRADA; Date)
        {
            Caption = 'Fecha Entrada';
            DataClassification = CustomerContent;
        }
        field(5; FECHA_DEVENGO; Date)
        {
            Caption = 'Fecha Devengo';
            DataClassification = CustomerContent;
        }
        field(6; EMISOR_CIF; Text[20])
        {
            Caption = 'Cif Emisor';
            DataClassification = CustomerContent;
        }
        field(7; EMISOR_NOMBRE; Text[50])
        {
            Caption = 'Nombre Emisor';
            DataClassification = CustomerContent;
        }
        field(8; EMISOR_DIRECCION; Text[100])
        {
            Caption = 'Dirección Emisor';
            DataClassification = CustomerContent;
        }
        field(9; EMISOR_CIUDAD; Text[30])
        {
            Caption = 'Ciudad Emisor';
            DataClassification = CustomerContent;
        }
        field(10; EMISOR_PROVINCIA; Text[30])
        {
            Caption = 'Provincia Emisor';
            DataClassification = CustomerContent;
        }
        field(11; EMISOR_CP; Text[20])
        {
            Caption = 'Cód. Postal Emisor';
            DataClassification = CustomerContent;
        }
        field(12; EMISOR_TELEFONO; Text[20])
        {
            Caption = 'Teléfono Emisor';
            DataClassification = CustomerContent;
        }
        field(13; EMISOR_EMAIL; Text[80])
        {
            Caption = 'Email Emisor';
            DataClassification = CustomerContent;
        }
        field(14; RECEPTOR_CIF; Text[20])
        {
            Caption = 'Cif Receptor';
            DataClassification = CustomerContent;
        }
        field(22; FORMA_PAGO; Text[50])
        {
            Caption = 'Forma Pago';
            DataClassification = CustomerContent;
        }
        field(23; FECHA_PAGO; Date)
        {
            Caption = 'Fecha Pago';
            DataClassification = CustomerContent;
        }
        field(24; CCC_PAGO; Text[34])
        {
            Caption = 'IBAN Pago';
            Description = 'Mod. S2G (JMG) 06-03-14: Se cambia de 20 a 34 porque pasa de ser CCC a IBAN';
            DataClassification = CustomerContent;
        }
        field(25; NOTAS; Text[250])
        {
            Caption = 'Notas';
            Description = 'Mod. S2G (JMG) 06-03-14: Se cambia de 100 a 250';
            DataClassification = CustomerContent;
        }
        field(26; CONTACTO_NOMBRE; Text[50])
        {
            Caption = 'Nombre Contacto';
            DataClassification = CustomerContent;
        }
        field(27; CONTACTO_TELEFONO; Text[20])
        {
            Caption = 'Teléfono Contacto';
            DataClassification = CustomerContent;
        }
        field(28; CONTACTO_EMAIL; Text[80])
        {
            Caption = 'Email Contacto';
            DataClassification = CustomerContent;
        }
        field(29; TOTAL_BASES; Decimal)
        {
            Caption = 'Total Bases';
            DataClassification = CustomerContent;
        }
        field(30; TOTAL_TASAS; Decimal)
        {
            Caption = 'Total Tasas';
            DataClassification = CustomerContent;
        }
        field(31; TOTAL_PAGAR; Decimal)
        {
            Caption = 'Total Pagar';
            Description = 'º';
            DataClassification = CustomerContent;
        }
        field(32; Registrada; Boolean)
        {
            CalcFormula = Exist ("Purch. Inv. Header" WHERE (ID Plataforma FacturaE=FIELD(ID_PLATAFORMA),
                                                            Numero FacturaE=FIELD(NUM)));
            Editable = false;
            FieldClass = FlowField;
            DataClassification = CustomerContent;
        }
        field(33;"Proveedor NAV";Code[20])
        {

            DataClassification = CustomerContent;
            trigger OnLookup()
            begin
                //Mod. S2G (JMG) 11-09-14: Añade un filtro para los CIFs con prefijo de país.
                //Quitado el lookup de propiedades
                //Vendor.No. WHERE (VAT Registration No.=FIELD(EMISOR_CIF))
                Clear(rVendor);
                rVendor.SetFilter("VAT Registration No.",'%1|%2',EMISOR_CIF,
                                  rlLineasFacturaERecibida.fQuitarPaisCIF(EMISOR_CIF));
                Clear(fVendorList);
                fVendorList.SetTableView(rVendor);
                fVendorList.LookupMode(true);
                if fVendorList.RunModal = ACTION::LookupOK then begin
                   fVendorList.GetRecord(rVendor);
                   VALIDATE("Proveedor NAV",rVendor."No.");
                end;
                //Mod. S2G (JMG) 11-09-14: Fin.
            end;

            trigger OnValidate()
            begin
                //Mod. S2G (JMG) 11-09-14: Añade un filtro para los CIFs con prefijo de país.
                if "Proveedor NAV" <> '' then begin
                   Clear(rVendor);
                   rVendor.SetFilter("VAT Registration No.",'%1|%2',EMISOR_CIF,
                                     rlLineasFacturaERecibida.fQuitarPaisCIF(EMISOR_CIF));
                   rVendor.SetRange("No.","Proveedor NAV");
                   if not rVendor.FindFirst then
                      Error(Text50000);
                end;
                //Mod. S2G (JMG) 11-09-14: Fin.
            end;
        }
        field(34;"DOCUMENTACIÓN ADJUNTA";Text[200])
        {
            Caption = 'Documentación adjunta';
            DataClassification = CustomerContent;
        }
        field(35;"DOCUMENTO PDF";Text[200])
        {
            Caption = 'Documento PDF';
            DataClassification = CustomerContent;
        }
        field(36;"DOCUMENTO FACTURA";Text[200])
        {
            Caption = 'Documento Factura';
            DataClassification = CustomerContent;
        }
        field(37;"Documento Registrado";Code[20])
        {
            CalcFormula = Lookup("Purch. Inv. Header".No. WHERE (ID Plataforma FacturaE=FIELD(ID_PLATAFORMA),
                                                                 Numero FacturaE=FIELD(NUM)));
            Editable = false;
            FieldClass = FlowField;
            DataClassification = CustomerContent;
        }
        field(38;"Documento en Curso";Code[20])
        {
            CalcFormula = Lookup("Purchase Header".No. WHERE (Document Type=FILTER(Invoice|Credit Memo),
                                                              ID Plataforma FacturaE=FIELD(ID_PLATAFORMA),
                                                              Numero FacturaE=FIELD(NUM)));
            Editable = false;
            FieldClass = FlowField;
            DataClassification = CustomerContent;
        }
        field(39;"Nombre proveedor";Text[100])
        {
            CalcFormula = Lookup(Vendor.Name WHERE (No.=FIELD(Proveedor NAV)));
            Editable = false;
            FieldClass = FlowField;
            DataClassification = CustomerContent;
        }
        field(40;"Cif Proveedor";Text[30])
        {
            CalcFormula = Lookup(Vendor."VAT Registration No." WHERE (No.=FIELD(Proveedor NAV)));
            Editable = false;
            FieldClass = FlowField;
            DataClassification = CustomerContent;
        }
        field(41;Rechazada;Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(42;"Motivo rechazo";Code[10])
        {
            Description = 'Mod. S2G (FTD) 21-01-14: Facturación Electrónica';

            DataClassification = CustomerContent;
            trigger OnLookup()
            var
                rlMotivosrechazo: Record "Standard Text";
                rlExtendedTextLine: Record "Extended Text Line";
                plListadoRechazo: Page "Standard Text Codes";
            begin
                /*
                 Clear(rlApprovalSetup);
                 rlApprovalSetup.GET;
                 rlApprovalSetup.TestField("Prefijo Estandar Rechazo");
                */
                 Clear(plListadoRechazo);
                 Clear(rlMotivosrechazo);
                 //rlMotivosrechazo.SetFilter(Code ,'%1',rlApprovalSetup."Prefijo Estandar Rechazo" + '*');
                 rlMotivosrechazo.SetFilter(Code ,'%1',PrefijoEstandarRechazo + '*');
                 plListadoRechazo.SetTableView(rlMotivosrechazo);
                 plListadoRechazo.LookupMode(true);
                 if plListadoRechazo.RunModal = ACTION::LookupOK then begin
                  VALIDATE("Descripción Rechazo",'');
                  plListadoRechazo.GetRecord(rlMotivosrechazo);
                  VALIDATE("Motivo rechazo",rlMotivosrechazo.Code);
                  Clear(rlExtendedTextLine);
                  rlExtendedTextLine.SetRange("Table Name",rlExtendedTextLine."Table Name"::"Standard Text");
                  rlExtendedTextLine.SetRange("No.",rlMotivosrechazo.Code);
                  rlExtendedTextLine.SetRange("Language Code",'ESP');
                  rlExtendedTextLine.SetRange("Text No.",1);
                  if rlExtendedTextLine.FindSet then repeat
                     VALIDATE("Descripción Rechazo","Descripción Rechazo" + CopyStr(rlExtendedTextLine.Text,
                                                                              1,MAXStrLen("Descripción Rechazo")-StrLen("Descripción Rechazo")));
                  until rlExtendedTextLine.Next=0;
                  rlExtendedTextLine.SetRange("Table Name",rlExtendedTextLine."Table Name"::"Standard Text");
                  rlExtendedTextLine.SetRange("No.",rlMotivosrechazo.Code);
                  rlExtendedTextLine.SetRange("Language Code",'EUS');
                  rlExtendedTextLine.SetRange("Text No.",1);
                  if rlExtendedTextLine.FindSet then begin
                     VALIDATE("Descripción Rechazo","Descripción Rechazo" + CopyStr(' / ',
                                                                              1,MAXStrLen("Descripción Rechazo")-StrLen(' / ')));
                     repeat
                        VALIDATE("Descripción Rechazo","Descripción Rechazo" + CopyStr(rlExtendedTextLine.Text,
                                                                                 1,MAXStrLen("Descripción Rechazo")-StrLen("Descripción Rechazo")));
                     until rlExtendedTextLine.Next=0;
                  end;
                 end;
                 plListadoRechazo.LookupMode(false);

            end;

            trigger OnValidate()
            begin
                CALCFIELDS("Documento en Curso","Documento Registrado");
                TESTFIELD("Documento en Curso",'');
                TESTFIELD("Documento Registrado",'');
                TESTFIELD(Rechazada,false);
            end;
        }
        field(43;"Descripción Rechazo";Text[250])
        {
            Description = 'Mod. S2G (FTD) 21-01-14: Facturación Electrónica';
            DataClassification = CustomerContent;
        }
        field(44;"Fecha Importación";Date)
        {
            DataClassification = CustomerContent;
        }
        field(45;"Hora Importación";Time)
        {
            DataClassification = CustomerContent;
        }
        field(46;"Usuario Importación";Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(47;"Abono Registrado";Code[20])
        {
            CalcFormula = Lookup("Purch. Cr. Memo Hdr.".No. WHERE (ID Plataforma FacturaE=FIELD(ID_PLATAFORMA),
                                                                   Numero FacturaE=FIELD(NUM)));
            Description = 'Mod. S2G (JMG) 25-02-15: Añade el campo para los casos de abonos';
            Editable = false;
            FieldClass = FlowField;
            DataClassification = CustomerContent;
        }
        field(50000;"Approval Status"; Enum "Approval Status FacturaE")
        {
            Caption = 'Approval Status';
            Description = 'Z004';
            DataClassification = CustomerContent;
        }
        field(50001;EXPEDIENTE;Text[20])
        {
            Caption = 'Expediente';
            Description = 'Z035';

            DataClassification = CustomerContent;
            trigger OnLookup()
            var
                tLotes: Record "50011";
                ListaLotes: Page "50028";
            begin
                //Z035 - JLF - 05/07/19: Inicio
                Clear(tLotes);
                tLotes.FilterGroup(4);
                tLotes.SetRange(Adjudicatario,"Proveedor NAV");
                tLotes.SetRange("Estado Expediente",tLotes."Estado Expediente"::"Adj.Definitiva");
                tLotes.FilterGroup(0);
                Clear(ListaLotes);
                ListaLotes.SetTableView(tLotes);
                ListaLotes.LookupMode(true);
                if ListaLotes.RunModal=ACTION::LookupOK then begin
                  Clear(tLotes);
                  ListaLotes.GetRecord(tLotes);
                  VALIDATE(EXPEDIENTE,tLotes."No. Expediente");
                  VALIDATE(Lote,tLotes.Lote);
                end;
                //Z035 - JLF - 05/07/19: Fin
            end;

            trigger OnValidate()
            var
                LinFacturaE: Record "50008";
            begin
                Clear(LinFacturaE);
                LinFacturaE.SetRange("ID Factura",ID_PLATAFORMA);
                LinFacturaE.ModifyAll(EXPEDIENTE,EXPEDIENTE);

                //Z035 INICIO JRB 28/04/2020 Crear dimensiones en expedientes
                Clear(tExp);
                tExp.SetRange("No.",EXPEDIENTE);
                if tExp.FindSet then begin
                  VALIDATE("Shortcut Dimension 1 Code",tExp."Shortcut Dimension 1 Code");
                  VALIDATE("Shortcut Dimension 2 Code",tExp."Shortcut Dimension 2 Code");
                  VALIDATE("Dimension Set ID",tExp."Dimension Set ID");
                end;
                //Z035 FIN JRB 28/04/2020 Crear dimensiones en expedientes

                //Z035 - INICIO JRB 28/04/2020 LLevar Numero cuenta del expediente a las lineas
                Clear(tExp);
                tExp.SetRange("No.",EXPEDIENTE);
                if tExp.FindSet then begin
                  Clear(rlLineasFacturaERecibida);
                  rlLineasFacturaERecibida.SetRange("ID Factura",ID_PLATAFORMA);
                  if rlLineasFacturaERecibida.FindSet then begin
                     repeat
                       rlLineasFacturaERecibida.Validate("Cuenta NAV",tExp."Cuenta Contable");
                       rlLineasFacturaERecibida.Modify;
                     until rlLineasFacturaERecibida.Next=0;
                  end;
                end;

                //INICIO JRB Llevar cuenta contable del Lote
                Clear(tLote);
                tLote.SetRange("No. Expediente",EXPEDIENTE);
                tLote.SetRange(Lote,Lote);
                if tLote.FindSet then begin
                  Clear(rlLineasFacturaERecibida);
                  rlLineasFacturaERecibida.SetRange("ID Factura",ID_PLATAFORMA);
                  if rlLineasFacturaERecibida.FindSet then begin
                     repeat
                       rlLineasFacturaERecibida.Validate("Cuenta NAV",tLote."Cuenta Contable Imputacion");
                       rlLineasFacturaERecibida.Modify;
                     until rlLineasFacturaERecibida.Next=0;
                  end;
                end;
                //FIN JRB Llevar cuenta contable del lote

                //Z035 - FIN JRB 28/04/2020 LLevar Numero cuenta del expediente a las lineas
            end;
        }
        field(50002;Lote;Text[30])
        {
            Description = 'Z035';
            TableRelation = Lotes.Lote WHERE (No. Expediente=FIELD(EXPEDIENTE));

            DataClassification = CustomerContent;
            trigger OnValidate()
            var
                LinFacturaE: Record "50008";
                tLotes: Record "50011";
            begin
                if Lote<>'' then begin
                  Clear(tLotes);
                  tLotes.Get(EXPEDIENTE,Lote);
                  if tLotes."Importe lote"=0 then
                    Error(Text50018);
                end;
                Clear(LinFacturaE);
                LinFacturaE.SetRange("ID Factura",ID_PLATAFORMA);
                LinFacturaE.ModifyAll(Lote,Lote);
            end;
        }
        field(50057;"Shortcut Dimension 1 Code";Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            Description = 'Z035';
            TableRelation = "Dimension Value".Code WHERE (Global Dimension No.=CONST(1));

            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                //Z035 INICIO JRB 28/04/2020 Crear dimensiones en expedientes
                ValidateShortcutDimCode(1,"Shortcut Dimension 1 Code");
                //Z035 FIN JRB 28/04/2020 Crear dimensiones en expedientes
            end;
        }
        field(50058;"Shortcut Dimension 2 Code";Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            Description = 'Z035';
            TableRelation = "Dimension Value".Code WHERE (Global Dimension No.=CONST(2));

            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                //Z035 INICIO JRB 28/04/2020 Crear dimensiones en expedientes
                ValidateShortcutDimCode(2,"Shortcut Dimension 2 Code");
                //Z035 FIN JRB 28/04/2020 Crear dimensiones en expedientes
            end;
        }
        field(50059;"Dimension Set ID";Integer)
        {
            Caption = 'Dimension Set ID';
            Description = 'Z035';
            Editable = false;
            TableRelation = "Dimension Set Entry";

            DataClassification = CustomerContent;
            trigger OnLookup()
            begin
                //Z035 INICIO JRB 28/04/2020 Crear dimensiones en expedientes
                ShowDocDim;
                //Z035 FIN JRB 28/04/2020 Crear dimensiones en expedientes
            end;
        }
    }

    keys
    {
        key(Key1;ID_PLATAFORMA,NUM)
        {
            Clustered = true;
        }
        key(Key2;"Fecha Importación","Hora Importación")
        {
        }
        key(Key3;"Approval Status",Rechazada)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        Clear(rlLineasFacturaERecibida);
        rlLineasFacturaERecibida.SetRange("ID Factura",ID_PLATAFORMA);
        rlLineasFacturaERecibida.DeleteAll();
        Clear(rlTasasYRetencionesFacturaE);
        rlTasasYRetencionesFacturaE.SetRange("ID Factura",ID_PLATAFORMA);
        rlTasasYRetencionesFacturaE.DeleteAll();
    end;

    trigger OnInsert()
    begin
        "Fecha Importación" := Today();
        "Hora Importación" := DT2TIME(CurrentDateTime);
        "Usuario Importación" := CopyStr(UserId(), 1, MaxStrLen("Usuario Importación"));
    end;

    var
        rlLineasFacturaERecibida: Record "50008";
        rlTasasYRetencionesFacturaE: Record "50009";
        rVendor: Record Vendor;
        rPurchasesYPayablesSetup: Record "Purchases & Payables Setup";
        fVendorList: Page "Vendor List";
        DimMgt: Codeunit DimensionManagement;
        tExp: Record "50001";
        tLote: Record "50011";
        tLineas: Record "50008";
        Text50000: Label 'El proveedor debe coincidir con el CIF del emisor.';
        Text50018: Label 'Importe lote debe ser distinto de cero';
        vText50001: Label '¿Desea rechazar esta factura?';
        vText50002: Label 'Proceso cancelado por el usuario.';
        vText50003: Label 'Factura rechazada correctamente.';
        PrefijoEstandarRechazo: Label 'RECHAZO';
        Text051: Label 'You may have changed a dimension.\\Do you want to update the lines?';

    internal procedure fTraerBackup()
    begin
        fTraerDatosRespaldo();
    end;

    internal procedure fComprobarFacturaE(pPurchaseHeader: Record "Purchase Header")
    var
        rlPurchaseLine: Record "Purchase Line";
        rlCabeceraFacturaE: Record "50007";
        vlImporteFactura: Decimal;
        lText50000: Label 'El importe de la factura (%1) aplicando la tolerancia (%2) es distinto del total de la factura proveniente de Facturación electrónica (%3).';
        vlToleranciaMas: Decimal;
        vlToleranciaMenos: Decimal;
    begin
        if (pPurchaseHeader."ID Plataforma FacturaE" <> '') and (pPurchaseHeader."Numero FacturaE" <> '') then begin
            rlPurchaseLine.SetRange("Document Type", pPurchaseHeader."Document Type");
            rlPurchaseLine.SetRange("Document No.", pPurchaseHeader."No.");
            if rlPurchaseLine.FindSet() then
                repeat
                    vlImporteFactura += rlPurchaseLine."Line Amount";
                until rlPurchaseLine.Next() = 0;
            rlCabeceraFacturaE.Get(pPurchaseHeader."ID Plataforma FacturaE", pPurchaseHeader."Numero FacturaE");
            rPurchasesYPayablesSetup.Get();
            vlToleranciaMas := vlImporteFactura + rPurchasesYPayablesSetup."Importe tolerancia facturaE";
            vlToleranciaMenos := vlImporteFactura - rPurchasesYPayablesSetup."Importe tolerancia facturaE";
            if (rlCabeceraFacturaE.TOTAL_PAGAR > vlToleranciaMas) or (rlCabeceraFacturaE.TOTAL_PAGAR < vlToleranciaMenos) then
                Error(lText50000, vlImporteFactura, rPurchasesYPayablesSetup."Importe tolerancia facturaE", rlCabeceraFacturaE.TOTAL_PAGAR);
        end;
    end;

    internal procedure fTraerDatosRespaldo(): Boolean
    var
        CompanyInformation: Record "Company Information";
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
        Client: HttpClient;
        Response: HttpResponseMessage;
        ContentText: Text;
    begin
        CompanyInformation.Get();
        CompanyInformation.TestField("VAT Registration No.");
        PurchasesPayablesSetup.Get();
        PurchasesPayablesSetup.TestField("Servidor Respaldo");
        if not Client.Get(PurchasesPayablesSetup."Servidor Respaldo", Response) then
            exit(false);
        Response.Content().ReadAs(ContentText);
        exit(Response.IsSuccessStatusCode() and (ContentText <> ''));
    end;

    internal procedure fQuitarCodigoRuta(pRutaAlfresco: Text[1000]) Ruta: Text[1000]
    begin
        Ruta := pRutaAlfresco;
        while StrPos(Ruta, 'app:') <> 0 do
            Ruta := DelStr(Ruta, StrPos(Ruta, 'app:'), 4);
        while StrPos(Ruta, 'cm:') <> 0 do
            Ruta := DelStr(Ruta, StrPos(Ruta, 'cm:'), 3);
    end;

    internal procedure fCogerTicketAlfresco(): Text[1000]
    var
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
        RecordLink: Record "Record Link";
    begin
        PurchasesPayablesSetup.Get();
        exit(RecordLink.fGetTicketAlfresco(PurchasesPayablesSetup."Ruta WS Ticket Alfresco", PurchasesPayablesSetup."Usuario Alfresco", PurchasesPayablesSetup."Contraseña Alfresco"));
    end;

    internal procedure fCogerTicketAlfrescoAut(pServidor: Text; pUsuario: Text; pContrasena: Text): Text[1000]
    var
        Client: HttpClient; Response: HttpResponseMessage; Request: Text; ResponseText: Text;
    begin
        Request := '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"><soapenv:Body><startSession><username>' + pUsuario + '</username><password>' + pContrasena + '</password></startSession></soapenv:Body></soapenv:Envelope>';
        PostSoap(Client, pServidor, 'startSessionRequest', Request, Response, ResponseText);
        exit(ExtractXmlText(ResponseText, 'ticket'));
    end;

    internal procedure fAbrirDocumentoAlfresco(pFichero: Text[250])
    begin
        Hyperlink(fGetURLToOpen(pFichero));
    end;

    internal procedure fAbrirContenedorAlfresco(pFichero: Text[250])
    begin
        Hyperlink(fGetURLToNavigate(pFichero));
    end;

    internal procedure fQuitarCodigoRutaAdjuntos(pRutaAlfresco: Text[1000]; pDescargar: Boolean) Ruta: Text[1000]
    begin
        Ruta := fQuitarCodigoRuta(pRutaAlfresco);
        while StrPos(Ruta, 'cm_') <> 0 do
            Ruta := DelStr(Ruta, StrPos(Ruta, 'cm_'), 3);
        if not pDescargar then
            while StrPos(Ruta, '/company_home') <> 0 do
                Ruta := DelStr(Ruta, StrPos(Ruta, '/company_home'), StrLen('/company_home'));
    end;

    internal procedure fCopiarDocumentosAlfresco(pCabeceraFacturaERecibida: Record "50007"; var pPurchaseHeader: Record "Purchase Header")
    var
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
        RecordLink: Record "Record Link";
        RecordRef: RecordRef;
        Url: Text[250];
    begin
        PurchasesPayablesSetup.Get();
        PurchasesPayablesSetup.TestField("Ruta raíz Alfresco");
        Url := CopyStr(PurchasesPayablesSetup."Ruta raíz Alfresco" + 'download/direct?path=' + pCabeceraFacturaERecibida.fQuitarCodigoRuta(pCabeceraFacturaERecibida."DOCUMENTO PDF"), 1, MaxStrLen(Url));
        pPurchaseHeader.AddLink(Url);
        RecordRef.GetTable(pPurchaseHeader);
        RecordLink.SetRange("Record ID", RecordRef.RecordId);
        RecordLink.SetRange(URL1, Url);
        if RecordLink.FindSet() then repeat RecordLink."Tipo Adjunto" := RecordLink."Tipo Adjunto"::PDF; RecordLink.Modify(); until RecordLink.Next() = 0;
        Url := CopyStr(PurchasesPayablesSetup."Ruta raíz Alfresco" + 'download/direct?path=' + pCabeceraFacturaERecibida.fQuitarCodigoRuta(pCabeceraFacturaERecibida."DOCUMENTO FACTURA"), 1, MaxStrLen(Url));
        pPurchaseHeader.AddLink(Url);
        pPurchaseHeader.CopyLinks(pCabeceraFacturaERecibida);
    end;

    internal procedure fVerFacturaAlfrescoQueryCh(pCabeceraFacturaERecibida: Record "50007"; var pPurchaseHeader: Record "Purchase Header")
    begin
        fCopiarDocumentosAlfresco(pCabeceraFacturaERecibida, pPurchaseHeader);
    end;

    internal procedure fRecorrerXMLAdjuntos(pElemento: Text[250]; pXMLNodeList: XmlNodeList; var pPurchaseHeader: Record "Purchase Header"; pCabeceraFacturaERecibida: Record "50007")
    begin
    end;

    internal procedure fCargarDocumentoAdjunto(pNombre: Text[250]; pID: Text[250]; var pPurchaseHeader: Record "Purchase Header"; pCabeceraFacturaERecibida: Record "50007")
    begin
    end;

    internal procedure ApproveEInvoice()
    begin
    end;

    local procedure CheckPurchaseNeedInLines()
    begin
    end;

    internal procedure fSignDocument(pURLDocument: Text)
    begin
    end;

    internal procedure fGetURLToOpen(pFichero: Text): Text
    var PurchasesPayablesSetup: Record "Purchases & Payables Setup"; RecordLink: Record "Record Link";
    begin
        PurchasesPayablesSetup.Get();
        if StrPos(pFichero, 'app:') = 0 then
            exit(PurchasesPayablesSetup."Ruta raíz Alfresco" + 'download/direct?path=/company_home' + fQuitarCodigoRuta(pFichero) + '&ticket=' + RecordLink.fGetTicketAlfresco(PurchasesPayablesSetup."Ruta WS Ticket Alfresco", PurchasesPayablesSetup."Usuario Alfresco", PurchasesPayablesSetup."Contraseña Alfresco"));
        exit(PurchasesPayablesSetup."Ruta raíz Alfresco" + 'download/direct?path=' + fQuitarCodigoRuta(pFichero) + '&ticket=' + RecordLink.fGetTicketAlfresco(PurchasesPayablesSetup."Ruta WS Ticket Alfresco", PurchasesPayablesSetup."Usuario Alfresco", PurchasesPayablesSetup."Contraseña Alfresco"));
    end;

    internal procedure fGetURLToNavigate(pFichero: Text): Text
    var PurchasesPayablesSetup: Record "Purchases & Payables Setup";
    begin
        PurchasesPayablesSetup.Get();
        exit(PurchasesPayablesSetup."Ruta raíz Alfresco" + 'navigate/browse' + fQuitarCodigoRuta(pFichero));
    end;

    internal procedure fOpenSignedPDFDocument()
    begin
        fAbrirDocumentoAlfresco("DOCUMENTO PDF");
    end;

    internal procedure fGetSignedText(): Text
    begin
        exit('Signed: ');
    end;

    local procedure "************lo que estaba en la pagina"()
    begin
    end;

    internal procedure fRegistrar(pFactura: Record "50007"; pRegistrar: Boolean)
    var
        PurchaseHeader: Record "Purchase Header";
        PurchPostYesNo: Codeunit "Purch.-Post (Yes/No)";
    begin
        PurchaseHeader.Init();
        PurchaseHeader.Validate("Document Type", PurchaseHeader."Document Type"::Invoice);
        PurchaseHeader.Validate("Buy-from Vendor No.", pFactura."Proveedor NAV");
        PurchaseHeader."ID Plataforma FacturaE" := pFactura.ID_PLATAFORMA;
        PurchaseHeader."Numero FacturaE" := pFactura.NUM;
        PurchaseHeader.Insert(true);
        fCopiarDocumentosAlfresco(pFactura, PurchaseHeader);
        if pRegistrar then
            PurchPostYesNo.Run(PurchaseHeader);
        Message('Se ha generado la factura %1. Puede proceder a su revisión.', PurchaseHeader."No.");
    end;

    internal procedure fCrearModificar(pLineasFacturaERecibida: Record "50008"; pPurchaseHeader: Record "Purchase Header"; var pPurchaseLine: Record "Purchase Line"; var pLinea: Integer)
    begin
        pPurchaseLine.Modify(true);
        pLinea += 10000;
        pPurchaseLine.Init();
        pPurchaseLine.Validate("Document Type", pPurchaseHeader."Document Type");
        pPurchaseLine.Validate("Document No.", pPurchaseHeader."No.");
        pPurchaseLine.Validate("Line No.", pLinea);
        pPurchaseLine.Insert(true);
    end;

    internal procedure fRechazarFacturaEPaso1()
    begin
        CalcFields("Documento en Curso", "Documento Registrado");
        TestField("Documento en Curso", '');
        TestField("Documento Registrado", '');
        if not Confirm(vText50001) then
            Error(vText50002);
        Rechazada := true;
        Modify(true);
        fRechazarFacturaE(Rec);
        Message(vText50003);
    end;

    internal procedure fRechazarFacturaE(pCabeceraFacturaERecibida: Record "50007")
    var Body: Text; ResponseText: Text; Response: HttpResponseMessage; Client: HttpClient; Setup: Record "Purchases & Payables Setup";
    begin
        Setup.Get();
        Body := BuildStatusSoap(pCabeceraFacturaERecibida, 'REJECTED', pCabeceraFacturaERecibida."Descripción Rechazo");
        PostSoap(Client, Setup."Ruta WS Ticket Alfresco", 'setDocumentStatus', Body, Response, ResponseText);
        if not Response.IsSuccessStatusCode() then Error(ResponseText);
    end;

    internal procedure fVerFacturaE(pCabeceraFacturaERecibida: Record "50007")
    var Body: Text; ResponseText: Text; Response: HttpResponseMessage; Client: HttpClient; Setup: Record "Purchases & Payables Setup";
    begin
        Setup.Get();
        Body := '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"><soapenv:Body><visualizeDocument><documentId>' + pCabeceraFacturaERecibida.ID_PLATAFORMA + '</documentId></visualizeDocument></soapenv:Body></soapenv:Envelope>';
        PostSoap(Client, Setup."Ruta WS Ticket Alfresco", 'visualizeDocument', Body, Response, ResponseText);
        if ResponseText <> '' then Message(ResponseText);
    end;

    internal procedure fSiguienteEstadoFacturaE(pCabeceraFacturaERecibida: Record "50007")
    var Body: Text; ResponseText: Text; Response: HttpResponseMessage; Client: HttpClient; Setup: Record "Purchases & Payables Setup";
    begin
        Setup.Get();
        Body := '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"><soapenv:Body><getNextAllowedStatusList><documentId>' + pCabeceraFacturaERecibida.ID_PLATAFORMA + '</documentId></getNextAllowedStatusList></soapenv:Body></soapenv:Envelope>';
        PostSoap(Client, Setup."Ruta WS Ticket Alfresco", 'getNextAllowedStatusList', Body, Response, ResponseText);
        if ResponseText <> '' then Message(ResponseText);
    end;

    internal procedure fVolverARecibidaFacturaE(pCabeceraFacturaERecibida: Record "50007")
    var Body: Text; ResponseText: Text; Response: HttpResponseMessage; Client: HttpClient; Setup: Record "Purchases & Payables Setup";
    begin
        Setup.Get();
        Body := BuildStatusSoap(pCabeceraFacturaERecibida, 'RECEIVED', '');
        PostSoap(Client, Setup."Ruta WS Ticket Alfresco", 'setDocumentStatus', Body, Response, ResponseText);
        if not Response.IsSuccessStatusCode() then Error(ResponseText);
    end;

    internal procedure fPasarDescripciones(pLineasFacturaERecibida: Record "50008"; var pLinea: Integer; pPurchaseLine: Record "Purchase Line")
    begin
    end;

    internal procedure fLeerXMLDescripcion(pDirectorio: Text[250]; pRaiz: Text[250]; pElemento: Text[250]; pLineasFacturaERecibida: Record "50008"; var pLinea: Integer; pPurchaseLine: Record "Purchase Line")
    var XmlDoc: XmlDocument; Nodes: XmlNodeList;
    begin
        if XmlDocument.ReadFrom(pDirectorio, XmlDoc) then
            if XmlDoc.SelectNodes('//' + pElemento, Nodes) then
                fRecorrerXMLDescripcion(pElemento, Nodes, 'DESCRIPCION', pLineasFacturaERecibida, pLinea, true, pPurchaseLine);
    end;

    internal procedure fRecorrerXMLDescripcion(pElemento: Text[250]; pXMLNodeList: XmlNodeList; pElementomodificar: Text[30]; pLineasFacturaERecibida: Record "50008"; var pLinea: Integer; pModificar: Boolean; pPurchaseLine: Record "Purchase Line")
    begin
    end;

    internal procedure fCortarLineas(pTextoOrigen: Text[1024]; var pPosicion: Integer; "pTamañoMaximo": Integer): Text[1024]
    var
        vlTextoRetorno: Text[1024]; vlTextoNoCortar: Text[1024]; vlTextoPosicion: Text[1024]; vlPosicionBlanco: Integer; vlPosicionTotal: Integer; vlInicio: Boolean;
    begin
        if CopyStr(pTextoOrigen, pPosicion + "pTamañoMaximo", 1) = ' ' then
            vlTextoRetorno := CopyStr(pTextoOrigen, pPosicion, "pTamañoMaximo")
        else begin
            vlTextoNoCortar := CopyStr(pTextoOrigen, pPosicion, "pTamañoMaximo");
            vlTextoPosicion := vlTextoNoCortar;
            vlPosicionBlanco := 0;
            vlPosicionTotal := 0;
            vlInicio := true;
            while (vlPosicionBlanco <> 0) or (vlInicio = true) do begin
                vlPosicionBlanco := StrPos(vlTextoPosicion, ' ');
                vlPosicionTotal += vlPosicionBlanco;
                vlTextoPosicion := CopyStr(vlTextoPosicion, vlPosicionBlanco + 1, "pTamañoMaximo");
                vlInicio := false;
            end;
            if (vlPosicionBlanco = 0) and (vlInicio = true) then
                vlTextoRetorno := CopyStr(pTextoOrigen, pPosicion, "pTamañoMaximo")
            else
                if vlPosicionTotal <> 0 then
                    if StrLen(vlTextoNoCortar) < "pTamañoMaximo" then
                        vlTextoRetorno := CopyStr(pTextoOrigen, pPosicion, "pTamañoMaximo")
                    else
                        vlTextoRetorno := CopyStr(pTextoOrigen, pPosicion, vlPosicionTotal)
                else
                    vlTextoRetorno := CopyStr(pTextoOrigen, pPosicion, "pTamañoMaximo");
        end;
        pPosicion += StrLen(vlTextoRetorno);
        exit(vlTextoRetorno);
    end;

    internal procedure fTraerDatosRespaldoPaso1()
    begin
        if Confirm('¿Desea importar facturas de respaldo?') then
            if fTraerDatosRespaldo() then Message('Proceso finalizado.') else Message('No se han encontrado facturas.');
    end;

    local procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
        Modify();
        if PurchLinesExist() then UpdateAllLineDim("Dimension Set ID", xRec."Dimension Set ID");
    end;

    internal procedure CreateDim(Type1: Integer; No1: Code[20]; Type2: Integer; No2: Code[20]; Type3: Integer; No3: Code[20]; Type4: Integer; No4: Code[20])
    begin
    end;

    internal procedure ShowDocDim()
    var OldDimSetID: Integer;
    begin
        OldDimSetID := "Dimension Set ID";
        "Dimension Set ID" := DimMgt.EditDimensionSet2("Dimension Set ID", StrSubstNo('%1 %2', ID_PLATAFORMA, NUM), "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");
        if OldDimSetID <> "Dimension Set ID" then begin Modify(); UpdateAllLineDim("Dimension Set ID", OldDimSetID); end;
    end;

    internal procedure PurchLinesExist(): Boolean
    begin
        tLineas.SetRange("ID Factura", ID_PLATAFORMA);
        exit(tLineas.FindFirst());
    end;

    local procedure UpdateAllLineDim(NewParentDimSetID: Integer; OldParentDimSetID: Integer)
    var NewDimSetID: Integer;
    begin
        tLineas.LockTable();
        tLineas.SetRange("ID Factura", ID_PLATAFORMA);
        if tLineas.FindSet() then repeat
            NewDimSetID := DimMgt.GetDeltaDimSetID(tLineas."Dimension Set ID", NewParentDimSetID, OldParentDimSetID);
            if tLineas."Dimension Set ID" <> NewDimSetID then begin
                tLineas."Dimension Set ID" := NewDimSetID;
                DimMgt.UpdateGlobalDimFromDimSetID(tLineas."Dimension Set ID", tLineas."Shortcut Dimension 1 Code", tLineas."Shortcut Dimension 2 Code");
                tLineas.Modify();
            end;
        until tLineas.Next() = 0;
    end;

    local procedure PostSoap(var Client: HttpClient; Url: Text; SoapAction: Text; Body: Text; var Response: HttpResponseMessage; var ResponseText: Text)
    var Content: HttpContent; Headers: HttpHeaders;
    begin
        Content.WriteFrom(Body);
        Content.GetHeaders(Headers);
        Headers.Clear();
        Headers.Add('Content-Type', 'text/xml; charset=utf-8');
        Client.DefaultRequestHeaders().Add('SOAPAction', SoapAction);
        Client.Post(Url, Content, Response);
        Response.Content().ReadAs(ResponseText);
    end;

    local procedure BuildStatusSoap(pCabeceraFacturaERecibida: Record "50007"; Status: Text; Reason: Text): Text
    begin
        exit('<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"><soapenv:Body><setDocumentStatus><documentId>' + pCabeceraFacturaERecibida.ID_PLATAFORMA + '</documentId><status>' + Status + '</status><reason>' + Reason + '</reason></setDocumentStatus></soapenv:Body></soapenv:Envelope>');
    end;

    local procedure ExtractXmlText(XmlText: Text; ElementName: Text): Text[1000]
    var StartTag: Text; EndTag: Text; StartPos: Integer; EndPos: Integer;
    begin
        StartTag := '<' + ElementName + '>';
        EndTag := '</' + ElementName + '>';
        StartPos := StrPos(XmlText, StartTag);
        EndPos := StrPos(XmlText, EndTag);
        if (StartPos = 0) or (EndPos = 0) or (EndPos <= StartPos) then exit('');
        exit(CopyStr(XmlText, StartPos + StrLen(StartTag), EndPos - StartPos - StrLen(StartTag)));
    end;
}
    end;
}

