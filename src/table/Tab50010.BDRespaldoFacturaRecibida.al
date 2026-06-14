table 80005 "BD Respaldo Factura Recibida"
{
    Caption = 'BD Respaldo Factura Recibida';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "ID Factura"; Text[30])
        {
            Caption = 'ID Factura';
            DataClassification = CustomerContent;
        }
        field(2; Estado; Text[30])
        {
            Caption = 'Estado';
            DataClassification = CustomerContent;
        }
        field(3; "Datos XML Original"; Blob)
        {
            Caption = 'Datos XML Original';
            DataClassification = CustomerContent;
        }
        field(4; "Estado Navision"; Enum "BD Respaldo Factura Estado Nav")
        {
            Caption = 'Estado Navision';
            DataClassification = CustomerContent;
        }
        field(5; "Datos XML Adaptado"; Blob)
        {
            Caption = 'Datos XML Adaptado';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "ID Factura")
        {
            Clustered = true;
        }
    }

    procedure fProcesarLineas(): Boolean
    var
        BDRespaldoFacturaRecibida: Record "BD Respaldo Factura Recibida";
        BDRespaldoFacturaRecibidaMod: Record "BD Respaldo Factura Recibida";
        ImportOrchestrator: Codeunit "FacturaE Import Orchestrator";
        XmlInStream: InStream;
        AdaptedXmlInStream: InStream;
    begin
        BDRespaldoFacturaRecibida.SetFilter("Estado Navision", '%1|%2', BDRespaldoFacturaRecibida."Estado Navision"::Pendiente,
            BDRespaldoFacturaRecibida."Estado Navision"::"Con Errores");
        if not BDRespaldoFacturaRecibida.FindSet() then
            exit(false);

        repeat
            BDRespaldoFacturaRecibida.CalcFields("Datos XML Original");
            BDRespaldoFacturaRecibida."Datos XML Original".CreateInStream(XmlInStream, TextEncoding::UTF8);

            BDRespaldoFacturaRecibidaMod.Get(BDRespaldoFacturaRecibida."ID Factura");
            AdaptXml(XmlInStream, BDRespaldoFacturaRecibidaMod);
            BDRespaldoFacturaRecibidaMod.CalcFields("Datos XML Adaptado");
            BDRespaldoFacturaRecibidaMod."Datos XML Adaptado".CreateInStream(AdaptedXmlInStream, TextEncoding::UTF8);

            ImportOrchestrator.ImportXmlStream(AdaptedXmlInStream, BDRespaldoFacturaRecibidaMod."ID Factura" + '.xml');

            BDRespaldoFacturaRecibidaMod."Estado Navision" := BDRespaldoFacturaRecibidaMod."Estado Navision"::Importado;
            BDRespaldoFacturaRecibidaMod.Modify(true);
        until BDRespaldoFacturaRecibida.Next() = 0;

        exit(true);
    end;

    procedure fLeerXML(var XmlInStream: InStream; var XmlOutStream: OutStream; pRaiz: Text; pElemento: Text)
    var
        XmlDocument: XmlDocument;
    begin
        XmlDocument.ReadFrom(XmlInStream, XmlDocument);
        TruncateXmlElementText(XmlDocument, pRaiz, pElemento, 250);
        XmlDocument.WriteTo(XmlOutStream);
    end;

    local procedure AdaptXml(var XmlInStream: InStream; var BDRespaldoFacturaRecibida: Record "BD Respaldo Factura Recibida")
    var
        XmlDocument: XmlDocument;
        XmlOutStream: OutStream;
    begin
        XmlDocument.ReadFrom(XmlInStream, XmlDocument);
        TruncateXmlElementText(XmlDocument, 'CONCEPTO', 'DESCRIPCION', 250);
        TruncateXmlElementText(XmlDocument, 'FACTURA', 'OBSERVACIONES', 250);

        BDRespaldoFacturaRecibida."Datos XML Adaptado".CreateOutStream(XmlOutStream, TextEncoding::UTF8);
        XmlDocument.WriteTo(XmlOutStream);
        BDRespaldoFacturaRecibida.Modify(true);
    end;

    local procedure TruncateXmlElementText(var XmlDocument: XmlDocument; RootElementName: Text; ElementName: Text; MaxLength: Integer)
    var
        RootNodes: XmlNodeList;
        RootNode: XmlNode;
    begin
        if not XmlDocument.SelectNodes(StrSubstNo('//*[local-name()="%1"]', RootElementName), RootNodes) then
            exit;

        foreach RootNode in RootNodes do
            TruncateXmlElementText(RootNode, ElementName, MaxLength);
    end;

    local procedure TruncateXmlElementText(XmlNode: XmlNode; ElementName: Text; MaxLength: Integer)
    var
        ElementNodes: XmlNodeList;
        ElementNode: XmlNode;
        XmlElement: XmlElement;
        ElementText: Text;
    begin
        if not XmlNode.SelectNodes(StrSubstNo('.//*[local-name()="%1"]', ElementName), ElementNodes) then
            exit;

        foreach ElementNode in ElementNodes do begin
            XmlElement := ElementNode.AsXmlElement();
            ElementText := XmlElement.InnerText();
            if StrLen(ElementText) > MaxLength then
                XmlElement.ReplaceNodes(CopyStr(ElementText, 1, MaxLength));
        end;
    end;

    procedure fSetClientFileName(pClientFileName: Text)
    begin
        // Conservado por compatibilidad con llamadas C/AL migradas. En SaaS no se usan rutas de cliente/servidor.
    end;
}
