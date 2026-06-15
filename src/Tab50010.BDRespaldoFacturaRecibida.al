table 50010 "BD Respaldo Factura Recibida"
{
    // I00298 Mod. S2G (JMG) 04-01-17: Ampliar el número de caracteres reemplazados.


    fields
    {
        field(1; "ID Factura"; Text[30])
        {
        }
        field(2; Estado; Text[30])
        {
        }
        field(3; "Datos XML Original"; BLOB)
        {
        }
        field(4; "Estado Navision"; Option)
        {
            OptionMembers = Pendiente,Importado,"Con Errores";
        }
        field(5; "Datos XML Adaptado"; BLOB)
        {
        }
    }

    keys
    {
        key(Key1; "ID Factura")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        XMLNodeList: Automation;
        vClientFileName: Text;

    [Scope('Internal')]
    procedure fProcesarLineas()
    var
        rlBDRespaldoFacturaRecibida: Record "50010";
        rlBDRespaldoFacturaRecibidaMod: Record "50010";
        xlFacturaRecibida: XMLport "50002";
        vlInstream: InStream;
        vlRuta: Text[250];
        vlServerFileName: Text;
        clFileMgt: Codeunit "419";
        vlClientFileName: Text;
    begin
        CLEAR(rlBDRespaldoFacturaRecibida);
        rlBDRespaldoFacturaRecibida.SETFILTER("Estado Navision", '%1|%2', rlBDRespaldoFacturaRecibida."Estado Navision"::Pendiente,
                                              rlBDRespaldoFacturaRecibida."Estado Navision"::"Con Errores");
        IF rlBDRespaldoFacturaRecibida.FINDSET THEN
            REPEAT
                CLEAR(rlBDRespaldoFacturaRecibidaMod);
                rlBDRespaldoFacturaRecibidaMod.GET(rlBDRespaldoFacturaRecibida."ID Factura");
                rlBDRespaldoFacturaRecibida.CALCFIELDS("Datos XML Original");
                rlBDRespaldoFacturaRecibida."Datos XML Original".CREATEINSTREAM(vlInstream);

                //***BGS 02/05/19: Inicio
                //vlRuta := TEMPORARYPATH + rlBDRespaldoFacturaRecibida."ID Factura" + 'xml';
                //rlBDRespaldoFacturaRecibida."Datos XML Original".EXPORT(vlRuta);
                CLEAR(vlServerFileName);
                vlServerFileName := clFileMgt.ServerTempFileName('xml');
                rlBDRespaldoFacturaRecibida."Datos XML Original".EXPORT(vlServerFileName);
                CLEAR(vlClientFileName);
                vlClientFileName := clFileMgt.DownloadTempFile(vlServerFileName);
                vlRuta := vlClientFileName;
                //***BGS 02/05/19: Fin

                fLeerXML(vlRuta, 'CONCEPTO', 'DESCRIPCION');
                fLeerXML(vlRuta, 'FACTURA', 'OBSERVACIONES');

                //***BGS 02/05/19: Inicio
                CLEAR(vlServerFileName);
                vlServerFileName := clFileMgt.UploadFileSilent(vlClientFileName);
                vlRuta := vlServerFileName;
                //***BGS 02/05/19: Fin

                rlBDRespaldoFacturaRecibidaMod."Datos XML Adaptado".IMPORT(vlRuta);
                rlBDRespaldoFacturaRecibidaMod.CALCFIELDS("Datos XML Adaptado");
                //rlBDRespaldoFacturaRecibidaMod."Datos XML Adaptado".EXPORT(
                //          '\\tsclient\C\Compartida\XMLAdaptado' + rlBDRespaldoFacturaRecibidaMod."ID Factura" + '.xml');
                rlBDRespaldoFacturaRecibidaMod."Datos XML Adaptado".CREATEINSTREAM(vlInstream);
                rlBDRespaldoFacturaRecibidaMod.MODIFY;

                CLEAR(xlFacturaRecibida);
                xlFacturaRecibida.SETSOURCE(vlInstream);
                xlFacturaRecibida.IMPORT;

                rlBDRespaldoFacturaRecibidaMod."Estado Navision" := rlBDRespaldoFacturaRecibidaMod."Estado Navision"::Importado;
                rlBDRespaldoFacturaRecibidaMod.MODIFY;

            UNTIL rlBDRespaldoFacturaRecibida.NEXT = 0;
    end;

    [Scope('Internal')]
    procedure fLeerXML(pDirectorio: Text[250]; pRaiz: Text[250]; pElemento: Text[250])
    var
        XMLDocument: Automation;
        strInStream: InStream;
        File: File;
        i: Integer;
    begin

        IF ISCLEAR(XMLDocument) THEN
            CREATE(XMLDocument, FALSE, TRUE);
        XMLDocument.load(pDirectorio); //se carga el fichero
        IF XMLDocument.hasChildNodes THEN
            XMLNodeList := XMLDocument.getElementsByTagName(pRaiz);//'ns3:Facturae');
        fRecorrerXML('', XMLNodeList, pElemento);
        XMLDocument.save(pDirectorio);
    end;

    [Scope('Internal')]
    procedure fRecorrerXML(pElemento: Text[250]; pXMLNodeList: Automation; pElementomodificar: Text[30])
    var
        XMLNodeList: Automation;
        XMLNode: Automation;
        i: Integer;
        XMLNodeList2: Automation;
        XMLNode2: Automation;
        vlBigText: BigText;
        XMLNodeText: Automation;
    begin
        //Recorrer Nodos XML
        XMLNodeList := pXMLNodeList;
        FOR i := 0 TO XMLNodeList.length() - 1 DO BEGIN
            XMLNode := XMLNodeList.item(i);
            IF XMLNode.hasChildNodes THEN BEGIN
                XMLNodeList2 := XMLNode.childNodes;
                IF XMLNode.nodeName = pElementomodificar THEN BEGIN
                    XMLNode2 := XMLNode.parentNode;
                    XMLNodeText := XMLNode.childNodes.item(0);
                    //I00298 Mod. S2G (JMG) 04-01-17: Ampliar el número de caracteres reemplazados.
                    //XMLNodeText.replaceData(1,1000,XMLNodeText.substringData(1,250));
                    XMLNodeText.replaceData(1, 8000, XMLNodeText.substringData(1, 250));
                    //I00298 Mod. S2G (JMG) 04-01-17: Ampliar el número de caracteres reemplazados. Fin
                    EXIT;
                END
                ELSE
                    fRecorrerXML(XMLNode.nodeName, XMLNodeList2, pElementomodificar);
            END
            ELSE BEGIN
                IF XMLNode.nodeName = pElementomodificar THEN BEGIN
                    XMLNode2 := XMLNode.parentNode;
                    IF XMLNode.text <> '' THEN BEGIN
                        XMLNodeText := XMLNode.childNodes.item(0);
                        //I00298 Mod. S2G (JMG) 04-01-17: Ampliar el número de caracteres reemplazados.
                        //XMLNodeText.replaceData(1,1000,XMLNodeText.substringData(1,250));
                        XMLNodeText.replaceData(1, 8000, XMLNodeText.substringData(1, 250));
                        //I00298 Mod. S2G (JMG) 04-01-17: Ampliar el número de caracteres reemplazados. Fin
                        EXIT;
                    END;
                END;
            END;
        END;
    end;

    [Scope('Internal')]
    procedure fSetClientFileName(pClientFileName: Text)
    begin
        //***BGS 02/05/19: Inicio
        vClientFileName := pClientFileName;
        //***BGS 02/05/19: Fin
    end;
}

