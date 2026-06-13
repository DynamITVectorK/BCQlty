codeunit 80002 "FacturaE XML Import"
{
    procedure ImportXml(XmlInStream: InStream; FileName: Text): Code[20]
    var
        FacturaE: Record "Cabecera FacturaE Recibida";
        TempBlob: Codeunit "Temp Blob";
        XmlDocument: XmlDocument;
        WorkInStream: InStream;
        SaveInStream: InStream;
        TempOutStream: OutStream;
    begin
        TempBlob.CreateOutStream(TempOutStream, TextEncoding::UTF8);
        CopyStream(TempOutStream, XmlInStream);

        TempBlob.CreateInStream(WorkInStream, TextEncoding::UTF8);
        XmlDocument.ReadFrom(WorkInStream, XmlDocument);

        UpsertHeader(FacturaE, XmlDocument, FileName);

        TempBlob.CreateInStream(SaveInStream, TextEncoding::UTF8);
        SaveOriginalXml(FacturaE, SaveInStream, FileName);

        ImportLines(FacturaE, XmlDocument);
        ImportTaxes(FacturaE, XmlDocument);
        FacturaE.Modify(true);

        exit(FacturaE."ID Plataforma");
    end;

    local procedure UpsertHeader(var FacturaE: Record "Cabecera FacturaE Recibida"; XmlDocument: XmlDocument; FileName: Text)
    var
        InvoiceNumber: Text[20];
        PlatformId: Text[50];
    begin
        InvoiceNumber := CopyStr(SelectText(XmlDocument, '//*[local-name()="InvoiceNumber"]'), 1, MaxStrLen(InvoiceNumber));
        PlatformId := CopyStr(
            SelectText(XmlDocument, '//*[local-name()="InvoiceDocument"]/*[local-name()="InvoiceHeader"]/*[local-name()="InvoiceDocumentType"]'),
            1,
            MaxStrLen(PlatformId));
        if PlatformId = '' then
            PlatformId := CopyStr(DelChr(FileName, '=', '\/:*?"<>|'), 1, MaxStrLen(PlatformId));
        if PlatformId = '' then
            PlatformId := InvoiceNumber;

        if not FacturaE.Get(PlatformId, InvoiceNumber) then begin
            FacturaE.Init();
            FacturaE."ID Plataforma" := PlatformId;
            FacturaE."Numero" := InvoiceNumber;
            FacturaE.Insert(true);
        end;

        FacturaE.Validate("Serie", CopyStr(SelectText(XmlDocument, '//*[local-name()="InvoiceSeriesCode"]'), 1, MaxStrLen(FacturaE."Serie")));
        FacturaE.Validate("Fecha Entrada", Today());
        FacturaE.Validate("Fecha Devengo", SelectDate(XmlDocument, '//*[local-name()="IssueDate"]'));
        FacturaE.Validate("Fecha Pago", SelectDate(XmlDocument, '//*[local-name()="InstallmentDueDate"]'));
        FacturaE.Validate("Emisor CIF", CopyStr(SelectText(XmlDocument, SellerPath('TaxIdentificationNumber')), 1, MaxStrLen(FacturaE."Emisor CIF")));
        FacturaE.Validate("Emisor Nombre", CopyStr(SelectText(XmlDocument, SellerPath('CorporateName')), 1, MaxStrLen(FacturaE."Emisor Nombre")));
        FacturaE.Validate("Emisor Direccion", CopyStr(SelectText(XmlDocument, SellerPath('Address')), 1, MaxStrLen(FacturaE."Emisor Direccion")));
        FacturaE.Validate("Emisor Ciudad", CopyStr(SelectText(XmlDocument, SellerPath('Town')), 1, MaxStrLen(FacturaE."Emisor Ciudad")));
        FacturaE.Validate("Emisor Provincia", CopyStr(SelectText(XmlDocument, SellerPath('Province')), 1, MaxStrLen(FacturaE."Emisor Provincia")));
        FacturaE.Validate("Emisor CP", CopyStr(SelectText(XmlDocument, SellerPath('PostCode')), 1, MaxStrLen(FacturaE."Emisor CP")));
        FacturaE.Validate("Receptor CIF", CopyStr(SelectText(XmlDocument, BuyerPath('TaxIdentificationNumber')), 1, MaxStrLen(FacturaE."Receptor CIF")));
        FacturaE.Validate("IBAN Pago", CopyStr(SelectText(XmlDocument, '//*[local-name()="IBAN"]'), 1, MaxStrLen(FacturaE."IBAN Pago")));
        FacturaE.Validate("Total Bases", SelectDecimal(XmlDocument, '//*[local-name()="InvoiceTotals"]/*[local-name()="TotalGrossAmount"]'));
        FacturaE.Validate("Total Tasas", SelectDecimal(XmlDocument, '//*[local-name()="InvoiceTotals"]/*[local-name()="TotalTaxOutputs"]'));
        FacturaE.Validate("Total Pagar", SelectDecimal(XmlDocument, '//*[local-name()="InvoiceTotals"]/*[local-name()="InvoiceTotal"]'));
        FacturaE."Nombre Fichero XML" := CopyStr(FileName, 1, MaxStrLen(FacturaE."Nombre Fichero XML"));
    end;

    local procedure ImportLines(FacturaE: Record "Cabecera FacturaE Recibida"; XmlDocument: XmlDocument)
    var
        LineaFacturaE: Record "Linea FacturaE Recibida";
        InvoiceLineNodes: XmlNodeList;
        InvoiceLineNode: XmlNode;
        LineNo: Integer;
    begin
        LineaFacturaE.SetRange("ID Factura", FacturaE."ID Plataforma");
        LineaFacturaE.DeleteAll(true);

        if not XmlDocument.SelectNodes('//*[local-name()="Items"]/*[local-name()="InvoiceLine"]', InvoiceLineNodes) then
            exit;

        foreach InvoiceLineNode in InvoiceLineNodes do begin
            LineNo += 10000;
            LineaFacturaE.Init();
            LineaFacturaE."ID Factura" := FacturaE."ID Plataforma";
            LineaFacturaE."Line No." := LineNo;
            LineaFacturaE.Description := CopyStr(SelectText(InvoiceLineNode, './*[local-name()="ItemDescription"]'), 1, MaxStrLen(LineaFacturaE.Description));
            LineaFacturaE.Quantity := SelectDecimal(InvoiceLineNode, './*[local-name()="Quantity"]');
            LineaFacturaE."Unit Price" := SelectDecimal(InvoiceLineNode, './*[local-name()="UnitPriceWithoutTax"]');
            LineaFacturaE.Amount := SelectDecimal(InvoiceLineNode, './*[local-name()="GrossAmount"]');
            if LineaFacturaE.Amount = 0 then
                LineaFacturaE.Amount := SelectDecimal(InvoiceLineNode, './*[local-name()="TotalCost"]');
            LineaFacturaE.Expediente := FacturaE.Expediente;
            LineaFacturaE.Lote := FacturaE.Lote;
            LineaFacturaE."Shortcut Dimension 1 Code" := FacturaE."Shortcut Dimension 1 Code";
            LineaFacturaE."Shortcut Dimension 2 Code" := FacturaE."Shortcut Dimension 2 Code";
            LineaFacturaE."Dimension Set ID" := FacturaE."Dimension Set ID";
            LineaFacturaE.Insert(true);
        end;
    end;

    local procedure ImportTaxes(FacturaE: Record "Cabecera FacturaE Recibida"; XmlDocument: XmlDocument)
    var
        TasaFacturaE: Record "Tasa FacturaE Recibida";
        TaxNodes: XmlNodeList;
        TaxNode: XmlNode;
        LineNo: Integer;
    begin
        TasaFacturaE.SetRange("ID Factura", FacturaE."ID Plataforma");
        TasaFacturaE.DeleteAll(true);

        if not XmlDocument.SelectNodes('//*[local-name()="TaxesOutputs"]/*[local-name()="Tax"]', TaxNodes) then
            exit;

        foreach TaxNode in TaxNodes do begin
            LineNo += 10000;
            TasaFacturaE.Init();
            TasaFacturaE."ID Factura" := FacturaE."ID Plataforma";
            TasaFacturaE."Line No." := LineNo;
            TasaFacturaE.Description := CopyStr(
                StrSubstNo(
                    '%1 %2%%',
                    SelectText(TaxNode, './*[local-name()="TaxTypeCode"]'),
                    SelectText(TaxNode, './*[local-name()="TaxRate"]')),
                1,
                MaxStrLen(TasaFacturaE.Description));
            TasaFacturaE.Amount := SelectDecimal(TaxNode, './*[local-name()="TaxAmount"]/*[local-name()="TotalAmount"]');
            if TasaFacturaE.Amount = 0 then
                TasaFacturaE.Amount := SelectDecimal(TaxNode, './*[local-name()="TotalAmount"]');
            TasaFacturaE.Insert(true);
        end;
    end;

    local procedure SaveOriginalXml(var FacturaE: Record "Cabecera FacturaE Recibida"; XmlInStream: InStream; FileName: Text)
    var
        XmlOutStream: OutStream;
    begin
        FacturaE."XML Original".CreateOutStream(XmlOutStream, TextEncoding::UTF8);
        CopyStream(XmlOutStream, XmlInStream);
        FacturaE."Nombre Fichero XML" := CopyStr(FileName, 1, MaxStrLen(FacturaE."Nombre Fichero XML"));
    end;

    local procedure SelectText(XmlDocument: XmlDocument; XPath: Text): Text
    var
        XmlNode: XmlNode;
    begin
        if XmlDocument.SelectSingleNode(XPath, XmlNode) then
            exit(SelectText(XmlNode, '.'));
        exit('');
    end;

    local procedure SelectText(XmlNode: XmlNode; XPath: Text): Text
    var
        SelectedNode: XmlNode;
    begin
        if XmlNode.SelectSingleNode(XPath, SelectedNode) then
            exit(SelectedNode.AsXmlElement().InnerText());
        exit('');
    end;

    local procedure SelectDate(XmlDocument: XmlDocument; XPath: Text): Date
    var
        DateValue: Date;
        DateText: Text;
    begin
        DateText := SelectText(XmlDocument, XPath);
        if DateText = '' then
            exit(0D);
        if Evaluate(DateValue, DateText, 9) then
            exit(DateValue);
        Evaluate(DateValue, DateText);
        exit(DateValue);
    end;

    local procedure SelectDecimal(XmlDocument: XmlDocument; XPath: Text): Decimal
    var
        DecimalValue: Decimal;
        DecimalText: Text;
    begin
        DecimalText := SelectText(XmlDocument, XPath);
        if DecimalText = '' then
            exit(0);
        exit(EvaluateDecimal(DecimalText));
    end;

    local procedure SelectDecimal(XmlNode: XmlNode; XPath: Text): Decimal
    var
        DecimalText: Text;
    begin
        DecimalText := SelectText(XmlNode, XPath);
        if DecimalText = '' then
            exit(0);
        exit(EvaluateDecimal(DecimalText));
    end;

    local procedure EvaluateDecimal(DecimalText: Text): Decimal
    var
        DecimalValue: Decimal;
    begin
        if Evaluate(DecimalValue, DecimalText, 9) then
            exit(DecimalValue);
        if Evaluate(DecimalValue, DecimalText) then
            exit(DecimalValue);
        Evaluate(DecimalValue, ConvertStr(DecimalText, '.', ','));
        exit(DecimalValue);
    end;

    local procedure SellerPath(ElementName: Text): Text
    begin
        exit('//*[local-name()="SellerParty"]//*[local-name()="' + ElementName + '"]');
    end;

    local procedure BuyerPath(ElementName: Text): Text
    begin
        exit('//*[local-name()="BuyerParty"]//*[local-name()="' + ElementName + '"]');
    end;
}
