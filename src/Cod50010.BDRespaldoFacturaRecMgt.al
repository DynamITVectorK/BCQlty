codeunit 50010 "BD Respaldo Factura Rec. Mgt."
{
    var
        XmlDoc: XmlDocument;
        vClientFileName: Text;
        FilePathNotSupportedErr: Label 'The legacy file-based XML adaptation is not supported in Business Central SaaS. Use stream-based processing from Datos XML Original and Datos XML Adaptado.';

    internal procedure fProcesarLineas()
    var
        RespaldoFacturaRecibida: Record "BD Respaldo Factura Recibida";
        RespaldoFacturaRecibidaMod: Record "BD Respaldo Factura Recibida";
    begin
        Clear(RespaldoFacturaRecibida);
        RespaldoFacturaRecibida.SetFilter("Estado Navision", '%1|%2', RespaldoFacturaRecibida."Estado Navision"::Pendiente,
                                          RespaldoFacturaRecibida."Estado Navision"::"Con Errores");
        if RespaldoFacturaRecibida.FindSet() then
            repeat
                Clear(RespaldoFacturaRecibidaMod);
                RespaldoFacturaRecibidaMod.Get(RespaldoFacturaRecibida."ID Factura");
                ProcessRespaldoFacturaRecibida(RespaldoFacturaRecibidaMod);
            until RespaldoFacturaRecibida.Next() = 0;
    end;

    internal procedure fLeerXML(pDirectorio: Text[250]; pRaiz: Text[250]; pElemento: Text[250])
    begin
        // SaaS replacement: XML is adapted in memory by AdaptXmlDocumentFromBlob().
        // The original file-path signature is retained only for compatibility with legacy callers.
        Error(FilePathNotSupportedErr);
    end;

    internal procedure fRecorrerXML(pElemento: Text[250]; pXMLNodeList: XmlNodeList; pElementomodificar: Text[30])
    begin
        RecorrerXMLNodes(pXMLNodeList, pElementomodificar);
    end;

    internal procedure fSetClientFileName(pClientFileName: Text)
    begin
        //***BGS 02/05/19: Inicio
        vClientFileName := pClientFileName;
        //***BGS 02/05/19: Fin
    end;

    local procedure ProcessRespaldoFacturaRecibida(var RespaldoFacturaRecibida: Record "BD Respaldo Factura Recibida")
    var
        FacturaRecibida: XMLport "50002";
        AdaptedXmlInStream: InStream;
    begin
        AdaptXmlDocumentFromBlob(RespaldoFacturaRecibida);

        RespaldoFacturaRecibida.CalcFields("Datos XML Adaptado");
        RespaldoFacturaRecibida."Datos XML Adaptado".CreateInStream(AdaptedXmlInStream);

        Clear(FacturaRecibida);
        FacturaRecibida.SetSource(AdaptedXmlInStream);
        FacturaRecibida.Import();

        RespaldoFacturaRecibida."Estado Navision" := RespaldoFacturaRecibida."Estado Navision"::Importado;
        RespaldoFacturaRecibida.Modify();
    end;

    local procedure AdaptXmlDocumentFromBlob(var RespaldoFacturaRecibida: Record "BD Respaldo Factura Recibida")
    var
        OriginalXmlInStream: InStream;
        AdaptedXmlOutStream: OutStream;
    begin
        RespaldoFacturaRecibida.CalcFields("Datos XML Original");
        RespaldoFacturaRecibida."Datos XML Original".CreateInStream(OriginalXmlInStream);
        XmlDocument.ReadFrom(OriginalXmlInStream, XmlDoc);

        AdaptXmlNodes('CONCEPTO', 'DESCRIPCION');
        AdaptXmlNodes('FACTURA', 'OBSERVACIONES');

        Clear(RespaldoFacturaRecibida."Datos XML Adaptado");
        RespaldoFacturaRecibida."Datos XML Adaptado".CreateOutStream(AdaptedXmlOutStream);
        XmlDoc.WriteTo(AdaptedXmlOutStream);
        RespaldoFacturaRecibida.Modify();
    end;

    local procedure AdaptXmlNodes(RootElementName: Text; ElementToModify: Text[30])
    var
        Nodes: XmlNodeList;
    begin
        if XmlDoc.SelectNodes('//' + RootElementName, Nodes) then
            RecorrerXMLNodes(Nodes, ElementToModify);
    end;

    local procedure RecorrerXMLNodes(var XMLNodeList: XmlNodeList; ElementToModify: Text[30])
    var
        XMLNode: XmlNode;
        XMLNodeList2: XmlNodeList;
        i: Integer;
    begin
        for i := 1 to XMLNodeList.Count() do begin
            XMLNodeList.Get(i, XMLNode);
            if XMLNode.AsXmlElement().Name() = ElementToModify then begin
                ApplyLegacyTextLimitToNode(XMLNode);
                exit;
            end;

            if XMLNode.SelectNodes('*', XMLNodeList2) then
                RecorrerXMLNodes(XMLNodeList2, ElementToModify);
        end;
    end;

    local procedure ApplyLegacyTextLimitToNode(var XMLNode: XmlNode)
    var
        XMLElement: XmlElement;
        NodeText: Text;
    begin
        XMLElement := XMLNode.AsXmlElement();
        NodeText := XMLElement.InnerText();
        if NodeText = '' then
            exit;

        // I00298 Mod. S2G (JMG) 04-01-17: preserve replaceData(1, 8000, substringData(1, 250)).
        // With the legacy zero-based DOM offsets this keeps the first character and at most 250 more.
        XMLElement.InnerText(ApplyLegacyTextLimit(NodeText));
    end;

    local procedure ApplyLegacyTextLimit(Value: Text): Text
    begin
        if StrLen(Value) <= 251 then
            exit(Value);

        exit(CopyStr(Value, 1, 251));
    end;
}
