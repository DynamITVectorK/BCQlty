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
        }
        field(2; NUM; Text[20])
        {
            Caption = 'Número';
        }
        field(3; SERIE; Text[20])
        {
            Caption = 'Serie';
        }
        field(4; FECHA_ENTRADA; Date)
        {
            Caption = 'Fecha Entrada';
        }
        field(5; FECHA_DEVENGO; Date)
        {
            Caption = 'Fecha Devengo';
        }
        field(6; EMISOR_CIF; Text[20])
        {
            Caption = 'CIF Emisor';
        }
        field(7; EMISOR_NOMBRE; Text[50])
        {
            Caption = 'Nombre Emisor';
        }
        field(8; EMISOR_DIRECCION; Text[100])
        {
            Caption = 'Dirección Emisor';
        }
        field(9; EMISOR_CIUDAD; Text[30])
        {
            Caption = 'Ciudad Emisor';
        }
        field(10; EMISOR_PROVINCIA; Text[30])
        {
            Caption = 'Provincia Emisor';
        }
        field(11; EMISOR_CP; Text[20])
        {
            Caption = 'Cód. Postal Emisor';
        }
        field(12; EMISOR_TELEFONO; Text[20])
        {
            Caption = 'Teléfono Emisor';
        }
        field(13; EMISOR_EMAIL; Text[80])
        {
            Caption = 'Email Emisor';
        }
        field(14; RECEPTOR_CIF; Text[20])
        {
            Caption = 'CIF Receptor';
        }
        field(22; FORMA_PAGO; Text[50])
        {
            Caption = 'Forma Pago';
        }
        field(23; FECHA_PAGO; Date)
        {
            Caption = 'Fecha Pago';
        }
        field(24; CCC_PAGO; Text[34])
        {
            Caption = 'IBAN Pago';
            Description = 'Mod. S2G (JMG) 06-03-14: Se cambia de 20 a 34 porque pasa de ser CCC a IBAN';
        }
        field(25; NOTAS; Text[250])
        {
            Caption = 'Notas';
            Description = 'Mod. S2G (JMG) 06-03-14: Se cambia de 100 a 250';
        }
        field(26; CONTACTO_NOMBRE; Text[50])
        {
            Caption = 'Nombre Contacto';
        }
        field(27; CONTACTO_TELEFONO; Text[20])
        {
            Caption = 'Teléfono Contacto';
        }
        field(28; CONTACTO_EMAIL; Text[80])
        {
            Caption = 'Email Contacto';
        }
        field(29; TOTAL_BASES; Decimal)
        {
            Caption = 'Total Bases';
        }
        field(30; TOTAL_TASAS; Decimal)
        {
            Caption = 'Total Tasas';
        }
        field(31; TOTAL_PAGAR; Decimal)
        {
            Caption = 'Total Pagar';
            Description = 'º';
        }
        field(32; Registrada; Boolean)
        {
            CalcFormula = Exist ("Purch. Inv. Header" WHERE (ID Plataforma FacturaE=FIELD(ID_PLATAFORMA),
                                                            Numero FacturaE=FIELD(NUM)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(33;"Proveedor NAV";Code[20])
        {

            trigger OnLookup()
            begin
                //Mod. S2G (JMG) 11-09-14: Añade un filtro para los CIFs con prefijo de país.
                //Quitado el lookup de propiedades
                //Vendor.No. WHERE (VAT Registration No.=FIELD(EMISOR_CIF))
                CLEAR(rVendor);
                rVendor.SETFILTER("VAT Registration No.",'%1|%2',EMISOR_CIF,
                                  rlLineasFacturaERecibida.fQuitarPaisCIF(EMISOR_CIF));
                CLEAR(fVendorList);
                fVendorList.SETTABLEVIEW(rVendor);
                fVendorList.LOOKUPMODE(TRUE);
                IF fVendorList.RUNMODAL = ACTION::LookupOK THEN BEGIN
                   fVendorList.GETRECORD(rVendor);
                   VALIDATE("Proveedor NAV",rVendor."No.");
                END;
                //Mod. S2G (JMG) 11-09-14: Fin.
            end;

            trigger OnValidate()
            begin
                //Mod. S2G (JMG) 11-09-14: Añade un filtro para los CIFs con prefijo de país.
                IF "Proveedor NAV" <> '' THEN BEGIN
                   CLEAR(rVendor);
                   rVendor.SETFILTER("VAT Registration No.",'%1|%2',EMISOR_CIF,
                                     rlLineasFacturaERecibida.fQuitarPaisCIF(EMISOR_CIF));
                   rVendor.SETRANGE("No.","Proveedor NAV");
                   IF NOT rVendor.FINDFIRST THEN
                      ERROR(Text50000);
                END;
                //Mod. S2G (JMG) 11-09-14: Fin.
            end;
        }
        field(34;"DOCUMENTACIÓN ADJUNTA";Text[200])
        {
            Caption = 'Documentación adjunta';
        }
        field(35;"DOCUMENTO PDF";Text[200])
        {
            Caption = 'Documento PDF';
        }
        field(36;"DOCUMENTO FACTURA";Text[200])
        {
            Caption = 'Documento Factura';
        }
        field(37;"Documento Registrado";Code[20])
        {
            CalcFormula = Lookup("Purch. Inv. Header".No. WHERE (ID Plataforma FacturaE=FIELD(ID_PLATAFORMA),
                                                                 Numero FacturaE=FIELD(NUM)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(38;"Documento en Curso";Code[20])
        {
            CalcFormula = Lookup("Purchase Header".No. WHERE (Document Type=FILTER(Invoice|Credit Memo),
                                                              ID Plataforma FacturaE=FIELD(ID_PLATAFORMA),
                                                              Numero FacturaE=FIELD(NUM)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(39;"Nombre proveedor";Text[100])
        {
            CalcFormula = Lookup(Vendor.Name WHERE (No.=FIELD(Proveedor NAV)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(40;"CIF Proveedor";Text[30])
        {
            CalcFormula = Lookup(Vendor."VAT Registration No." WHERE (No.=FIELD(Proveedor NAV)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(41;Rechazada;Boolean)
        {
        }
        field(42;"Motivo rechazo";Code[10])
        {
            Description = 'Mod. S2G (FTD) 21-01-14: Facturación Electrónica';

            trigger OnLookup()
            var
                rlMotivosrechazo: Record "7";
                rlExtendedTextLine: Record "280";
                plListadoRechazo: Page "8";
            begin
                /*
                 CLEAR(rlApprovalSetup);
                 rlApprovalSetup.GET;
                 rlApprovalSetup.TESTFIELD("Prefijo Estandar Rechazo");
                */
                 CLEAR(plListadoRechazo);
                 CLEAR(rlMotivosrechazo);
                 //rlMotivosrechazo.SETFILTER(Code ,'%1',rlApprovalSetup."Prefijo Estandar Rechazo" + '*');
                 rlMotivosrechazo.SETFILTER(Code ,'%1',PrefijoEstandarRechazo + '*');
                 plListadoRechazo.SETTABLEVIEW(rlMotivosrechazo);
                 plListadoRechazo.LOOKUPMODE(TRUE);
                 IF plListadoRechazo.RUNMODAL = ACTION::LookupOK THEN BEGIN
                  VALIDATE("Descripción Rechazo",'');
                  plListadoRechazo.GETRECORD(rlMotivosrechazo);
                  VALIDATE("Motivo rechazo",rlMotivosrechazo.Code);
                  CLEAR(rlExtendedTextLine);
                  rlExtendedTextLine.SETRANGE("Table Name",rlExtendedTextLine."Table Name"::"Standard Text");
                  rlExtendedTextLine.SETRANGE("No.",rlMotivosrechazo.Code);
                  rlExtendedTextLine.SETRANGE("Language Code",'ESP');
                  rlExtendedTextLine.SETRANGE("Text No.",1);
                  IF rlExtendedTextLine.FINDSET THEN REPEAT
                     VALIDATE("Descripción Rechazo","Descripción Rechazo" + COPYSTR(rlExtendedTextLine.Text,
                                                                              1,MAXSTRLEN("Descripción Rechazo")-STRLEN("Descripción Rechazo")));
                  UNTIL rlExtendedTextLine.NEXT=0;
                  rlExtendedTextLine.SETRANGE("Table Name",rlExtendedTextLine."Table Name"::"Standard Text");
                  rlExtendedTextLine.SETRANGE("No.",rlMotivosrechazo.Code);
                  rlExtendedTextLine.SETRANGE("Language Code",'EUS');
                  rlExtendedTextLine.SETRANGE("Text No.",1);
                  IF rlExtendedTextLine.FINDSET THEN BEGIN
                     VALIDATE("Descripción Rechazo","Descripción Rechazo" + COPYSTR(' / ',
                                                                              1,MAXSTRLEN("Descripción Rechazo")-STRLEN(' / ')));
                     REPEAT
                        VALIDATE("Descripción Rechazo","Descripción Rechazo" + COPYSTR(rlExtendedTextLine.Text,
                                                                                 1,MAXSTRLEN("Descripción Rechazo")-STRLEN("Descripción Rechazo")));
                     UNTIL rlExtendedTextLine.NEXT=0;
                  END;
                 END;
                 plListadoRechazo.LOOKUPMODE(FALSE);

            end;

            trigger OnValidate()
            begin
                CALCFIELDS("Documento en Curso","Documento Registrado");
                TESTFIELD("Documento en Curso",'');
                TESTFIELD("Documento Registrado",'');
                TESTFIELD(Rechazada,FALSE);
            end;
        }
        field(43;"Descripción Rechazo";Text[250])
        {
            Description = 'Mod. S2G (FTD) 21-01-14: Facturación Electrónica';
        }
        field(44;"Fecha Importación";Date)
        {
        }
        field(45;"Hora Importación";Time)
        {
        }
        field(46;"Usuario Importación";Text[250])
        {
        }
        field(47;"Abono Registrado";Code[20])
        {
            CalcFormula = Lookup("Purch. Cr. Memo Hdr.".No. WHERE (ID Plataforma FacturaE=FIELD(ID_PLATAFORMA),
                                                                   Numero FacturaE=FIELD(NUM)));
            Description = 'Mod. S2G (JMG) 25-02-15: Añade el campo para los casos de abonos';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50000;"Approval Status";Option)
        {
            Caption = 'Approval Status';
            Description = 'Z004';
            OptionCaption = ' ,Approval Pending,Approved,Rejected';
            OptionMembers = " ","Approval Pending",Approved,Rejected;
        }
        field(50001;EXPEDIENTE;Text[20])
        {
            Caption = 'Expediente';
            Description = 'Z035';

            trigger OnLookup()
            var
                tLotes: Record "50011";
                ListaLotes: Page "50028";
            begin
                //Z035 - JLF - 05/07/19: Inicio
                CLEAR(tLotes);
                tLotes.FILTERGROUP(4);
                tLotes.SETRANGE(Adjudicatario,"Proveedor NAV");
                tLotes.SETRANGE("Estado Expediente",tLotes."Estado Expediente"::"Adj.Definitiva");
                tLotes.FILTERGROUP(0);
                CLEAR(ListaLotes);
                ListaLotes.SETTABLEVIEW(tLotes);
                ListaLotes.LOOKUPMODE(TRUE);
                IF ListaLotes.RUNMODAL=ACTION::LookupOK THEN BEGIN
                  CLEAR(tLotes);
                  ListaLotes.GETRECORD(tLotes);
                  VALIDATE(EXPEDIENTE,tLotes."No. Expediente");
                  VALIDATE(Lote,tLotes.Lote);
                END;
                //Z035 - JLF - 05/07/19: Fin
            end;

            trigger OnValidate()
            var
                LinFacturaE: Record "50008";
            begin
                CLEAR(LinFacturaE);
                LinFacturaE.SETRANGE("ID Factura",ID_PLATAFORMA);
                LinFacturaE.MODIFYALL(EXPEDIENTE,EXPEDIENTE);

                //Z035 INICIO JRB 28/04/2020 Crear dimensiones en expedientes
                CLEAR(tExp);
                tExp.SETRANGE("No.",EXPEDIENTE);
                IF tExp.FINDSET THEN BEGIN
                  VALIDATE("Shortcut Dimension 1 Code",tExp."Shortcut Dimension 1 Code");
                  VALIDATE("Shortcut Dimension 2 Code",tExp."Shortcut Dimension 2 Code");
                  VALIDATE("Dimension Set ID",tExp."Dimension Set ID");
                END;
                //Z035 FIN JRB 28/04/2020 Crear dimensiones en expedientes

                //Z035 - INICIO JRB 28/04/2020 LLevar Numero cuenta del expediente a las lineas
                CLEAR(tExp);
                tExp.SETRANGE("No.",EXPEDIENTE);
                IF tExp.FINDSET THEN BEGIN
                  CLEAR(rlLineasFacturaERecibida);
                  rlLineasFacturaERecibida.SETRANGE("ID Factura",ID_PLATAFORMA);
                  IF rlLineasFacturaERecibida.FINDSET THEN BEGIN
                     REPEAT
                       rlLineasFacturaERecibida.VALIDATE("Cuenta NAV",tExp."Cuenta Contable");
                       rlLineasFacturaERecibida.MODIFY;
                     UNTIL rlLineasFacturaERecibida.NEXT=0;
                  END;
                END;

                //INICIO JRB Llevar cuenta contable del Lote
                CLEAR(tLote);
                tLote.SETRANGE("No. Expediente",EXPEDIENTE);
                tLote.SETRANGE(Lote,Lote);
                IF tLote.FINDSET THEN BEGIN
                  CLEAR(rlLineasFacturaERecibida);
                  rlLineasFacturaERecibida.SETRANGE("ID Factura",ID_PLATAFORMA);
                  IF rlLineasFacturaERecibida.FINDSET THEN BEGIN
                     REPEAT
                       rlLineasFacturaERecibida.VALIDATE("Cuenta NAV",tLote."Cuenta Contable Imputacion");
                       rlLineasFacturaERecibida.MODIFY;
                     UNTIL rlLineasFacturaERecibida.NEXT=0;
                  END;
                END;
                //FIN JRB Llevar cuenta contable del lote

                //Z035 - FIN JRB 28/04/2020 LLevar Numero cuenta del expediente a las lineas
            end;
        }
        field(50002;Lote;Text[30])
        {
            Description = 'Z035';
            TableRelation = Lotes.Lote WHERE (No. Expediente=FIELD(EXPEDIENTE));

            trigger OnValidate()
            var
                LinFacturaE: Record "50008";
                tLotes: Record "50011";
            begin
                IF Lote<>'' THEN BEGIN
                  CLEAR(tLotes);
                  tLotes.GET(EXPEDIENTE,Lote);
                  IF tLotes."Importe lote"=0 THEN
                    ERROR(Text50018);
                END;
                CLEAR(LinFacturaE);
                LinFacturaE.SETRANGE("ID Factura",ID_PLATAFORMA);
                LinFacturaE.MODIFYALL(Lote,Lote);
            end;
        }
        field(50057;"Shortcut Dimension 1 Code";Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            Description = 'Z035';
            TableRelation = "Dimension Value".Code WHERE (Global Dimension No.=CONST(1));

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
        CLEAR(rlLineasFacturaERecibida);
        rlLineasFacturaERecibida.SETRANGE("ID Factura",ID_PLATAFORMA);
        rlLineasFacturaERecibida.DELETEALL;
        CLEAR(rlTasasYRetencionesFacturaE);
        rlTasasYRetencionesFacturaE.SETRANGE("ID Factura",ID_PLATAFORMA);
        rlTasasYRetencionesFacturaE.DELETEALL;
    end;

    trigger OnInsert()
    begin
        "Fecha Importación" := TODAY;
        "Hora Importación" := DT2TIME(CURRENTDATETIME);
        "Usuario Importación" := USERID;
    end;

    var
        rlLineasFacturaERecibida: Record "50008";
        rlTasasYRetencionesFacturaE: Record "50009";
        vNombreFichero: Text[250];
        vID: Boolean;
        vNombre: Boolean;
        vContador: Integer;
        vContador2: Integer;
        vNumeroID: Text[250];
        rVendor: Record "23";
        Text50000: Label 'El proveedor debe coincidir con el CIF del emisor.';
        rPurchasesYPayablesSetup: Record "312";
        fVendorList: Page "27";
                         ErrorUser: Label 'User %1 is not the approval user';
        ErrorApp: Label 'Electronic Invoice is already approved';
        ErrorUserApp: Label 'Unable to approve invoice because there aren''t any user abailable';
        vText50000: Label 'Se ha generado la factura %1. Puede proceder a su revisión.';
        vText50001: Label '¿Desea rechazar esta factura?';
        vText50002: Label 'Proceso cancelado por el usuario.';
        vText50003: Label 'Factura rechazada correctamente.';
        vText50004: Label '¿ Desea enviar un correo de rechazo ?';
        "*********lo de la pagina": Text;
        vPasado: Boolean;
        vText50005: Label 'Si es cuenta 2 tiene que tener un cod activo, no se ha podido crear la factura';
        Text50001: Label 'Signed: ';
        CConfigProgressBar: Codeunit "8615";
        Text50002: Label 'Debe indicar aprobador';
        Text5000: Label 'Approving';
        PrefijoEstandarRechazo: Label 'RECHAZO';
        Text50018: Label 'Importe lote debe ser distinto de cero';
        vServerFileName: Text;
        DimMgt: Codeunit "408";
        tLineas: Record "50008";
        Text051: Label 'You may have changed a dimension.\\Do you want to update the lines?';
        tExp: Record "50001";
        tLote: Record "50011";

    [Scope('Internal')]
    procedure fTraerBackup()
    var
        alConnection: Automation ;
        alCommand: Automation ;
        alRecordset: Automation ;
        rlPurchasesPayablesSetup: Record "312";
        vlTextoConexion: Text[1024];
        vlTextoComando: Text[1024];
        vlActiveConnection: Variant;
        clInterfaceFacturaE: Codeunit "50003";
        vlBigText: BigText;
    begin
        //Importar Datos de la base de datos de respaldo.

        //Coger configuración de la base de datos de respaldo.
        CLEAR(rlPurchasesPayablesSetup);
        rlPurchasesPayablesSetup.GET;
        rlPurchasesPayablesSetup.TESTFIELD("Servidor Respaldo");
        rlPurchasesPayablesSetup.TESTFIELD("Base de datos Respaldo");
        rlPurchasesPayablesSetup.TESTFIELD("Usuario BD Respaldo");
        rlPurchasesPayablesSetup.TESTFIELD("Contraseña BD Respaldo");

        //Establecer la conexión.
        CLEAR(alConnection);
        IF ISCLEAR(alConnection) THEN
          CREATE(alConnection, FALSE, TRUE);
        vlTextoConexion :=
          'Driver={SQL Server};' +
          'Server=' + rlPurchasesPayablesSetup."Servidor Respaldo" + ';' +
          'Database=' + rlPurchasesPayablesSetup."Base de datos Respaldo" + ';' +
          'Uid=' + rlPurchasesPayablesSetup."Usuario BD Respaldo" + ';' +
          'Pwd=' + rlPurchasesPayablesSetup."Contraseña BD Respaldo" + ';';
        alConnection.ConnectionString:= vlTextoConexion;
        alConnection.Open;

        //Construir la acción.
        CLEAR(alCommand);
        IF ISCLEAR(alCommand) THEN
        //CREATE(alCommand);
        CREATE(alCommand, FALSE, TRUE);
        vlTextoComando := 'SELECT' +
                          'CAST(ID_INVOICE_AIF AS VARCHAR (30)) AS IDFactura,'+
                          'ID_INVOICE_AIF, ' +
                          'XML_DATA, ' +
                          'STATE ' +
                          'FROM INVOICE ' +
                          'WHERE STATE = ' + '''' + '''';

        vlActiveConnection := alConnection;
        alCommand.ActiveConnection := vlActiveConnection;
        alCommand.CommandText := vlTextoComando;
        alCommand.CommandType := 1;
        alCommand.CommandTimeout := 20;
        alCommand.Execute;

        CLEAR(alRecordset);

        IF ISCLEAR(alRecordset) THEN
          CREATE(alRecordset, FALSE, TRUE);
        alRecordset.ActiveConnection := alConnection;
        alRecordset.Open(alCommand);
        WHILE NOT alRecordset.EOF DO BEGIN
          CLEAR(vlBigText);
          vlBigText.ADDTEXT(FORMAT(alRecordset.Fields.Item('XML_DATA').Value));

          CLEAR(clInterfaceFacturaE);
          clInterfaceFacturaE.fImportarTablaFacturacion(alRecordset.Fields.Item('XML_DATA').Value);

          vlTextoComando := 'UPDATE INVOICE ' +
                            'SET STATE = ' + '''' + 'Traspasado' + '''' + ' ' +
                            'WHERE ID_INVOICE_AIF = ' + '''' + FORMAT(alRecordset.Fields.Item('IDFactura').Value) + '''';

          CLEAR(alCommand);
          IF ISCLEAR(alCommand) THEN
            CREATE(alCommand, FALSE, TRUE);
          alCommand.ActiveConnection := vlActiveConnection;

          alCommand.CommandText := vlTextoComando;
          alCommand.CommandType := 1;
          alCommand.CommandTimeout := 20;
          alCommand.Execute;

          alRecordset.MoveNext;
        END;
        alConnection.Close;
        CLEAR(alConnection);
    end;

    [Scope('Internal')]
    procedure fComprobarFacturaE(pPurchaseHeader: Record "38")
    var
        rlPurchaseLine: Record "39";
        rlCabeceraFacturaE: Record "50007";
        vlImporteFactura: Decimal;
        lText50000: Label 'El importe de la factura (%1) aplicando la tolerancia (%2) es distinto del total de la factura proveniente de Facturación electrónica (%3).';
        lText50001: Label 'Proceso cancelado por el usuario.';
        vlToleranciaMas: Decimal;
        vlToleranciaMenos: Decimal;
    begin
        IF (pPurchaseHeader."ID Plataforma FacturaE" <> '') AND
           (pPurchaseHeader."Numero FacturaE" <> '') THEN BEGIN
           vlImporteFactura := 0;
           CLEAR(rlPurchaseLine);
           rlPurchaseLine.SETRANGE("Document Type",pPurchaseHeader."Document Type");
           rlPurchaseLine.SETRANGE("Document No.",pPurchaseHeader."No.");
           IF rlPurchaseLine.FINDSET THEN REPEAT
              vlImporteFactura += rlPurchaseLine."Line Amount";
           UNTIL rlPurchaseLine.NEXT = 0;
           CLEAR(rlCabeceraFacturaE);
           rlCabeceraFacturaE.GET(pPurchaseHeader."ID Plataforma FacturaE",pPurchaseHeader."Numero FacturaE");
           //Incluir tolerancia en el control entre el importe factura e importe fact. electrónica.
           rPurchasesYPayablesSetup.GET;
           vlToleranciaMas := vlImporteFactura + rPurchasesYPayablesSetup."Importe tolerancia facturaE";
           vlToleranciaMenos := vlImporteFactura - rPurchasesYPayablesSetup."Importe tolerancia facturaE";
           IF (rlCabeceraFacturaE.TOTAL_PAGAR > vlToleranciaMas) OR (rlCabeceraFacturaE.TOTAL_PAGAR < vlToleranciaMenos) THEN
              ERROR(lText50000,vlImporteFactura,rPurchasesYPayablesSetup."Importe tolerancia facturaE",rlCabeceraFacturaE.TOTAL_PAGAR);
        END;
    end;

    [Scope('Internal')]
    procedure fTraerDatosRespaldo(): Boolean
    var
        alConnection: Automation ;
        alCommand: Automation ;
        alRecordset: Automation ;
        rlPurchasesPayablesSetup: Record "312";
        vlTextoConexion: Text[1024];
        vlTextoComando: Text[1024];
        clInterfaceFacturaE: Codeunit "50003";
        vlActiveConnection: Variant;
        vlLeido: Boolean;
        vlBigText: BigText;
        vlFile: File;
        vlInstream: InStream;
        vlXMLBigText: BigText;
        alParameter: Automation ;
        vlXMLVariant: Variant;
        vlOutStream: OutStream;
        rlTempBlob: Record "99008535" temporary;
        alXmlDoc: Automation ;
        alXMLText: Automation ;
        alXMLNodoNUM: Automation ;
        xlFacturaRecibida: XMLport "50002";
                               vlEstado: Text[30];
                               rlBDRespaldoFacturaRecibida: Record "50010";
                               rlCompanyInformation: Record "79";
                               clFileMgt: Codeunit "419";
                               vlIdFactura: Text;
                               vlClientFileName: Text;
    begin
        //Importar Datos de la base de datos de respaldo.

        CLEAR(rlCompanyInformation);
        rlCompanyInformation.GET;
        rlCompanyInformation.TESTFIELD("VAT Registration No.");

        //Coger configuración de la base de datos de respaldo.
        CLEAR(rlPurchasesPayablesSetup);
        rlPurchasesPayablesSetup.GET;
        rlPurchasesPayablesSetup.TESTFIELD("Servidor Respaldo");
        rlPurchasesPayablesSetup.TESTFIELD("Base de datos Respaldo");
        rlPurchasesPayablesSetup.TESTFIELD("Usuario BD Respaldo");
        rlPurchasesPayablesSetup.TESTFIELD("Contraseña BD Respaldo");

        //Establecer la conexión.
        CLEAR(alConnection);
        IF ISCLEAR(alConnection) THEN
          CREATE(alConnection, FALSE, TRUE);
        vlTextoConexion :=
          'Driver={SQL Server};' +
          'Server=' + rlPurchasesPayablesSetup."Servidor Respaldo" + ';' +
          'Database=' + rlPurchasesPayablesSetup."Base de datos Respaldo" + ';' +
          'Uid=' + rlPurchasesPayablesSetup."Usuario BD Respaldo" + ';' +
          'Pwd=' + rlPurchasesPayablesSetup."Contraseña BD Respaldo" + ';';
        alConnection.ConnectionString:= vlTextoConexion;
        alConnection.Open;

        //Construir la acción.
        CLEAR(alCommand);
        IF ISCLEAR(alCommand) THEN
          CREATE(alCommand, FALSE, TRUE);

        vlTextoComando := 'UPDATE INVOICE SET STATE = '''' WHERE STATE IS NULL';
        vlActiveConnection := alConnection;
        alCommand.ActiveConnection := vlActiveConnection;
        alCommand.CommandText := vlTextoComando;
        alCommand.CommandType := 1;
        alCommand.CommandTimeout := 20;
        alCommand.Execute;

        CLEAR(alCommand);
        IF ISCLEAR(alCommand) THEN
          CREATE(alCommand, FALSE, TRUE);

        vlTextoComando := 'UPDATE INVOICE SET CIF_BUYER = '''' WHERE CIF_BUYER IS NULL';
        vlActiveConnection := alConnection;
        alCommand.ActiveConnection := vlActiveConnection;
        alCommand.CommandText := vlTextoComando;
        alCommand.CommandType := 1;
        alCommand.CommandTimeout := 20;
        alCommand.Execute;

        CLEAR(alCommand);
        IF ISCLEAR(alCommand) THEN
          CREATE(alCommand, FALSE, TRUE);

        vlTextoComando := 'SELECT ' +
                        'CAST(ID_INVOICE_AIF AS VARCHAR (30)) AS IDFactura,'+
                        'CAST(STATE AS VARCHAR (30)) AS Estado,'+
                        'ID_INVOICE_AIF, ' +
                        'XML_DATA, ' +
                        'STATE ' +
                        'FROM INVOICE ' +


                        'WHERE (CIF_BUYER = ' + '''' + rlCompanyInformation."VAT Registration No." + '''' + ') ' ;//+

                        //'AND (STATE <> ' + '''' + 'Traspasado' + '''' + ')';
                        //JLF TEMPORAL

        vlActiveConnection := alConnection;
        alCommand.ActiveConnection := vlActiveConnection;
        alCommand.CommandText := vlTextoComando;
        alCommand.CommandType := 1;
        alCommand.CommandTimeout := 20;
        alCommand.Execute;

        CLEAR(alRecordset);
        IF ISCLEAR(alRecordset) THEN
          CREATE(alRecordset, FALSE, TRUE);
        alRecordset.ActiveConnection := alConnection;
        alRecordset.Open(alCommand);
        vlLeido := FALSE;
        WHILE NOT alRecordset.EOF DO BEGIN

          vlEstado := FORMAT(alRecordset.Fields.Item('Estado').Value);

          //JLF TEMPORAL
          //IF (vlEstado <> 'Traspasado') THEN BEGIN

            vlLeido := TRUE;

            CLEAR(vlXMLVariant);
            vlXMLVariant := alRecordset.Fields.Item('XML_DATA').Value;
            CLEAR(alXmlDoc);
            CREATE(alXmlDoc, FALSE, TRUE);
            alXmlDoc.load(vlXMLVariant);

            //JLF 20190920
            //alXmlDoc.save(TEMPORARYPATH+FORMAT(alRecordset.Fields.Item('IDFactura').Value)+'.xml');
            CLEAR(vlIdFactura);
            vlIdFactura := alRecordset.Fields.Item('IDFactura').Value;
            CLEAR(vlClientFileName);
            vlClientFileName := clFileMgt.ClientTempFileNameWithFileName(vlIdFactura,'xml');
            //alXmlDoc.save(vlRuta);
            alXmlDoc.save(vlClientFileName);
            CLEAR(vServerFileName);
            vServerFileName := clFileMgt.UploadFileSilent(vlClientFileName);
            //JLF 20190920

            CLEAR(rlBDRespaldoFacturaRecibida);
            rlBDRespaldoFacturaRecibida.INIT;
            rlBDRespaldoFacturaRecibida."ID Factura" := FORMAT(alRecordset.Fields.Item('IDFactura').Value);
            rlBDRespaldoFacturaRecibida.Estado := FORMAT(alRecordset.Fields.Item('Estado').Value);

            //JLF 20190920
            //rlBDRespaldoFacturaRecibida."Datos XML Original".IMPORT(TEMPORARYPATH+FORMAT(alRecordset.Fields.Item('IDFactura').Value)+
            //                        '.xml');
            rlBDRespaldoFacturaRecibida."Datos XML Original".IMPORT(vServerFileName);
            //JLF 20190920


            IF NOT rlBDRespaldoFacturaRecibida.INSERT(TRUE) THEN
                rlBDRespaldoFacturaRecibida.MODIFY(TRUE);

            CLEAR(rlTempBlob);

            //JLF 20190920
            //rlTempBlob.Blob.IMPORT(TEMPORARYPATH+FORMAT(alRecordset.Fields.Item('IDFactura').Value)+'.xml');
            rlTempBlob.Blob.IMPORT(vServerFileName);
            //JLF 20190920

            rlTempBlob.Blob.CREATEINSTREAM(vlInstream);
            vlTextoComando := 'UPDATE INVOICE ' +
                              'SET STATE = ' + '''' + 'Traspasado' + '''' + ' ' +
                              'WHERE ID_INVOICE_AIF = ' + '''' + FORMAT(alRecordset.Fields.Item('IDFactura').Value) + '''';
            CLEAR(alCommand);
            IF ISCLEAR(alCommand) THEN
              CREATE(alCommand, FALSE, TRUE);
            alCommand.ActiveConnection := vlActiveConnection;
            alCommand.CommandText := vlTextoComando;
            alCommand.CommandType := 1;
            alCommand.CommandTimeout := 20;
            alCommand.Execute;
            COMMIT;

          //JLF TEMPORAL
          //END;

          alRecordset.MoveNext;

        END;

        //***BGS 02/05/19: Inicio
        rlBDRespaldoFacturaRecibida.fSetClientFileName(vlClientFileName);
        //***BGS 02/05/19: Fin

        rlBDRespaldoFacturaRecibida.fProcesarLineas;

        alConnection.Close;
        CLEAR(alConnection);

        EXIT(vlLeido);
    end;

    [Scope('Internal')]
    procedure fQuitarCodigoRuta(pRutaAlfresco: Text[1000]) Ruta: Text[1000]
    begin
        Ruta := pRutaAlfresco;
        WHILE STRPOS(Ruta,'app:') <> 0 DO BEGIN
           Ruta := DELSTR(Ruta,STRPOS(Ruta,'app:'),4);
        END;

        WHILE STRPOS(Ruta,'cm:') <> 0 DO BEGIN
           Ruta := DELSTR(Ruta,STRPOS(Ruta,'cm:'),3);
        END;
    end;

    [Scope('Internal')]
    procedure fCogerTicketAlfresco(): Text[1000]
    var
        vlTextSOAPBegin: Label '<?xml version="1.0" encoding="utf-8"?> <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns="http://www.alfresco.org/ws/service/content/1.0" xmlns:ns1="http://www.alfresco.org/ws/model/content/1.0">';
        vlTextSOAPEnd: Label '</soapenv:Body> </soapenv:Envelope>';
        vlTextSOAPBegin2: Label '<soapenv:Header /><soapenv:Envelope><soapenv:Body>';
        locautXmlHttp: Automation ;
        locautXmlDoc: Automation ;
        vlRequestText: Text[1024];
        rlGeneralLedgerSetup: Record "98";
        vlFichero: File;
        vlBigText: BigText;
        vlInStream: InStream;
        "vlContraseña": Text[1024];
        vlXMLDomNode: Automation ;
        rlPurchasesPayablesSetup: Record "312";
        vlUsername: Text[1000];
        vlTicket: Text[1000];
        vlSessionid: Text[1000];
        tlRecordLink: Record "2000000068";
    begin
        CLEAR(rlPurchasesPayablesSetup);
        rlPurchasesPayablesSetup.GET;
        EXIT(tlRecordLink.fGetTicketAlfresco(rlPurchasesPayablesSetup."Ruta WS Ticket Alfresco",
                                             rlPurchasesPayablesSetup."Usuario Alfresco",
                                             rlPurchasesPayablesSetup."Contraseña Alfresco"));
        
        /********
        //Rechaza la factura en FacturaE
        CLEAR(rlPurchasesPayablesSetup);
        rlPurchasesPayablesSetup.GET;
        rlPurchasesPayablesSetup.TESTFIELD("Usuario Alfresco");
        rlPurchasesPayablesSetup.TESTFIELD("Contraseña Alfresco");
        rlPurchasesPayablesSetup.TESTFIELD("Ruta WS Ticket Alfresco");
        
        //Creación del mensaje SOAP.
        CLEAR(locautXmlDoc);
        CREATE(locautXmlDoc, FALSE, TRUE);
        CLEAR(locautXmlHttp);
        CREATE(locautXmlHttp, FALSE, TRUE);
        locautXmlDoc.loadXML(vlTextSOAPBegin +
                              '<soapenv:Body>' +
                                '<ns:startSession>' +
                                  '<ns:username>' +
                                  rlPurchasesPayablesSetup."Usuario Alfresco" +
                                  '</ns:username>' +
                                  '<ns:password>' +
                                  rlPurchasesPayablesSetup."Contraseña Alfresco" +
                                  '</ns:password>' +
                                '</ns:startSession>' +
                              '</soapenv:Body>' +
                            '</soapenv:Envelope>');
        
        //Creación cabecera mensaje SOAP.
        locautXmlHttp.Open('POST',rlPurchasesPayablesSetup."Ruta WS Ticket Alfresco");
        locautXmlHttp.SetRequestHeader('Content-Type','text/xml; charset=utf-8');
        locautXmlHttp.SetRequestHeader('SOAPAction', 'startSessionRequest');
        locautXmlHttp.Send(locautXmlDoc);
        
        //Guarda datos
        CLEAR(locautXmlDoc);
        CREATE(locautXmlDoc, FALSE, TRUE);
        locautXmlDoc.async:=FALSE;
        locautXmlDoc.load(locautXmlHttp.ResponseStream);
        vlXMLDomNode := locautXmlDoc.documentElement.selectSingleNode
                          ('/soapenv:Envelope/soapenv:Body/startSessionResponse/ns1:startSessionReturn/ns1:username');
        IF NOT ISCLEAR(vlXMLDomNode) THEN
          vlUsername := vlXMLDomNode.text;
        
        vlXMLDomNode := locautXmlDoc.documentElement.selectSingleNode
                          ('/soapenv:Envelope/soapenv:Body/startSessionResponse/ns1:startSessionReturn/ns1:ticket');
        IF NOT ISCLEAR(vlXMLDomNode) THEN
          vlTicket := vlXMLDomNode.text;
        
        vlXMLDomNode := locautXmlDoc.documentElement.selectSingleNode
                          ('/soapenv:Envelope/soapenv:Body/startSessionResponse/ns1:startSessionReturn/ns1:sessionid');
        
        IF NOT ISCLEAR(vlXMLDomNode) THEN
          vlSessionid := vlXMLDomNode.text;
        EXIT(vlTicket);
        ********/

    end;

    [Scope('Internal')]
    procedure fCogerTicketAlfrescoAut(pServidor: Text;pUsuario: Text;pContrasena: Text): Text[1000]
    var
        vlTextSOAPBegin: Label '<?xml version="1.0" encoding="utf-8"?> <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns="http://www.alfresco.org/ws/service/content/1.0" xmlns:ns1="http://www.alfresco.org/ws/model/content/1.0">';
        vlTextSOAPEnd: Label '</soapenv:Body> </soapenv:Envelope>';
        vlTextSOAPBegin2: Label '<soapenv:Header /><soapenv:Envelope><soapenv:Body>';
        locautXmlHttp: Automation ;
        locautXmlDoc: Automation ;
        locautXmlDoc2: Automation ;
        reqText: Text;
        vlTicket: Text;
    begin
        //Texto para la llamada: los nodos deben existir en el XML que se obtiene con la llamada desde WebServReqMgt
        CLEAR(reqText);
        reqText := vlTextSOAPBegin +
                    '<soapenv:Body>' +
                      '<ns:startSession>' +
                        '<ns:username>' + pUsuario   + '</ns:username>' +
                        '<ns:password>' + pContrasena + '</ns:password>' +
                      '</ns:startSession>' +
                      '</soapenv:Body>' +
                    '</soapenv:Envelope>';


        //Cargamos el XMLDocument
        CLEAR(locautXmlDoc);
        CREATE(locautXmlDoc,FALSE,TRUE);
        locautXmlDoc.loadXML(reqText);

        //Enviamos la petición al Web service
        CLEAR(locautXmlHttp);
        CREATE(locautXmlHttp,FALSE,TRUE);
        locautXmlHttp.Open('POST',pServidor);
        locautXmlHttp.SetRequestHeader('Content-Type','text/xml; charset=utf-8');
        locautXmlHttp.SetRequestHeader('SOAPAction', 'startSessionRequest');
        locautXmlHttp.Send(locautXmlDoc);

        //Guardamos la respuesta
        CLEAR(locautXmlDoc);
        CREATE(locautXmlDoc,FALSE,TRUE);
        locautXmlDoc.load(locautXmlHttp.ResponseStream);

        //OBTENEMOS TICKET
        //Seleccionamos el Nodo de Ticket
        locautXmlDoc2 := locautXmlDoc.documentElement.selectSingleNode('/soapenv:Envelope/soapenv:Body/startSessionResponse/ns1:startSessionReturn/ns1:ticket');
        vlTicket := locautXmlDoc2.text;

        //Devolvemos el Ticket
        EXIT(vlTicket);
    end;

    [Scope('Internal')]
    procedure fAbrirDocumentoAlfresco(pFichero: Text[250])
    var
        rlPurchasesPayablesSetup: Record "312";
    begin
        HYPERLINK(fGetURLToOpen(pFichero));
    end;

    [Scope('Internal')]
    procedure fAbrirContenedorAlfresco(pFichero: Text[250])
    var
        rlPurchasesPayablesSetup: Record "312";
    begin
        HYPERLINK(fGetURLToNavigate(pFichero));
    end;

    [Scope('Internal')]
    procedure fQuitarCodigoRutaAdjuntos(pRutaAlfresco: Text[1000];pDescargar: Boolean) Ruta: Text[1000]
    begin
        Ruta := pRutaAlfresco;
        WHILE STRPOS(Ruta,'app:') <> 0 DO BEGIN
           Ruta := DELSTR(Ruta,STRPOS(Ruta,'app:'),4);
        END;

        WHILE STRPOS(Ruta,'cm:') <> 0 DO BEGIN
           Ruta := DELSTR(Ruta,STRPOS(Ruta,'cm:'),3);
        END;

        WHILE STRPOS(Ruta,'cm_') <> 0 DO BEGIN
           Ruta := DELSTR(Ruta,STRPOS(Ruta,'cm_'),3);
        END;

        IF NOT pDescargar THEN BEGIN
           WHILE STRPOS(Ruta,'/company_home') <> 0 DO BEGIN
              Ruta := DELSTR(Ruta,STRPOS(Ruta,'/company_home'),STRLEN('/company_home'));
           END;
        END;
    end;

    [Scope('Internal')]
    procedure fCopiarDocumentosAlfresco(pCabeceraFacturaERecibida: Record "50007";var pPurchaseHeader: Record "38")
    var
        vlTextSOAPBegin: Label '<?xml version="1.0" encoding="utf-8"?>';
        vlTextSOAPEnd: Label '</soapenv:Body> </soapenv:Envelope>';
        vlTextSOAPBegin2: Label '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns="http://www.alfresco.org/ws/service/content/1.0" xmlns:ns1="http://www.alfresco.org/ws/model/content/1.0">';
        locautXmlHttp: Automation ;
        locautWinhttpcopia: Automation ;
        locautxmlhttpcopia: Automation ;
        locautXmlDoc: Automation ;
        vlRequestText: Text[1024];
        rlGeneralLedgerSetup: Record "98";
        vlFichero: File;
        vlBigText: BigText;
        vlOutstream: OutStream;
        vlInStream: InStream;
        "vlContraseña": Text[1024];
        vlXMLDomNode: Automation ;
        alAdoStream: Automation ;
        vlTextoMensaje1: Text[1024];
        vlTextoMensaje2: Text[1024];
        vlTextoMensaje3: Text[1024];
        vlTextoMensaje4: Text[1024];
        vlTextoMensaje5: Text[1024];
        vlTextoMensaje6: Text[1024];
        vlVariant: Variant;
        vlRespuesta: Text[1024];
        rlTempBlob: Record "99008535" temporary;
        rlPurchasesPayablesSetup: Record "312";
        clFuncionesVarias: Codeunit "50000";
        rlRecordLink: Record "2000000068";
        rlRecordRef: RecordRef;
        vlRutaAdjunto: Text[250];
    begin
        //Comprobaciones previas
        CLEAR(rlPurchasesPayablesSetup);
        rlPurchasesPayablesSetup.GET;
        rlPurchasesPayablesSetup.TESTFIELD("Ruta raíz Alfresco");
        vlRutaAdjunto := rlPurchasesPayablesSetup."Ruta raíz Alfresco" +
            'download/direct?path='+
            pCabeceraFacturaERecibida.fQuitarCodigoRuta(pCabeceraFacturaERecibida."DOCUMENTO PDF");
        pPurchaseHeader.ADDLINK(vlRutaAdjunto);

        CLEAR(rlRecordLink);
        CLEAR(rlRecordRef);
        rlRecordRef.OPEN(38);
        rlRecordRef.GETTABLE(pPurchaseHeader);
        rlRecordLink.SETRANGE("Record ID", rlRecordRef.RECORDID);
        rlRecordLink.SETRANGE(URL1,vlRutaAdjunto);
        IF rlRecordLink.FINDSET THEN REPEAT
          rlRecordLink."Tipo Adjunto" := rlRecordLink."Tipo Adjunto"::PDF;
          rlRecordLink.MODIFY;
        UNTIL rlRecordLink.NEXT = 0;

        //Creación del mensaje SOAP.
        vlRutaAdjunto := rlPurchasesPayablesSetup."Ruta raíz Alfresco" +
            'download/direct?path='+
            pCabeceraFacturaERecibida.fQuitarCodigoRuta(pCabeceraFacturaERecibida."DOCUMENTO FACTURA");
        pPurchaseHeader.ADDLINK(vlRutaAdjunto);

        CLEAR(rlRecordLink);
        CLEAR(rlRecordRef);
        rlRecordRef.OPEN(38);
        rlRecordRef.GETTABLE(pPurchaseHeader);
        rlRecordLink.SETRANGE("Record ID", rlRecordRef.RECORDID);
        rlRecordLink.SETRANGE(URL1,vlRutaAdjunto);
        IF rlRecordLink.FINDSET THEN REPEAT
          rlRecordLink."Tipo Adjunto" := rlRecordLink."Tipo Adjunto"::XML;
          rlRecordLink.MODIFY;
        UNTIL rlRecordLink.NEXT = 0;

        //Creación del mensaje SOAP.
        //Documentos adjuntos


        //<Z004  04  CIMUBISA-08 BGS 2018.02.08
        //fVerFacturaAlfrescoQueryCh(pCabeceraFacturaERecibida,pPurchaseHeader);

        //Copiamos los Record Link
        pPurchaseHeader.COPYLINKS(pCabeceraFacturaERecibida);
        //>Z004  04  CIMUBISA-08 BGS 2018.02.08
    end;

    [Scope('Internal')]
    procedure fVerFacturaAlfrescoQueryCh(pCabeceraFacturaERecibida: Record "50007";var pPurchaseHeader: Record "38")
    var
        vlTextSOAPBegin: Label '<?xml version="1.0" encoding="utf-8"?>';
        vlTextSOAPEnd: Label '</soapenv:Body> </soapenv:Envelope>';
        vlTextSOAPBegin2: Label '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns="http://www.alfresco.org/ws/service/content/1.0" xmlns:ns1="http://www.alfresco.org/ws/model/content/1.0" xmlns:ns2="http://www.alfresco.org/ws/model/content/1.0">';
        locautXmlHttp: Automation ;
        locautWinhttpcopia: Automation ;
        locautxmlhttpcopia: Automation ;
        locautXmlDoc: Automation ;
        vlRequestText: Text[1024];
        rlGeneralLedgerSetup: Record "98";
        vlFichero: File;
        vlBigText: BigText;
        vlOutstream: OutStream;
        vlInStream: InStream;
        "vlContraseña": Text[1024];
        vlXMLDomNode: Automation ;
        vlXMLDomNodeList: Automation ;
        vlXMLDomSelection: Automation ;
        alAdoStream: Automation ;
        vlTextoMensaje1: Text[1024];
        vlTextoMensaje2: Text[1024];
        vlTextoMensaje3: Text[1024];
        vlTextoMensaje4: Text[1024];
        vlTextoMensaje5: Text[1024];
        vlTextoMensaje6: Text[1024];
        vlVariant: Variant;
        vlRespuesta: Text[1024];
        rlTempBlob: Record "99008535" temporary;
        i: Integer;
        rlPurchasesPayablesSetup: Record "312";
        clFileManagement: Codeunit "419";
        vlClientFileName: Text;
    begin
        //WS Alfresco
        CLEAR(rlPurchasesPayablesSetup);
        rlPurchasesPayablesSetup.GET;
        rlPurchasesPayablesSetup.TESTFIELD("Usuario Alfresco");
        rlPurchasesPayablesSetup.TESTFIELD("Contraseña Alfresco");
        rlPurchasesPayablesSetup.TESTFIELD("Ruta WS Ticket Alfresco");


        //Creación del mensaje SOAP.
        CLEAR(locautXmlDoc);
        CREATE(locautXmlDoc, FALSE, TRUE);
        CLEAR(locautXmlHttp);
        CREATE(locautXmlHttp, FALSE, TRUE);

        vlTextoMensaje1 :=
        '<soapenv:Header>' +
        '<wsse:Security xmlns:wsse="http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd" ' +
        'soapenv:mustUnderstand="1">' +
        '<wsu:Timestamp xmlns:wsu="http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-utility-1.0.xsd">' +
          '<wsu:Created>'+
          FORMAT(CURRENTDATETIME,0,'<Year4>-<Month,2>-<Day,2>T<Hours24,2>:<Minutes,2>:<Seconds,2>Z') +
          '</wsu:Created>' +
          '<wsu:Expires>2024-05-19T23:23:28.031Z</wsu:Expires>' +
        '</wsu:Timestamp>' +
        '<wsse:UsernameToken xmlns:wsse="http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd">' +
          '<wsse:Username>' +
          'eFacturaRecibida';

        vlTextoMensaje2 :=
          '</wsse:Username>' +
          '<wsse:Password Type="http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-username-token-profile-1.0#PasswordText">' +
          fCogerTicketAlfresco +
          '</wsse:Password>' +
        '</wsse:UsernameToken>' +
        '</wsse:Security>' +
        '<ns:QueryConfiguration>' +
          '<ns1:fetchSize>500</ns1:fetchSize>' +
        '</ns:QueryConfiguration>' +
        '</soapenv:Header>';

        vlTextoMensaje3 :=
        '<soapenv:Body>' +
            '<ns:queryChildren>' +
              '<ns:node>' +
                '<ns2:store>' +
                  '<ns2:scheme>' +
                  'workspace' +
                  '</ns2:scheme>' +
                  '<ns2:address>' +
                  'SpacesStore' +
                  '</ns2:address>' +
                '</ns2:store>' +
                '<ns2:path>' +
                pCabeceraFacturaERecibida."DOCUMENTACIÓN ADJUNTA" +
                '</ns2:path>' +
              '</ns:node>' +
            '</ns:queryChildren>' +
        '</soapenv:Body>';

        vlTextoMensaje4 :=
        '</soapenv:Envelope>';


        CLEAR(alAdoStream);
        CREATE(alAdoStream, FALSE, TRUE);
        alAdoStream.Open;
        alAdoStream.Charset('UTF-8');

        alAdoStream.WriteText(vlTextSOAPBegin + vlTextSOAPBegin2 + vlTextoMensaje1);
        alAdoStream.WriteText(vlTextoMensaje2 + vlTextoMensaje3 + vlTextoMensaje4);


        //Creamos fichero temporal equipo cliente (vlClientFileName)
        //alAdoStream.SaveToFile(TEMPORARYPATH + 'MensajeAlfrescoXMLNAVRep.xml',2);
        CLEAR(vlClientFileName);
        vlClientFileName := clFileManagement.ClientTempFileNameWithFileName('MensajeAlfrescoXMLNAVRep','xml');
        IF clFileManagement.ClientFileExists(vlClientFileName) THEN
          clFileManagement.DeleteClientFile(vlClientFileName);
        alAdoStream.SaveToFile(vlClientFileName,2);

        alAdoStream.Close;

        //Utilizamos el fichero creado con Codeunit FileManagement
        //locautXmlDoc.load(TEMPORARYPATH + 'MensajeAlfrescoXMLNAVRep.xml');
        locautXmlDoc.load(vlClientFileName);

        //Creación cabecera mensaje SOAP.
        locautXmlHttp.Open('POST',rlPurchasesPayablesSetup."Ruta WS Ticket Alfresco",FALSE);
        locautXmlHttp.SetRequestHeader('Content-Type','text/xml; charset=utf-8');
        locautXmlHttp.SetRequestHeader('SOAPAction', 'queryChildren');
        locautXmlHttp.Send(locautXmlDoc);


        IF NOT locautXmlHttp.WaitForResponse(200000) THEN
          ERROR('Excedido el tiempo de espera');

        //Guarda datos
        CLEAR(locautXmlDoc);
        CREATE(locautXmlDoc, FALSE, TRUE);
        CLEAR(vlXMLDomNodeList);
        locautXmlDoc.async:=FALSE;
        locautXmlDoc.load(locautXmlHttp.ResponseStream);
        vlXMLDomNodeList := locautXmlDoc.getElementsByTagName('ns1:resultSet');
        CLEAR(vNombre);
        CLEAR(vNombreFichero);
        CLEAR(vID);
        CLEAR(vNumeroID);
        CLEAR(vContador);
        CLEAR(vContador2);
        fRecorrerXMLAdjuntos('ns1:resultSet',vlXMLDomNodeList,pPurchaseHeader,pCabeceraFacturaERecibida);
    end;

    [Scope('Internal')]
    procedure fRecorrerXMLAdjuntos(pElemento: Text[250];pXMLNodeList: Automation ;var pPurchaseHeader: Record "38";pCabeceraFacturaERecibida: Record "50007")
    var
        XMLNodeList: Automation ;
        XMLNode: Automation ;
        i: Integer;
        XMLNodeList2: Automation ;
        XMLNode2: Automation ;
        rlPurchasesPayablesSetup: Record "312";
        rlRecordLink: Record "2000000068";
        rlRecordRef: RecordRef;
        vlRutaAdjunto: Text[250];
    begin
        //Recorrer Nodos XML
        CLEAR(rlPurchasesPayablesSetup);
        rlPurchasesPayablesSetup.GET;
        rlPurchasesPayablesSetup.TESTFIELD("Ruta raíz Alfresco");

        XMLNodeList := pXMLNodeList;
        FOR i:=0 TO XMLNodeList.length()-1 DO BEGIN
          XMLNode:= XMLNodeList.item(i);
          IF XMLNode.hasChildNodes THEN BEGIN
            XMLNodeList2 := XMLNode.childNodes;
            fRecorrerXMLAdjuntos(XMLNode.nodeName,XMLNodeList2,pPurchaseHeader,pCabeceraFacturaERecibida);
          END
          ELSE BEGIN
            IF XMLNode.text = '{http://www.alfresco.org/model/content/1.0}name' THEN BEGIN
              vNombre := TRUE;
              vContador := 1;
            END
            ELSE
              IF XMLNode.text = '{http://www.alfresco.org/model/system/1.0}node-uuid' THEN BEGIN
                vID := TRUE;
                vContador2 := 1;
              END
              ELSE
              BEGIN
                IF vNombre THEN
                   vContador += 1;
                IF vContador = 3 THEN BEGIN
                   vNombreFichero := XMLNode.text;
                   vContador := 0;
                   vNombre := FALSE;
                END;
                IF vID THEN
                   vContador2 += 1;
                IF vContador2 = 3 THEN BEGIN
                   vNumeroID := XMLNode.text;
                   vContador2 := 0;
                   vID := FALSE;
                   //fCargarDocumentoAdjunto(vNombreFichero,vNumeroID,pPurchaseHeader,pCabeceraFacturaERecibida);
                   vlRutaAdjunto := rlPurchasesPayablesSetup."Ruta raíz Alfresco" +
                        'download/direct?path=' + fQuitarCodigoRutaAdjuntos(pCabeceraFacturaERecibida."DOCUMENTACIÓN ADJUNTA",TRUE) +
                        '/' +
                        vNombreFichero;
                   pPurchaseHeader.ADDLINK(vlRutaAdjunto);
                   CLEAR(rlRecordLink);
                   CLEAR(rlRecordRef);
                   rlRecordRef.OPEN(38);
                   rlRecordRef.GETTABLE(pPurchaseHeader);
                   rlRecordLink.SETRANGE("Record ID", rlRecordRef.RECORDID);
                   rlRecordLink.SETRANGE(URL1,vlRutaAdjunto);
                   IF rlRecordLink.FINDSET THEN REPEAT
                      rlRecordLink."Tipo Adjunto" := rlRecordLink."Tipo Adjunto"::"Documentos Adjuntos";
                      rlRecordLink.MODIFY;
                   UNTIL rlRecordLink.NEXT = 0;

                END;
              END;
          END;
        END;
    end;

    [Scope('Internal')]
    procedure fCargarDocumentoAdjunto(pNombre: Text[250];pID: Text[250];var pPurchaseHeader: Record "38";pCabeceraFacturaERecibida: Record "50007")
    var
        vlTextSOAPBegin: Label '<?xml version="1.0" encoding="utf-8"?>';
        vlTextSOAPEnd: Label '</soapenv:Body> </soapenv:Envelope>';
        vlTextSOAPBegin2: Label '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns="http://www.alfresco.org/ws/service/content/1.0" xmlns:ns1="http://www.alfresco.org/ws/model/content/1.0">';
        locautXmlHttp: Automation ;
        locautWinhttpcopia: Automation ;
        locautxmlhttpcopia: Automation ;
        locautXmlDoc: Automation ;
        vlRequestText: Text[1024];
        rlGeneralLedgerSetup: Record "98";
        vlFichero: File;
        vlBigText: BigText;
        vlOutstream: OutStream;
        vlInStream: InStream;
        "vlContraseña": Text[1024];
        vlXMLDomNode: Automation ;
        alAdoStream: Automation ;
        vlTextoMensaje1: Text[1024];
        vlTextoMensaje2: Text[1024];
        vlTextoMensaje3: Text[1024];
        vlTextoMensaje4: Text[1024];
        vlTextoMensaje5: Text[1024];
        vlTextoMensaje6: Text[1024];
        vlVariant: Variant;
        vlRespuesta: Text[1024];
        rlTempBlob: Record "99008535" temporary;
        rlPurchasesPayablesSetup: Record "312";
        clFuncionesVarias: Codeunit "50000";
        rlCabeceraFacturaE: Record "50007";
    begin
        //Comprobaciones previas
        CLEAR(rlPurchasesPayablesSetup);
        rlPurchasesPayablesSetup.GET;
        rlPurchasesPayablesSetup.TESTFIELD("Ruta raíz Alfresco");
        rlPurchasesPayablesSetup.TESTFIELD("Usuario Alfresco");
        rlPurchasesPayablesSetup.TESTFIELD("Contraseña Alfresco");

        //Creación del mensaje SOAP.
        //Documento PDF
        CLEAR(locautXmlDoc);
        CREATE(locautXmlDoc, FALSE, TRUE);
        CLEAR(locautXmlHttp);
        CREATE(locautXmlHttp, FALSE, TRUE);

        locautXmlHttp.Open('GET',rlPurchasesPayablesSetup."Ruta raíz Alfresco" +
        'download/direct?path=' + fQuitarCodigoRutaAdjuntos(pCabeceraFacturaERecibida."DOCUMENTACIÓN ADJUNTA",TRUE) +
        '/' +
        pNombre +
        '&ticket=' + rlCabeceraFacturaE.fCogerTicketAlfresco,TRUE);
        locautXmlHttp.Send();
        IF NOT locautXmlHttp.WaitForResponse(100000) THEN
        ERROR('Excedido el tiempo de espera');

        CLEAR(vlInStream);
        CLEAR(vlOutstream);
        CLEAR(rlTempBlob);
        rlTempBlob.INIT;
        vlInStream := locautXmlHttp.ResponseStream;
        rlTempBlob.Blob.CREATEOUTSTREAM(vlOutstream);
        COPYSTREAM(vlOutstream,vlInStream);
        rlTempBlob.CALCFIELDS(Blob);
    end;

    [Scope('Internal')]
    procedure ApproveEInvoice()
    var
        UserSetup: Record "91";
        clSubscribedEvents: Codeunit "50002";
    begin
        //JLF: Comenta (AT) que esta función de momento no la pasamos y que ya veremos si aplicarán Aprobaciones o no
        //        Para que no casque he anulado la record: AreasRecordTable50071que viene de Cimubisa
        /*
        CASE "Approval Status" OF
          0: BEGIN
            TESTFIELD(Area);
            CheckPurchaseNeedInLines;
            Areas.RESET;
            Areas.GET(Area);
            Areas.TESTFIELD("Responsable User ID");
            "Approval Area User" := Areas."Responsable User ID";
            "Approval Status" := "Approval Status"::"Approval Pending";
            MODIFY;
          END;
          "Approval Status"::"Approval Pending": BEGIN
            CConfigProgressBar.Init(1,0,Text5000);
            IF USERID <> "Approval Area User" THEN
              ERROR(ErrorUser);
            //Comprobamos si hay algún usurio con el check "Creación factura de compra" marcado en la configuración de usuarios
            UserSetup.RESET;
            UserSetup.SETRANGE("Create Purchase Invoice", TRUE);
            IF NOT UserSetup.FINDFIRST THEN
              ERROR(ErrorUserApp);
        
            //>Z004  04  CIMUBISA-08 BGS 2018.02.08
            fSignDocument("DOCUMENTO PDF");
            //<Z004  04  CIMUBISA-08 BGS 2018.02.08
        
            "Approval Status" := "Approval Status"::Approved;
            "Approval Area Date" := TODAY;
            MODIFY;
            CConfigProgressBar.Close;
          END;
          "Approval Status"::Approved: BEGIN
            ERROR(ErrorApp);
          END;
        END;
        */

    end;

    local procedure CheckPurchaseNeedInLines()
    var
        LineasFacturaERecibida: Record "50008";
    begin
        //Z035 - JLF - 19/07/19: Inicio
        /*
        LineasFacturaERecibida.RESET;
        LineasFacturaERecibida.SETRANGE("ID Factura", ID_PLATAFORMA);
        IF LineasFacturaERecibida.FINDSET THEN REPEAT
          LineasFacturaERecibida.TESTFIELD("Purchase Need No.");
          LineasFacturaERecibida.TESTFIELD("Purchase Need Line No.");
        UNTIL LineasFacturaERecibida.NEXT = 0;
        */
        //Z035 - JLF - 19/07/19: Fin

    end;

    [Scope('Internal')]
    procedure fSignDocument(pURLDocument: Text)
    var
        tlRecordLink: Record "2000000068";
        vlServerFileName: Text;
        vlClientFileName: Text;
        clSubscribedEvents: Codeunit "50002";
        clFileMgt: Codeunit "419";
        vlNewAlfrescoURL: Text;
        tlPurchSetup: Record "312";
    begin
        /*
        //>Z004  04  CIMUBISA-08 BGS 2018.02.08
        
        //Conf. compras
        CLEAR(tlPurchSetup);
        tlPurchSetup.GET;
        
        //Creamos el Link
        //ADDLINK(vlServerFileName,FORMAT(RECORDID));
        //CLEAR(tlRecordLink);
        //tlRecordLink.SETRANGE("Record ID",Rec.RECORDID);
        //tlRecordLink.FINDLAST;
        
        //Descargamos el fichero
        CLEAR(vlServerFileName);
        vlServerFileName := tlRecordLink.DownloadRecordLinkUniqueAlfresco(tlPurchSetup."URL SW municipales Alfresco",
                                                                          tlPurchSetup."ID Carpeta Alfresco e-Facturas",
                                                                          clFileMgt.GetFileName(pURLDocument),
                                                                          fGetURLToOpen(pURLDocument));
        
        //Creamos el Link
        ADDLINK(vlServerFileName,fGetSignedText + FORMAT(RECORDID));
        CLEAR(tlRecordLink);
        tlRecordLink.SETRANGE("Record ID",Rec.RECORDID);
        tlRecordLink.FINDLAST;
        
        //Lo firmamos
        clSubscribedEvents.GetUserSetup(USERID);
        clSubscribedEvents.SetSignPosAndSizeParameters(60,60,445,48);
        clSubscribedEvents.SetSignTextParameters(575,110,485,110,8);
        clSubscribedEvents.SetAvoidCarReturn(TRUE);
        clSubscribedEvents.SignDocument(vlServerFileName);
        
        //Lo subimos
        tlRecordLink.SetDirectory(tlPurchSetup."ID Carp. Alfresco e-Fact. firm");
        tlRecordLink.SetModifyRecordLink(TRUE);
        tlRecordLink.UploadRecordLinkAlfresco(tlPurchSetup."URL SW municipales Alfresco",
                                              tlPurchSetup."ID Carp. Alfresco e-Fact. firm",
                                              tlPurchSetup."Usuario Alfresco eFactura",
                                              tlPurchSetup."Contraseña Alfresco eFactura",
                                              vlServerFileName);
        
        //<Z004  04  CIMUBISA-08 BGS 2018.02.08
        */

    end;

    [Scope('Internal')]
    procedure fGetURLToOpen(pFichero: Text): Text
    var
        rlPurchasesPayablesSetup: Record "312";
        tlRecordLink: Record "2000000068";
    begin
        CLEAR(rlPurchasesPayablesSetup);
        rlPurchasesPayablesSetup.GET;

        IF STRPOS(pFichero,'app:') = 0 THEN
          EXIT(rlPurchasesPayablesSetup."Ruta raíz Alfresco" +
               'download/direct?path=/company_home' + fQuitarCodigoRuta(pFichero) +
               '&ticket=' +  tlRecordLink.fGetTicketAlfresco(rlPurchasesPayablesSetup."Ruta WS Ticket Alfresco",
                                                             rlPurchasesPayablesSetup."Usuario Alfresco",
                                                             rlPurchasesPayablesSetup."Contraseña Alfresco"))
        ELSE
          EXIT(rlPurchasesPayablesSetup."Ruta raíz Alfresco" +
               'download/direct?path=' + fQuitarCodigoRuta(pFichero) +
               '&ticket=' +  tlRecordLink.fGetTicketAlfresco(rlPurchasesPayablesSetup."Ruta WS Ticket Alfresco",
                                                             rlPurchasesPayablesSetup."Usuario Alfresco",
                                                             rlPurchasesPayablesSetup."Contraseña Alfresco"));
    end;

    [Scope('Internal')]
    procedure fGetURLToNavigate(pFichero: Text): Text
    var
        rlPurchasesPayablesSetup: Record "312";
        tlRecordLink: Record "2000000068";
    begin
        CLEAR(rlPurchasesPayablesSetup);
        rlPurchasesPayablesSetup.GET;
        EXIT(rlPurchasesPayablesSetup."Ruta raíz Alfresco" +
              'navigate/browse/webdav' + fQuitarCodigoRutaAdjuntos(pFichero,FALSE) +
              '?ticket=' +  tlRecordLink.fGetTicketAlfresco(rlPurchasesPayablesSetup."Ruta WS Ticket Alfresco",
                                                            rlPurchasesPayablesSetup."Usuario Alfresco",
                                                            rlPurchasesPayablesSetup."Contraseña Alfresco"))
    end;

    [Scope('Internal')]
    procedure fOpenSignedPDFDocument()
    var
        tlRecordLink: Record "2000000068";
        tlPurchSetup: Record "312";
        clFileManagement: Codeunit "419";
        vlServerFileName: Text;
        vlClientFileName: Text;
    begin
        /*
        //<Z004  04  CIMUBISA-08 BGS 2018.02.08
        //Conf. compras y pagos
        CLEAR(tlPurchSetup);
        tlPurchSetup.GET;
        
        //Descargamos al servidor
        CLEAR(vlServerFileName);
        vlServerFileName := tlRecordLink.DownloadRecordLinkUniqueAlfresco(tlPurchSetup."URL SW municipales Alfresco",tlPurchSetup."ID Carp. Alfresco e-Fact. firm",clFileManagement.GetFileName("DOCUMENTO PDF"),'');
        
        //Descargamos al cliente
        CLEAR(vlClientFileName);
        vlClientFileName := clFileManagement.DownloadTempFile(vlServerFileName);
        
        //Abrimos
        HYPERLINK(vlClientFileName);
        //>Z004  04  CIMUBISA-08 BGS 2018.02.08
        */

    end;

    [Scope('Internal')]
    procedure fGetSignedText(): Text
    begin
        //<Z004  04  CIMUBISA-08 BGS 2018.02.08
        EXIT(Text50001);
        //>Z004  04  CIMUBISA-08 BGS 2018.02.08
    end;

    local procedure "************lo que estaba en la pagina"()
    begin
    end;

    [Scope('Internal')]
    procedure fRegistrar(pFactura: Record "50007";pRegistrar: Boolean)
    var
        rlPurchaseHeader: Record "38";
        rlPurchaseLine: Record "39";
        rlVendor: Record "23";
        rlLineasFacturaERecibida: Record "50008";
        rlTasasyRetencionesFacturaE: Record "50009";
        lText50000: Label 'Esta factura ya está registrada.';
        lText50001: Label 'Proceso cancelado por el usuario.';
        lText50002: Label '¿Desea registrar esta factura?';
        rlTasasyRetencionesFacturaERet: Record "50009";
        rlPurchInvHeader: Record "122";
        lText50003: Label 'Esta factura ya está cargada como factura en curso.';
        lText50004: Label '¿Desea generar esta factura?';
        rlPurchCommentLine: Record "43";
        vlLinea: Integer;
        rlCabeceraContratacion: Record "50002";
        rlLineasContratacion: Record "50003";
        vlCodigoContratacion: Code[20];
        vlLineaContratacion: Integer;
        vlLimpiar: Boolean;
        lText50005: Label 'El CIF del proveedor elegido es distinto al original\\¿Desea continuar?';
        lText50006: Label 'Esta factura está rechazada, no se puede registrar.';
        "****PARA LOS TOTALES": Text;
        DocumentTotals: Codeunit "57";
        TotalPurchaseHeader: Record "38";
        TotalPurchaseLine: Record "39";
        VATAmount: Decimal;
        InvDiscAmountEditable: Boolean;
        TotalAmountStyle: Text;
        RefreshMessageEnabled: Boolean;
        RefreshMessageText: Text;
        lText50007: Label 'El importe del documento creado no coincide con la e-factura importe iva incluido';
        ExpAdjudicacion: Record "50001";
        ApprovalsMgmt: Codeunit "1535";
    begin
        //Genera y registra la factura de compra correspondiente.
        //Comprueba si está registrada
        IF Registrada THEN
           ERROR(lText50000);
        
        IF Rechazada THEN
           ERROR(lText50006);
        
        /*
        //>IPP Z004      CIMUBISA-08 IPP 2018.01.26 Gestión de FacturaE
        TESTFIELD("Approval Status", "Approval Status"::Approved);
        //<IPP Z004      CIMUBISA-08 IPP 2018.01.26 Gestión de FacturaE
        */
        
        CLEAR(rlPurchInvHeader);
        rlPurchInvHeader.SETRANGE("ID Plataforma FacturaE",pFactura.ID_PLATAFORMA);
        rlPurchInvHeader.SETRANGE("Numero FacturaE",pFactura.NUM);
        IF rlPurchInvHeader.FINDFIRST THEN
           ERROR(lText50000);
        
        CLEAR(rlPurchaseHeader);
        //rlPurchaseHeader.SETRANGE("Document Type",rlPurchaseHeader."Document Type"::Invoice);
        rlPurchaseHeader.SETFILTER("Document Type",'%1|%2',rlPurchaseHeader."Document Type"::Invoice
                                              ,rlPurchaseHeader."Document Type"::"Credit Memo");
        rlPurchaseHeader.SETRANGE("ID Plataforma FacturaE",pFactura.ID_PLATAFORMA);
        rlPurchaseHeader.SETRANGE("Numero FacturaE",pFactura.NUM);
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
        
        CALCFIELDS("CIF Proveedor");
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
           rlPurchaseHeader.VALIDATE("Document Type",rlPurchaseHeader."Document Type"::Invoice)
        ELSE
           rlPurchaseHeader.VALIDATE("Document Type",rlPurchaseHeader."Document Type"::"Credit Memo");
        rlPurchaseHeader.INSERT(TRUE);
        /*
        CLEAR(rlVendor);
        rlVendor.SETRANGE("VAT Registration No.",pFactura.EMISOR_CIF);
        rlVendor.FINDFIRST;
        */
        TESTFIELD("Proveedor NAV");
        rlPurchaseHeader.VALIDATE("Buy-from Vendor No.","Proveedor NAV");
        //I00218 Mod. S2G (EGR) 07-07-15: Completar Nº abono proveedor cuando lo que se genera es un abono.
        IF pFactura.TOTAL_PAGAR > 0 THEN
        //I00218 Mod. S2G (EGR) 07-07-15: Fin.
        rlPurchaseHeader.VALIDATE("Vendor Invoice No.",pFactura.NUM)
        //I00218 Mod. S2G (EGR) 07-07-15: Completar Nº abono proveedor cuando lo que se genera es un abono.
        ELSE
         rlPurchaseHeader.VALIDATE("Vendor Cr. Memo No.",pFactura.NUM);
        //I00218 Mod. S2G (EGR) 07-07-15: Fin.
        rlPurchaseHeader.VALIDATE("ID Plataforma FacturaE",pFactura.ID_PLATAFORMA);
        rlPurchaseHeader.VALIDATE("Numero FacturaE",pFactura.NUM);
        rlPurchaseHeader.VALIDATE("Document Date",pFactura.FECHA_DEVENGO);
        
        //I00103 Mod. S2G (MGL) 22-10-14: Incluir Fecha recepción documento
        rlPurchaseHeader.VALIDATE("Fecha recepcion documento",pFactura.FECHA_ENTRADA);
        //I00103 Mod. S2G (MGL) 22-10-14: Fin
        
        //I00253 Mod. S2G (APL) 01-02-16: Completar Fecha registro con Fecha entrada.
        rlPurchaseHeader.VALIDATE("Posting Date",pFactura.FECHA_ENTRADA);
        //I00253 Mod. S2G (APL) 01-02-16: Fin.
        
        //Z035 - JLF - 19/07/19: Inicio
        CLEAR(ExpAdjudicacion);
        IF ExpAdjudicacion.GET(ExpAdjudicacion."Tipo Contratación"::Compras,pFactura.EXPEDIENTE) THEN BEGIN
          rlPurchaseHeader.VALIDATE("Aprobador 1",ExpAdjudicacion."Aprobador 1");
          rlPurchaseHeader.VALIDATE("Aprobador 2",ExpAdjudicacion."Aprobador 2");
          rlPurchaseHeader.VALIDATE("Aprobador 3",ExpAdjudicacion."Aprobador 3");
          rlPurchaseHeader.VALIDATE("Aprobador 4",ExpAdjudicacion."Aprobador 4");
        END;
        rlPurchaseHeader."No. expediente adjudicacion":=pFactura.EXPEDIENTE;
        rlPurchaseHeader.Lote:=pFactura.Lote;
        //Z035 - JLF - 19/07/19: Fin
        
        //Z035 INICIO JRB 05/05/2020 Pasar dimensiones a factura generada
        rlPurchaseHeader.VALIDATE("Dimension Set ID",pFactura."Dimension Set ID");
        rlPurchaseHeader.VALIDATE("Shortcut Dimension 1 Code",pFactura."Shortcut Dimension 1 Code");
        rlPurchaseHeader.VALIDATE("Shortcut Dimension 2 Code",pFactura."Shortcut Dimension 2 Code");
        //Z035 FIN JRB 05/05/2020 Pasar dimensiones a factura generada
        
        rlPurchaseHeader.MODIFY(TRUE);
        /*
        IF pFactura."DOCUMENTACIÓN ADJUNTA" <> '' THEN
           rlPurchaseHeader.ADDLINK(pFactura."DOCUMENTACIÓN ADJUNTA");
        IF pFactura."DOCUMENTO PDF" <> '' THEN
           rlPurchaseHeader.ADDLINK(pFactura."DOCUMENTO PDF");
        IF pFactura."DOCUMENTO FACTURA" <> '' THEN
           rlPurchaseHeader.ADDLINK(pFactura."DOCUMENTO FACTURA");
        */
        fCopiarDocumentosAlfresco(Rec,rlPurchaseHeader);
        
        //Rellena los datos de línea.
        vlLinea := 10000;
        vlLimpiar := FALSE;
        CLEAR(rlLineasFacturaERecibida);
        rlLineasFacturaERecibida.SETRANGE("ID Factura",pFactura.ID_PLATAFORMA);
        IF rlLineasFacturaERecibida.FINDSET THEN REPEAT
           rlLineasFacturaERecibida.CALCFIELDS(Tasas,Retenciones);
           //I00124 Mod. S2G (MGL) 07-11-14: No validar líneas sin cantidad, precio e importe.
           IF (rlLineasFacturaERecibida.CANTIDAD <> 0) AND (rlLineasFacturaERecibida.PRECIO <> 0) THEN
           //I00124 Mod. S2G (MGL) 07-11-14: Fin.
              rlLineasFacturaERecibida.TESTFIELD("Cuenta NAV");
           //aoc
           IF (COPYSTR(rlLineasFacturaERecibida."Cuenta NAV",1,1) = '2') AND (rlLineasFacturaERecibida."Cod Activo" = '') THEN
             ERROR(vText50005);
           //fin aoc
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
            rlPurchaseLine.VALIDATE(Type,rlPurchaseLine.Type::"Fixed Asset");
            rlPurchaseLine.VALIDATE("No.",rlLineasFacturaERecibida."Cod Activo");
           END ELSE BEGIN
           //I00109 Mod. S2G (JSM) 22-10-14: Fin.
            //I00124 Mod. S2G (MGL) 07-11-14: No validar líneas sin cantidad, precio e importe.
            IF (rlLineasFacturaERecibida.CANTIDAD <> 0) AND (rlLineasFacturaERecibida.PRECIO <> 0) THEN BEGIN
            //I00124 Mod. S2G (MGL) 07-11-14: Fin.
              rlPurchaseLine.VALIDATE(Type,rlPurchaseLine.Type::"G/L Account");
              rlPurchaseLine.VALIDATE("No.",rlLineasFacturaERecibida."Cuenta NAV");
            //I00124 Mod. S2G (MGL) 07-11-14: No validar líneas sin cantidad, precio e importe.
            END;
            //I00124 Mod. S2G (MGL) 07-11-14: Fin.
           END;
        
           rlPurchaseLine.VALIDATE(Description,COPYSTR(rlLineasFacturaERecibida.DESCRIPCION,1,50));
           rlPurchaseLine.VALIDATE("Description 2",COPYSTR(rlLineasFacturaERecibida.DESCRIPCION,51,50));
           //I00124 Mod. S2G (MGL) 07-11-14: No validar líneas sin cantidad, precio e importe.
           IF (rlLineasFacturaERecibida.CANTIDAD <> 0) THEN
           //I00124 Mod. S2G (MGL) 07-11-14: Fin.
              IF rlPurchaseHeader."Document Type" = rlPurchaseHeader."Document Type"::Invoice THEN
                 rlPurchaseLine.VALIDATE(Quantity,rlLineasFacturaERecibida.CANTIDAD)
              ELSE
                 rlPurchaseLine.VALIDATE(Quantity,- rlLineasFacturaERecibida.CANTIDAD);
        //   rlPurchaseLine.VALIDATE("Direct Unit Cost",rlLineasFacturaERecibida.PRECIO);
        //   rlPurchaseLine.VALIDATE("Amount",(rlLineasFacturaERecibida.CANTIDAD * rlLineasFacturaERecibida.PRECIO) *
        //                                  (1+ (rlLineasFacturaERecibida.Tasas / 100)));
           //I00124 Mod. S2G (MGL) 07-11-14: No validar líneas sin cantidad, precio e importe.
           IF (rlLineasFacturaERecibida.PRECIO <> 0) THEN
           //I00124 Mod. S2G (MGL) 07-11-14: Fin.
              //INICIO JRB 18-03-2020 Aplicar el PRECIO sin IVA
              //rlPurchaseLine.VALIDATE("Direct Unit Cost",(rlLineasFacturaERecibida.PRECIO) *
              //                               (1+ (rlLineasFacturaERecibida.Tasas / 100)));
              rlPurchaseLine.VALIDATE("Direct Unit Cost",rlLineasFacturaERecibida.PRECIO);
              //FIN JRB 18-03-2020 Aplicar el PRECIO sin IVA
           //I00124 Mod. S2G (MGL) 07-11-14: No validar líneas sin cantidad, precio e importe.
           IF (rlLineasFacturaERecibida.DESCUENTO <> 0) THEN
           //I00124 Mod. S2G (MGL) 07-11-14: Fin.
           //I00235 Mod. S2G (EGR) 06-10-15: Pasar el descuento con IVA.
           //   rlPurchaseLine.VALIDATE("Line Discount Amount",rlLineasFacturaERecibida.DESCUENTO);
              rlPurchaseLine.VALIDATE("Line Discount Amount",(rlLineasFacturaERecibida.DESCUENTO) *
                                             (1+ (rlLineasFacturaERecibida.Tasas / 100)));
           //I00235 Mod. S2G (EGR) 06-10-15: Pasar el descuento con IVA. FIN
        
           //INICIO JRB 18-03-2020 Aplicar el PRECIO sin IVA
           //AOC; 27/11/18; COMO EN EFACTURA AHORA SE CORRIGE EL IMPORTE CON IVA HAY QUE ENVIAR ESTE CAMPO
           //IF rlPurchaseLine."Amount Including VAT" <> rlLineasFacturaERecibida."Amount Including VAT" THEN
             //rlPurchaseLine.VALIDATE(rlPurchaseLine."Line Amount" ,rlLineasFacturaERecibida."Amount Including VAT");
           //FIN JRB 18-03-2020 Aplicar el PRECIO sin IVA
        
           rlPurchaseLine.VALIDATE("ID Plataforma FacturaE",rlPurchaseHeader."ID Plataforma FacturaE");
           rlPurchaseLine.VALIDATE("Numero FacturaE",rlPurchaseHeader."Numero FacturaE");
           rlPurchaseLine.VALIDATE("Linea FacturaE",rlLineasFacturaERecibida.Linea);
        
           //Z035 - JLF - 19/07/19: Inicio
           rlPurchaseLine."No. expediente adjudicacion":=rlPurchaseHeader."No. expediente adjudicacion";
           rlPurchaseLine.Lote:=rlPurchaseHeader.Lote;
           //Z035 - JLF - 19/07/19: Fin
        
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
           rlTasasyRetencionesFacturaE.SETRANGE("ID Factura",rlLineasFacturaERecibida."ID Factura");
           rlTasasyRetencionesFacturaE.SETRANGE(Linea,rlLineasFacturaERecibida.Linea);
           rlTasasyRetencionesFacturaE.SETFILTER(TASA,'<>%1',0);
           IF (rlTasasyRetencionesFacturaE.COUNT <= 1) THEN BEGIN
              //I00124 Mod. S2G (MGL) 07-11-14: No validar líneas sin cantidad, precio e importe.
              IF (rlLineasFacturaERecibida.PRECIO <> 0) THEN BEGIN
              //I00124 Mod. S2G (MGL) 07-11-14: Fin.
                 rlLineasFacturaERecibida.TESTFIELD("Código IVA NAV");
                 rlPurchaseLine.VALIDATE("VAT Prod. Posting Group",rlLineasFacturaERecibida."Código IVA NAV");
                 //INICIO JRB 18/03/2020 COMENTADO PARA LLEVAR CORRECTAMENTE LOS IMPORTES
                 //rlPurchaseLine.VALIDATE("Direct Unit Cost",(rlLineasFacturaERecibida.PRECIO) *
                 //                            (1+ (rlLineasFacturaERecibida.Tasas / 100)));
                 rlPurchaseLine.VALIDATE("Direct Unit Cost",rlLineasFacturaERecibida.PRECIO);
                 //INICIO JRB 18/03/2020 COMENTADO PARA LLEVAR CORRECTAMENTE LOS IMPORTES
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
                 //AOC; 27/11/18; COMO EN EFACTURA AHORA SE CORRIGE EL IMPORTE CON IVA HAY QUE ENVIAR ESTE CAMPO
                IF rlPurchaseLine."Amount Including VAT" <> rlLineasFacturaERecibida."Amount Including VAT" THEN
                  rlPurchaseLine.VALIDATE(rlPurchaseLine."Line Amount" ,rlLineasFacturaERecibida."Amount Including VAT");
                 rlPurchaseLine.VALIDATE("Purchase Need No.",rlLineasFacturaERecibida."Purchase Need No.");
                 rlPurchaseLine.VALIDATE("Purchase Need Line No.",rlLineasFacturaERecibida."Purchase Need Line No.");
                 {
                 //meter las dimensiones
                 IF TPurchaseNeedLineL.GET(rlLineasFacturaERecibida."Purchase Need No.",rlLineasFacturaERecibida."Purchase Need Line No.") THEN BEGIN
                   rlPurchaseLine.VALIDATE("Shortcut Dimension 1 Code",TPurchaseNeedLineL."Shortcut Dimension 1 Code");
                   rlPurchaseLine.VALIDATE("Shortcut Dimension 2 Code",TPurchaseNeedLineL."Shortcut Dimension 2 Code");
                   rlPurchaseLine."Dimension Set ID":= TPurchaseNeedLineL."Dimension Set ID";
                 END;
                 //***ZAM0004; AOC; 13/02/18; fin
                 }
                 */
              //I00124 Mod. S2G (MGL) 07-11-14: No validar líneas sin cantidad, precio e importe.
              END;
              //I00124 Mod. S2G (MGL) 07-11-14: Fin.
              fCrearModificar(rlLineasFacturaERecibida,rlPurchaseHeader,rlPurchaseLine,vlLinea);
        
              CLEAR(rlTasasyRetencionesFacturaERet);
              rlTasasyRetencionesFacturaERet.SETRANGE("ID Factura",rlLineasFacturaERecibida."ID Factura");
              rlTasasyRetencionesFacturaERet.SETRANGE(Linea,rlLineasFacturaERecibida.Linea);
              rlTasasyRetencionesFacturaERet.SETFILTER(RETENCION,'<>%1',0);
              IF (rlTasasyRetencionesFacturaERet.COUNT <= 1) THEN BEGIN
                 IF (rlTasasyRetencionesFacturaERet.COUNT = 1) THEN
                   //I00124 Mod. S2G (MGL) 07-11-14: No validar líneas sin cantidad, precio e importe.
                   IF (rlLineasFacturaERecibida.PRECIO <> 0) THEN BEGIN
                   //I00124 Mod. S2G (MGL) 07-11-14: Fin.
                       rlLineasFacturaERecibida.TESTFIELD("Código IRPF NAV");
                       IF rlLineasFacturaERecibida."Código IRPF NAV" <> '' THEN BEGIN
                          rlPurchaseLine.VALIDATE("No.",rlLineasFacturaERecibida."Cuenta NAV");
                          rlPurchaseLine.VALIDATE(Description,'Retención ' + rlLineasFacturaERecibida.DESCRIPCION);
                          //INICIO JRB 18/03/2020 COMENTADO PARA LLEVAR CORRECTAMENTE LOS IMPORTES
                          //rlPurchaseLine.VALIDATE("Direct Unit Cost",(rlLineasFacturaERecibida.PRECIO) *
                          //                            (1+ (rlLineasFacturaERecibida.Tasas / 100)));
                          rlPurchaseLine.VALIDATE("Direct Unit Cost",rlLineasFacturaERecibida.PRECIO);
                          //FIN JRB 18/03/2020 COMENTADO PARA LLEVAR CORRECTAMENTE LOS IMPORTES
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
                          //AOC; 27/11/18; COMO EN EFACTURA AHORA SE CORRIGE EL IMPORTE CON IVA HAY QUE ENVIAR ESTE CAMPO
                          IF rlPurchaseLine."Amount Including VAT" <> rlLineasFacturaERecibida."Amount Including VAT" THEN
                            rlPurchaseLine.VALIDATE(rlPurchaseLine."Line Amount" ,rlLineasFacturaERecibida."Amount Including VAT");
                          rlPurchaseLine.VALIDATE("Purchase Need No.",rlLineasFacturaERecibida."Purchase Need No.");
                          rlPurchaseLine.VALIDATE("Purchase Need Line No.",rlLineasFacturaERecibida."Purchase Need Line No.");
                          //meter las dimensiones
                          IF TPurchaseNeedLineL.GET(rlLineasFacturaERecibida."Purchase Need No.",rlLineasFacturaERecibida."Purchase Need Line No.") THEN BEGIN
                            rlPurchaseLine.VALIDATE("Shortcut Dimension 1 Code",TPurchaseNeedLineL."Shortcut Dimension 1 Code");
                            rlPurchaseLine.VALIDATE("Shortcut Dimension 2 Code",TPurchaseNeedLineL."Shortcut Dimension 2 Code");
                            rlPurchaseLine."Dimension Set ID":= TPurchaseNeedLineL."Dimension Set ID";
                          END;
                          //***ZAM0004; AOC; 13/02/18; fin
                          */
        
                       fCrearModificar(rlLineasFacturaERecibida,rlPurchaseHeader,rlPurchaseLine,vlLinea);
                       END;
                   //I00124 Mod. S2G (MGL) 07-11-14: No validar líneas sin cantidad, precio e importe.
                   END;
                   //I00124 Mod. S2G (MGL) 07-11-14: Fin.
              END
              ELSE
                 IF rlTasasyRetencionesFacturaERet.FINDSET THEN REPEAT
                    //I00124 Mod. S2G (MGL) 07-11-14: No validar líneas sin cantidad, precio e importe.
                    IF (rlLineasFacturaERecibida.PRECIO <> 0) THEN BEGIN
                    //I00124 Mod. S2G (MGL) 07-11-14: Fin.
                       rlTasasyRetencionesFacturaERet.TESTFIELD("Código IRPF NAV");
        //             rlPurchaseLine.VALIDATE("Codigo retencion IRPF",rlTasasyRetencionesFacturaERet."Código IRPF NAV");
                       rlPurchaseLine.VALIDATE("No.",rlLineasFacturaERecibida."Cuenta NAV");
                       rlPurchaseLine.VALIDATE(Description,'Retención ' + rlLineasFacturaERecibida.DESCRIPCION);
                       rlPurchaseLine.VALIDATE("Direct Unit Cost",-(rlLineasFacturaERecibida.PRECIO) *
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
                        //AOC; 27/11/18; COMO EN EFACTURA AHORA SE CORRIGE EL IMPORTE CON IVA HAY QUE ENVIAR ESTE CAMPO
                        IF rlPurchaseLine."Amount Including VAT" <> rlLineasFacturaERecibida."Amount Including VAT" THEN
                          rlPurchaseLine.VALIDATE(rlPurchaseLine."Line Amount" ,rlLineasFacturaERecibida."Amount Including VAT");
                        rlPurchaseLine.VALIDATE("Purchase Need No.",rlLineasFacturaERecibida."Purchase Need No.");
                        rlPurchaseLine.VALIDATE("Purchase Need Line No.",rlLineasFacturaERecibida."Purchase Need Line No.");
                        //meter las dimensiones
                        IF TPurchaseNeedLineL.GET(rlLineasFacturaERecibida."Purchase Need No.",rlLineasFacturaERecibida."Purchase Need Line No.") THEN BEGIN
                          rlPurchaseLine.VALIDATE("Shortcut Dimension 1 Code",TPurchaseNeedLineL."Shortcut Dimension 1 Code");
                          rlPurchaseLine.VALIDATE("Shortcut Dimension 2 Code",TPurchaseNeedLineL."Shortcut Dimension 2 Code");
                          rlPurchaseLine."Dimension Set ID":= TPurchaseNeedLineL."Dimension Set ID";
                        END;
                        //***ZAM0004; AOC; 13/02/18; fin
                        */
        
                    //I00124 Mod. S2G (MGL) 07-11-14: No validar líneas sin cantidad, precio e importe.
                    END;
                    //I00124 Mod. S2G (MGL) 07-11-14: Fin.
                    fCrearModificar(rlLineasFacturaERecibida,rlPurchaseHeader,rlPurchaseLine,vlLinea);
                 UNTIL rlTasasyRetencionesFacturaERet.NEXT = 0;
           END
           ELSE
              IF rlTasasyRetencionesFacturaE.FINDSET THEN REPEAT
                 rlTasasyRetencionesFacturaE.TESTFIELD("Código IVA NAV");
                 rlPurchaseLine.VALIDATE("VAT Prod. Posting Group",rlTasasyRetencionesFacturaE."Código IVA NAV");
                 fCrearModificar(rlLineasFacturaERecibida,rlPurchaseHeader,rlPurchaseLine,vlLinea);
                 CLEAR(rlTasasyRetencionesFacturaERet);
                 rlTasasyRetencionesFacturaERet.SETRANGE("ID Factura",rlLineasFacturaERecibida."ID Factura");
                 rlTasasyRetencionesFacturaERet.SETRANGE(Linea,rlLineasFacturaERecibida.Linea);
                 rlTasasyRetencionesFacturaERet.SETFILTER(RETENCION,'<>%1',0);
                 IF (rlTasasyRetencionesFacturaERet.COUNT <= 1) THEN BEGIN
                    IF (rlTasasyRetencionesFacturaERet.COUNT = 1) THEN
                       rlLineasFacturaERecibida.TESTFIELD("Código IRPF NAV");
                    IF rlLineasFacturaERecibida."Código IRPF NAV" <> '' THEN BEGIN
                       rlPurchaseLine.VALIDATE("No.",rlLineasFacturaERecibida."Cuenta NAV");
                       rlPurchaseLine.VALIDATE(Description,'Retención ' + rlLineasFacturaERecibida.DESCRIPCION);
                       //I00124 Mod. S2G (MGL) 07-11-14: No validar líneas sin cantidad, precio e importe.
                       IF (rlLineasFacturaERecibida.PRECIO <> 0) THEN
                       //I00124 Mod. S2G (MGL) 07-11-14: Fin.
                          rlPurchaseLine.VALIDATE("Direct Unit Cost",-(rlLineasFacturaERecibida.PRECIO) *
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
                       //AOC; 27/11/18; COMO EN EFACTURA AHORA SE CORRIGE EL IMPORTE CON IVA HAY QUE ENVIAR ESTE CAMPO
                       IF rlPurchaseLine."Amount Including VAT" <> rlLineasFacturaERecibida."Amount Including VAT" THEN
                         rlPurchaseLine.VALIDATE(rlPurchaseLine."Line Amount" ,rlLineasFacturaERecibida."Amount Including VAT");
                       rlPurchaseLine.VALIDATE("Purchase Need No.",rlLineasFacturaERecibida."Purchase Need No.");
                       rlPurchaseLine.VALIDATE("Purchase Need Line No.",rlLineasFacturaERecibida."Purchase Need Line No.");
                       //meter las dimensiones
                       IF TPurchaseNeedLineL.GET(rlLineasFacturaERecibida."Purchase Need No.",rlLineasFacturaERecibida."Purchase Need Line No.") THEN BEGIN
                         rlPurchaseLine.VALIDATE("Shortcut Dimension 1 Code",TPurchaseNeedLineL."Shortcut Dimension 1 Code");
                         rlPurchaseLine.VALIDATE("Shortcut Dimension 2 Code",TPurchaseNeedLineL."Shortcut Dimension 2 Code");
                         rlPurchaseLine."Dimension Set ID":= TPurchaseNeedLineL."Dimension Set ID";
                       END;
                       //***ZAM0004; AOC; 13/02/18; fin
                       */
                       fCrearModificar(rlLineasFacturaERecibida,rlPurchaseHeader,rlPurchaseLine,vlLinea);
                    END;
                 END
                 ELSE
                    IF rlTasasyRetencionesFacturaERet.FINDSET THEN REPEAT
                       rlTasasyRetencionesFacturaERet.TESTFIELD("Código IRPF NAV");
                       rlPurchaseLine.VALIDATE("No.",rlLineasFacturaERecibida."Cuenta NAV");
                       rlPurchaseLine.VALIDATE(Description,'Retención ' + rlLineasFacturaERecibida.DESCRIPCION);
                       //I00124 Mod. S2G (MGL) 07-11-14: No validar líneas sin cantidad, precio e importe.
                       IF (rlLineasFacturaERecibida.PRECIO <> 0) THEN
                       //I00124 Mod. S2G (MGL) 07-11-14: Fin.
                          rlPurchaseLine.VALIDATE("Direct Unit Cost",-(rlLineasFacturaERecibida.PRECIO) *
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
                       //AOC; 27/11/18; COMO EN EFACTURA AHORA SE CORRIGE EL IMPORTE CON IVA HAY QUE ENVIAR ESTE CAMPO
                       IF rlPurchaseLine."Amount Including VAT" <> rlLineasFacturaERecibida."Amount Including VAT" THEN
                         rlPurchaseLine.VALIDATE(rlPurchaseLine."Line Amount" ,rlLineasFacturaERecibida."Amount Including VAT");
                       rlPurchaseLine.VALIDATE("Purchase Need No.",rlLineasFacturaERecibida."Purchase Need No.");
                       rlPurchaseLine.VALIDATE("Purchase Need Line No.",rlLineasFacturaERecibida."Purchase Need Line No.");
                       //meter las dimensiones
                       IF TPurchaseNeedLineL.GET(rlLineasFacturaERecibida."Purchase Need No.",rlLineasFacturaERecibida."Purchase Need Line No.") THEN BEGIN
                         rlPurchaseLine.VALIDATE("Shortcut Dimension 1 Code",TPurchaseNeedLineL."Shortcut Dimension 1 Code");
                         rlPurchaseLine.VALIDATE("Shortcut Dimension 2 Code",TPurchaseNeedLineL."Shortcut Dimension 2 Code");
                         rlPurchaseLine."Dimension Set ID":= TPurchaseNeedLineL."Dimension Set ID";
                       END;
                       //***ZAM0004; AOC; 13/02/18; fin
                       */
        
                       fCrearModificar(rlLineasFacturaERecibida,rlPurchaseHeader,rlPurchaseLine,vlLinea);
                    UNTIL rlTasasyRetencionesFacturaERet.NEXT = 0;
              UNTIL rlTasasyRetencionesFacturaE.NEXT = 0;
           vlLimpiar := TRUE;
        UNTIL rlLineasFacturaERecibida.NEXT = 0;
        
        rlPurchaseLine.DELETE;
        
        //***ZAM0004; AOC; 13/02/18; Unir E-factura con necesidades
        //      COMPROBAR CON EL IMPORTE TOTAL CON EL DE E-FACTURA
        DocumentTotals.PurchaseUpdateTotalsControls(rlPurchaseLine,TotalPurchaseHeader,TotalPurchaseLine,RefreshMessageEnabled,
            TotalAmountStyle,RefreshMessageText,InvDiscAmountEditable,VATAmount);
        IF TOTAL_PAGAR >= 0 THEN BEGIN
          TotalPurchaseHeader.CALCFIELDS("Amount Including VAT");
          IF TotalPurchaseHeader."Amount Including VAT" <> TOTAL_PAGAR THEN
            MESSAGE(lText50007);
        END ELSE IF TotalPurchaseHeader."Amount Including VAT" <> -TOTAL_PAGAR THEN
          MESSAGE(lText50007);
        //***fin ZAM0004; AOC; 13/02/18;
        CLEAR(rlPurchCommentLine);
        rlPurchCommentLine.INIT;
        rlPurchCommentLine."Document Type" := rlPurchaseHeader."Document Type";
        rlPurchCommentLine."No." := rlPurchaseHeader."No.";
        rlPurchCommentLine."Document Line No." := 0;
        rlPurchCommentLine."Line No." := 10000;
        rlPurchCommentLine.Date := TODAY;
        rlPurchCommentLine.Comment := COPYSTR(pFactura.NOTAS,1,MAXSTRLEN(rlPurchCommentLine.Comment));
        rlPurchCommentLine.INSERT;
        IF STRLEN(pFactura.NOTAS) > 80 THEN BEGIN
           CLEAR(rlPurchCommentLine);
           rlPurchCommentLine.INIT;
           rlPurchCommentLine."Document Type" := rlPurchaseHeader."Document Type";
           rlPurchCommentLine."No." := rlPurchaseHeader."No.";
           rlPurchCommentLine."Document Line No." := 0;
           rlPurchCommentLine."Line No." := 20000;
           rlPurchCommentLine.Date := TODAY;
           rlPurchCommentLine.Comment := COPYSTR(pFactura.NOTAS,81,20);
           rlPurchCommentLine.INSERT;
        END;
        
        //Z035 - JLF - 19/07/19: Inicio
        IF (rlPurchaseHeader."Aprobador 1"='') AND (rlPurchaseHeader."Aprobador 2"='') AND (rlPurchaseHeader."Aprobador 3"='') AND (rlPurchaseHeader."Aprobador 4"='') THEN
          ERROR(Text50002);
        
        CLEAR(ApprovalsMgmt);
        IF ApprovalsMgmt.CheckPurchaseApprovalsWorkflowEnabled(rlPurchaseHeader) THEN
          ApprovalsMgmt.OnSendPurchaseDocForApproval(rlPurchaseHeader);
        
        IF rlPurchaseHeader.Status=rlPurchaseHeader.Status::"Pending Approval" THEN
          pFactura."Approval Status":=pFactura."Approval Status"::"Approval Pending"
        ELSE
          pFactura."Approval Status":=pFactura."Approval Status"::Approved;
        //pFactura.MODIFY;
        //Z035 - JLF - 19/07/19: Fin
        
        IF pRegistrar THEN BEGIN
           CODEUNIT.RUN(CODEUNIT::"Purch.-Post (Yes/No)",rlPurchaseHeader);
           Registrada := TRUE;
           MODIFY;
        END
        ELSE BEGIN
           MESSAGE(vText50000,rlPurchaseHeader."No.");
        END;

    end;

    [Scope('Internal')]
    procedure fCrearModificar(pLineasFacturaERecibida: Record "50008";pPurchaseHeader: Record "38";var pPurchaseLine: Record "39";var pLinea: Integer)
    begin
        pPurchaseLine.MODIFY(TRUE);

        pLinea += 10000;

        fPasarDescripciones(pLineasFacturaERecibida,pLinea,pPurchaseLine);

        pPurchaseLine.INIT;
        pPurchaseLine."Document Type" := pPurchaseHeader."Document Type";
        pPurchaseLine."Document No." := pPurchaseHeader."No.";
        pPurchaseLine."Line No." := pLinea;
        pPurchaseLine.INSERT(TRUE);

        pPurchaseLine."Buy-from Vendor No." := pPurchaseHeader."Buy-from Vendor No.";
        //I00109 Mod. S2G (JSM) 22-10-14: Permitir creación de líneas de activo fijo en Factura Elec.
        IF (pLineasFacturaERecibida."Cod Activo" <> '') THEN BEGIN
         pPurchaseLine.VALIDATE(Type,pPurchaseLine.Type::"Fixed Asset");
         pPurchaseLine.VALIDATE("No.",pLineasFacturaERecibida."Cod Activo");
        END ELSE BEGIN
        //I00109 Mod. S2G (JSM) 22-10-14: Fin.
           //I00124 Mod. S2G (MGL) 07-11-14: No validar líneas sin cantidad, precio e importe.
           IF (pLineasFacturaERecibida.CANTIDAD <> 0) AND (pLineasFacturaERecibida.PRECIO <> 0) THEN BEGIN
           //I00124 Mod. S2G (MGL) 07-11-14: Fin.
             pPurchaseLine.VALIDATE(Type,pPurchaseLine.Type::"G/L Account");
             pPurchaseLine.VALIDATE("No.",pLineasFacturaERecibida."Cuenta NAV");
           //I00124 Mod. S2G (MGL) 07-11-14: No validar líneas sin cantidad, precio e importe.
           END;
           //I00124 Mod. S2G (MGL) 07-11-14: Fin.
        END;
        pPurchaseLine.VALIDATE(Description,COPYSTR(pLineasFacturaERecibida.DESCRIPCION,1,50));
        pPurchaseLine.VALIDATE("Description 2",COPYSTR(pLineasFacturaERecibida.DESCRIPCION,51,50));
        //I00124 Mod. S2G (MGL) 07-11-14: No validar líneas sin cantidad, precio e importe.
        IF (pLineasFacturaERecibida.CANTIDAD <> 0) AND (pLineasFacturaERecibida.PRECIO <> 0) THEN BEGIN
        //I00124 Mod. S2G (MGL) 07-11-14: Fin.
           IF pPurchaseHeader."Document Type" = pPurchaseHeader."Document Type"::Invoice THEN
              pPurchaseLine.VALIDATE(Quantity,pLineasFacturaERecibida.CANTIDAD)
           ELSE
              pPurchaseLine.VALIDATE(Quantity,- pLineasFacturaERecibida.CANTIDAD);
           pPurchaseLine.VALIDATE("Direct Unit Cost",pLineasFacturaERecibida.PRECIO);
           pPurchaseLine.VALIDATE(Amount,(pLineasFacturaERecibida.CANTIDAD * pLineasFacturaERecibida.PRECIO) *
                                          (1+ (pLineasFacturaERecibida.Tasas / 100)));
        //I00124 Mod. S2G (MGL) 07-11-14: No validar líneas sin cantidad, precio e importe.
        END;
        IF (pLineasFacturaERecibida.DESCUENTO <> 0) THEN
        //I00124 Mod. S2G (MGL) 07-11-14: Fin.
        //I00235 Mod. S2G (EGR) 06-10-15: Pasar el descuento con IVA.
           //pPurchaseLine.VALIDATE("Line Discount Amount",pLineasFacturaERecibida.DESCUENTO);
            pPurchaseLine.VALIDATE("Line Discount Amount",(pLineasFacturaERecibida.DESCUENTO) *
                                             (1+ (pLineasFacturaERecibida.Tasas / 100)));
        //I00235 Mod. S2G (EGR) 06-10-15: Pasar el descuento con IVA. FIN

        //AOC; 27/11/18; COMO EN EFACTURA AHORA SE CORRIGE EL IMPORTE CON IVA HAY QUE ENVIAR ESTE CAMPO
        IF pPurchaseLine."Amount Including VAT" <> pLineasFacturaERecibida."Amount Including VAT" THEN
          pPurchaseLine.VALIDATE(pPurchaseLine."Line Amount" ,pLineasFacturaERecibida."Amount Including VAT");
        pPurchaseLine.VALIDATE("ID Plataforma FacturaE",pPurchaseHeader."ID Plataforma FacturaE");
        pPurchaseLine.VALIDATE("Numero FacturaE",pPurchaseHeader."Numero FacturaE");
        pPurchaseLine.VALIDATE("Linea FacturaE",pLineasFacturaERecibida.Linea);
    end;

    [Scope('Internal')]
    procedure fRechazarFacturaEPaso1()
    var
        clNotificationEntryDispatcher: Codeunit "1509";
        tlCabeceraFacturaERecibida: Record "50007";
    begin
        TESTFIELD(Rechazada,FALSE);

        CALCFIELDS("Documento en Curso","Documento Registrado");
        TESTFIELD("Documento en Curso",'');
        TESTFIELD("Documento Registrado",'');
        TESTFIELD("Motivo rechazo");
        IF NOT CONFIRM(vText50001) THEN
           ERROR(vText50002);
        Rechazada := TRUE;
        MODIFY;

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
        fRechazarFacturaE(Rec);


        MESSAGE(vText50003);
    end;

    [Scope('Internal')]
    procedure fRechazarFacturaE(pCabeceraFacturaERecibida: Record "50007")
    var
        locautXmlHttp: Automation ;
        locautXmlDoc: Automation ;
        vlRequestText: Text[1024];
        rlGeneralLedgerSetup: Record "98";
        vlFichero: File;
        vlTextSOAPBegin: Label '<?xml version="1.0" encoding="utf-8"?><soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/">';
        vlTextSOAPEnd: Label '</soapenv:Body></soapenv:Envelope>';
        vlTextSOAPBegin2: Label '<soapenv:Header /><soapenv:Body>';
        vlBigText: BigText;
        vlInStream: InStream;
        "vlContraseña": Text[1024];
        vlXMLDomNode: Automation ;
        rlPurchasesPayablesSetup: Record "312";
        XMLtxt: Text;
        vlTextSOAPBegin3: Label '<soapenv:Body>';
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
        
        /*
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
        */
        
        XMLtxt := vlTextSOAPBegin +vlTextSOAPBegin3 +
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
        locautXmlHttp.Open('POST',rlPurchasesPayablesSetup."URL Servicio Rechazo Facturae");
        //locautXmlHttp.SetCredentials(rlGeneralLedgerSetup."Usuario Synergy",vlContraseña,0);
        locautXmlHttp.SetRequestHeader('Content-Type','text/xml; charset=utf-8');
        locautXmlHttp.SetRequestHeader('SOAPAction', 'setDocumentStatus');
        
        //MESSAGE(FORMAT(locautXmlDoc.text));
        //MESSAGE(locautXmlDoc.xml);
        //MESSAGE(FORMAT(locautXmlDoc.xml));
        
        
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

    [Scope('Internal')]
    procedure fVerFacturaE(pCabeceraFacturaERecibida: Record "50007")
    var
        locautXmlHttp: Automation ;
        locautXmlDoc: Automation ;
        vlRequestText: Text[1024];
        rlGeneralLedgerSetup: Record "98";
        vlFichero: File;
        vlTextSOAPBegin: Label '<?xml version="1.0" encoding="utf-8"?> <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/">';
        vlTextSOAPEnd: Label '</soapenv:Body> </soapenv:Envelope>';
        vlTextSOAPBegin2: Label '<soapenv:Header /><soapenv:Body>';
        vlBigText: BigText;
        vlInStream: InStream;
        "vlContraseña": Text[1024];
        vlXMLDomNode: Automation ;
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
        CREATE(locautXmlDoc,FALSE,TRUE);
        CLEAR(locautXmlHttp);
        CREATE(locautXmlHttp,FALSE,TRUE);
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
        locautXmlHttp.Open('POST','http://pre.bilbokoudala.lan/aif/ws/DocumentFormattingServices');
        //locautXmlHttp.SetCredentials(rlGeneralLedgerSetup."Usuario Synergy",vlContraseña,0);
        locautXmlHttp.SetRequestHeader('Content-Type','text/xml; charset=utf-8');
        locautXmlHttp.SetRequestHeader('SOAPAction', 'getDocument');
        locautXmlHttp.Send(locautXmlDoc);
        
        //Guarda datos
        CLEAR(locautXmlDoc);
        CREATE(locautXmlDoc,FALSE,TRUE);
        locautXmlDoc.async:=FALSE;
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
    procedure fSiguienteEstadoFacturaE(pCabeceraFacturaERecibida: Record "50007")
    var
        locautXmlHttp: Automation ;
        locautXmlDoc: Automation ;
        vlRequestText: Text[1024];
        rlGeneralLedgerSetup: Record "98";
        vlFichero: File;
        vlTextSOAPBegin: Label '<?xml version="1.0" encoding="utf-8"?> <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/">';
        vlTextSOAPEnd: Label '</soapenv:Body> </soapenv:Envelope>';
        vlTextSOAPBegin2: Label '<soapenv:Header /><soapenv:Body>';
        vlBigText: BigText;
        vlInStream: InStream;
        "vlContraseña": Text[1024];
        vlXMLDomNode: Automation ;
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
        CREATE(locautXmlDoc,FALSE,TRUE);
        CLEAR(locautXmlHttp);
        CREATE(locautXmlHttp,FALSE,TRUE);
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
        locautXmlHttp.Open('POST','http://pre.bilbokoudala.lan/aif/ws/DocumentAdministrationServices');
        //locautXmlHttp.SetCredentials(rlGeneralLedgerSetup."Usuario Synergy",vlContraseña,0);
        locautXmlHttp.SetRequestHeader('Content-Type','text/xml; charset=utf-8');
        locautXmlHttp.SetRequestHeader('SOAPAction', 'getNextAllowedStatusList');
        locautXmlHttp.Send(locautXmlDoc);
        
        //Guarda datos
        CLEAR(locautXmlDoc);
        CREATE(locautXmlDoc,FALSE,TRUE);
        locautXmlDoc.async:=FALSE;
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
    procedure fVolverARecibidaFacturaE(pCabeceraFacturaERecibida: Record "50007")
    var
        locautXmlHttp: Automation ;
        locautXmlDoc: Automation ;
        vlRequestText: Text[1024];
        rlGeneralLedgerSetup: Record "98";
        vlFichero: File;
        vlTextSOAPBegin: Label '<?xml version="1.0" encoding="utf-8"?> <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/">';
        vlTextSOAPEnd: Label '</soapenv:Body> </soapenv:Envelope>';
        vlTextSOAPBegin2: Label '<soapenv:Header /><soapenv:Body>';
        vlBigText: BigText;
        vlInStream: InStream;
        "vlContraseña": Text[1024];
        vlXMLDomNode: Automation ;
        rlPurchasesPayablesSetup: Record "312";
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
        locautXmlHttp.Open('POST',rlPurchasesPayablesSetup."URL Servicio Rechazo Facturae");
        //locautXmlHttp.SetCredentials(rlGeneralLedgerSetup."Usuario Synergy",vlContraseña,0);
        locautXmlHttp.SetRequestHeader('Content-Type','text/xml; charset=utf-8');
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
    procedure fPasarDescripciones(pLineasFacturaERecibida: Record "50008";var pLinea: Integer;pPurchaseLine: Record "39")
    var
        vlRuta: Text[1024];
        rlBDRespaldoFacturaRecibida: Record "50010";
    begin
        CLEAR(rlBDRespaldoFacturaRecibida);
        IF rlBDRespaldoFacturaRecibida.GET(pLineasFacturaERecibida."ID Factura") THEN BEGIN
           vlRuta := TEMPORARYPATH + 'XMLFactura' + pLineasFacturaERecibida."ID Factura" + '.xml';
           rlBDRespaldoFacturaRecibida.CALCFIELDS("Datos XML Original");
           rlBDRespaldoFacturaRecibida."Datos XML Original".EXPORT(vlRuta);
           fLeerXMLDescripcion(vlRuta,'CONCEPTO','DESCRIPCION',pLineasFacturaERecibida,pLinea,pPurchaseLine);
        END;
    end;

    [Scope('Internal')]
    procedure fLeerXMLDescripcion(pDirectorio: Text[250];pRaiz: Text[250];pElemento: Text[250];pLineasFacturaERecibida: Record "50008";var pLinea: Integer;pPurchaseLine: Record "39")
    var
        XMLNodeList: Automation ;
        XMLDocument: Automation ;
        strInStream: InStream;
        File: File;
        i: Integer;
        vlClientTempFileName: Text;
        clFileMgt: Codeunit "419";
    begin
        
        IF ISCLEAR(XMLDocument) THEN
          CREATE(XMLDocument,FALSE,TRUE);
        
        //Hay que descargarse el fichero porque el Automation se ejecuta en Cliente
        vlClientTempFileName := clFileMgt.DownloadTempFile(pDirectorio);
        XMLDocument.load(vlClientTempFileName); //se carga el fichero
        IF XMLDocument.hasChildNodes THEN
          XMLNodeList := XMLDocument.getElementsByTagName(pRaiz);//'ns3:Facturae');
        /*
        IF USERID = 'uciadmin' THEN
           fRecorrerXMLJMG('',XMLNodeList,pElemento,pLineasFacturaERecibida,pLinea,FALSE,pPurchaseLine)
        ELSE
        */
        fRecorrerXMLDescripcion('',XMLNodeList,pElemento,pLineasFacturaERecibida,pLinea,FALSE,pPurchaseLine);
        //No es necesario guardar el fichero
        //XMLDocument.save(pDirectorio);

    end;

    [Scope('Internal')]
    procedure fRecorrerXMLDescripcion(pElemento: Text[250];pXMLNodeList: Automation ;pElementomodificar: Text[30];pLineasFacturaERecibida: Record "50008";var pLinea: Integer;pModificar: Boolean;pPurchaseLine: Record "39")
    var
        XMLNodeList: Automation ;
        XMLNode: Automation ;
        i: Integer;
        j: Integer;
        k: Integer;
        XMLNodeList2: Automation ;
        XMLNode2: Automation ;
        vlBigText: BigText;
        XMLNodeText: Automation ;
        rlPurchaseLine: Record "39";
        vlLongitud: Integer;
        vlDescripcion: Text[1024];
        vlTexto: Text[1024];
    begin
        //Recorrer Nodos XML
        vPasado := FALSE;
        XMLNodeList := pXMLNodeList;
        FOR i:=0 TO XMLNodeList.length()-1 DO BEGIN
           XMLNode:= XMLNodeList.item(i);
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
        
                          vlTexto := fCortarLineas(XMLNodeText.substringData(j,1024),k,MAXSTRLEN(rlPurchaseLine.Description));
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
                   fRecorrerXMLDescripcion(XMLNode.nodeName,XMLNodeList2,pElementomodificar,
                                           pLineasFacturaERecibida,pLinea,TRUE,pPurchaseLine);
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
        
                          vlTexto := fCortarLineas(XMLNodeText.substringData(j,1024),k,MAXSTRLEN(rlPurchaseLine.Description));
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
    procedure fCortarLineas(pTextoOrigen: Text[1024];var pPosicion: Integer;"pTamañoMaximo": Integer): Text[1024]
    var
        vlTextoRetorno: Text[1024];
        vlTextoNoCortar: Text[1024];
        vlTextoPosicion: Text[1024];
        vlPosicionBlanco: Integer;
        vlPosicionTotal: Integer;
        vlInicio: Boolean;
        vlLongitud: Integer;
    begin
        IF COPYSTR(pTextoOrigen,pPosicion + pTamañoMaximo,1) = ' ' THEN
           vlTextoRetorno := COPYSTR(pTextoOrigen,pPosicion,pTamañoMaximo)
        ELSE BEGIN
           vlTextoNoCortar := COPYSTR(pTextoOrigen,pPosicion,pTamañoMaximo);
           vlTextoPosicion := vlTextoNoCortar;
           vlPosicionBlanco := 0;
           vlPosicionTotal := 0;
           vlInicio := TRUE;
           WHILE (vlPosicionBlanco <> 0) OR (vlInicio = TRUE) DO BEGIN
              vlPosicionBlanco := STRPOS(vlTextoPosicion,' ');
              vlPosicionTotal += vlPosicionBlanco;
              vlTextoPosicion := COPYSTR(vlTextoPosicion,vlPosicionBlanco + 1,pTamañoMaximo);
              vlInicio := FALSE;
           END;
           IF (vlPosicionBlanco = 0) AND (vlInicio = TRUE) THEN
              vlTextoRetorno := COPYSTR(pTextoOrigen,pPosicion,pTamañoMaximo)
           ELSE
              IF vlPosicionTotal <> 0 THEN
                 IF STRLEN(vlTextoNoCortar) < pTamañoMaximo THEN
                    vlTextoRetorno := COPYSTR(pTextoOrigen,pPosicion,pTamañoMaximo)
                 ELSE
                    vlTextoRetorno := COPYSTR(pTextoOrigen,pPosicion,vlPosicionTotal)
              ELSE
                 vlTextoRetorno := COPYSTR(pTextoOrigen,pPosicion,pTamañoMaximo);
        END;

        pPosicion += STRLEN(vlTextoRetorno);

        EXIT(vlTextoRetorno);
    end;

    [Scope('Internal')]
    procedure fTraerDatosRespaldoPaso1()
    var
        vlDatosNuevos: Boolean;
        lText50000: Label 'No existe ningún registro sin traspasar en la Base de Datos de Respaldo.';
        lText50001: Label 'Proceso cancelado por el usuario.';
        lText50002: Label '¿Desea importar los datos que estén pendientes en la base de datos de respaldo?';
        lText50003: Label 'Datos importados correctamente.';
    begin
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
    end;

    local procedure ValidateShortcutDimCode(FieldNumber: Integer;var ShortcutDimCode: Code[20])
    var
        OldDimSetID: Integer;
    begin
        //Z035 INICIO JRB 28/04/2020 Crear dimensiones en expedientes
        OldDimSetID := "Dimension Set ID";
        DimMgt.ValidateShortcutDimValues(FieldNumber,ShortcutDimCode,"Dimension Set ID");
        IF NUM <> '' THEN
          IF MODIFY THEN;

        IF OldDimSetID <> "Dimension Set ID" THEN BEGIN
          IF MODIFY THEN;
          IF PurchLinesExist THEN //JRB AQUI SIIIII HAY LINEAS
            UpdateAllLineDim("Dimension Set ID",OldDimSetID);
        END;
        //Z035 FIN JRB 28/04/2020 Crear dimensiones en expedientes
    end;

    [Scope('Internal')]
    procedure CreateDim(Type1: Integer;No1: Code[20];Type2: Integer;No2: Code[20];Type3: Integer;No3: Code[20];Type4: Integer;No4: Code[20])
    var
        SourceCodeSetup: Record "242";
        TableID: array [10] of Integer;
        No: array [10] of Code[20];
        OldDimSetID: Integer;
    begin
        //Z035 INICIO JRB 28/04/2020 Crear dimensiones en expedientes
        SourceCodeSetup.GET;
        TableID[1] := Type1;
        No[1] := No1;
        TableID[2] := Type2;
        No[2] := No2;
        TableID[3] := Type3;
        No[3] := No3;
        TableID[4] := Type4;
        No[4] := No4;
        "Shortcut Dimension 1 Code" := '';
        "Shortcut Dimension 2 Code" := '';
        OldDimSetID := "Dimension Set ID";
        "Dimension Set ID" :=
          DimMgt.GetDefaultDimID(TableID,No,SourceCodeSetup.Purchases,"Shortcut Dimension 1 Code","Shortcut Dimension 2 Code",0,0);

        IF (OldDimSetID <> "Dimension Set ID") AND PurchLinesExist THEN BEGIN //JRB AQUI SIIIII HAY LINEAS
          MODIFY;
          UpdateAllLineDim("Dimension Set ID",OldDimSetID);
        END;
        //Z035 FIN JRB 28/04/2020 Crear dimensiones en expedientes
    end;

    [Scope('Internal')]
    procedure ShowDocDim()
    var
        OldDimSetID: Integer;
    begin
        //Z035 INICIO JRB 28/04/2020 Crear dimensiones en expedientes
        OldDimSetID := "Dimension Set ID";
        "Dimension Set ID" :=
          DimMgt.EditDimensionSet2(
            //"Dimension Set ID",STRSUBSTNO('%1 %2',"Document Type","No."),
            "Dimension Set ID",STRSUBSTNO('%1 %2','Factura',NUM),
            "Shortcut Dimension 1 Code","Shortcut Dimension 2 Code");

        IF OldDimSetID <> "Dimension Set ID" THEN BEGIN
          MODIFY;
          IF PurchLinesExist THEN //JRB AQUI SIIIII HAY LINEAS
            UpdateAllLineDim("Dimension Set ID",OldDimSetID);
        END;
        //Z035 FIN JRB 28/04/2020 Crear dimensiones en expedientes
    end;

    [Scope('Internal')]
    procedure PurchLinesExist(): Boolean
    begin
        //Z035 INICIO JRB 28/04/2020 Crear dimensiones en expedientes
        tLineas.RESET;
        tLineas.SETRANGE(tLineas."ID Factura",ID_PLATAFORMA);
        EXIT(tLineas.FINDFIRST);
        //Z035 FIN JRB 28/04/2020 Crear dimensiones en expedientes
    end;

    local procedure UpdateAllLineDim(NewParentDimSetID: Integer;OldParentDimSetID: Integer)
    var
        NewDimSetID: Integer;
    begin
        //Z035 INICIO JRB 28/04/2020 Crear dimensiones en expedientes
        IF NewParentDimSetID = OldParentDimSetID THEN
          EXIT;
        //IF NOT CONFIRM(Text051) THEN
          //EXIT;

        tLineas.RESET;
        tLineas.SETRANGE(tLineas."ID Factura",ID_PLATAFORMA);
        tLineas.LOCKTABLE;
        IF tLineas.FIND('-') THEN
          REPEAT
            NewDimSetID := DimMgt.GetDeltaDimSetID(tLineas."Dimension Set ID",NewParentDimSetID,OldParentDimSetID);
            IF tLineas."Dimension Set ID" <> NewDimSetID THEN BEGIN
              tLineas."Dimension Set ID" := NewDimSetID;
              DimMgt.UpdateGlobalDimFromDimSetID(
                tLineas."Dimension Set ID",tLineas."Shortcut Dimension 1 Code",tLineas."Shortcut Dimension 2 Code");
              tLineas.MODIFY;
            END;
          UNTIL tLineas.NEXT = 0;
        //Z035 FIN JRB 28/04/2020 Crear dimensiones en expedientes
    end;
}

