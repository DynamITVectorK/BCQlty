codeunit 50110 "FacturaE Import Orchestrator"
{
    var
        SelectXmlLbl: Label 'Seleccione el XML FacturaE', Locked = true;
        XmlFileFilterLbl: Label 'XML (*.xml)|*.xml', Locked = true;
        ConfirmImportQst: Label '¿Desea importar facturas FacturaE recibidas desde el origen configurado?';
        ProcessCanceledErr: Label 'Proceso cancelado por el usuario.';
        EndpointNotConfiguredErr: Label 'Configure la URL de facturas pendientes en Configuración importación FacturaE.';
        EndpointDisabledErr: Label 'La importación FacturaE no está habilitada en la configuración.';
        EmptyEndpointResponseMsg: Label 'El origen configurado no devolvió facturas pendientes.';
        ImportedCountMsg: Label 'Facturas FacturaE importadas: %1.';
        JsonReadErr: Label 'No se pudo interpretar la respuesta del origen FacturaE. Se esperaba un JSON con un array invoices/value.';

    procedure ConfirmAndImportPending(): Boolean
    begin
        if not Confirm(ConfirmImportQst) then
            Error(ProcessCanceledErr);

        exit(ImportPending());
    end;

    procedure ImportPending(): Boolean
    var
        Setup: Record "FacturaE Import Setup";
        ImportedCount: Integer;
    begin
        Setup.GetOrCreate();
        if not Setup.Enabled then
            Error(EndpointDisabledErr);

        case Setup."Source Type" of
            Setup."Source Type"::Manual:
                exit(ImportManualUpload());
            Setup."Source Type"::"HTTP Endpoint":
                begin
                    ImportedCount := ImportFromHttpEndpoint(Setup);
                    UpdateLastRun(Setup, ImportedCount, '');
                    if ImportedCount = 0 then
                        Message(EmptyEndpointResponseMsg)
                    else
                        Message(ImportedCountMsg, ImportedCount);
                    exit(ImportedCount > 0);
                end;
        end;
    end;

    procedure ImportManualUpload(): Boolean
    var
        FacturaEXmlImport: Codeunit "FacturaE XML Import";
        XmlInStream: InStream;
        FileName: Text;
        InvoicePlatformId: Text[50];
    begin
        if not UploadIntoStream(SelectXmlLbl, '', XmlFileFilterLbl, FileName, XmlInStream) then
            exit(false);

        InvoicePlatformId := FacturaEXmlImport.ImportXml(XmlInStream, FileName);
        LogImport('', FileName, InvoicePlatformId, '', "FacturaE Import Status"::Imported);
        exit(true);
    end;

    procedure ImportXmlStream(XmlInStream: InStream; FileName: Text): Code[20]
    var
        FacturaEXmlImport: Codeunit "FacturaE XML Import";
        InvoicePlatformId: Code[20];
    begin
        InvoicePlatformId := CopyStr(FacturaEXmlImport.ImportXml(XmlInStream, FileName), 1, MaxStrLen(InvoicePlatformId));
        LogImport('', FileName, InvoicePlatformId, '', "FacturaE Import Status"::Imported);
        exit(InvoicePlatformId);
    end;

    local procedure ImportFromHttpEndpoint(var Setup: Record "FacturaE Import Setup"): Integer
    var
        Client: HttpClient;
        Response: HttpResponseMessage;
        ResponseText: Text;
        ImportedCount: Integer;
    begin
        if Setup."Pending Invoices URL" = '' then
            Error(EndpointNotConfiguredErr);

        Client.Get(Setup."Pending Invoices URL", Response);
        Response.Content().ReadAs(ResponseText);
        if not Response.IsSuccessStatusCode() then begin
            UpdateLastRun(Setup, 0, CopyStr(ResponseText, 1, MaxStrLen(Setup."Last Error")));
            Error(CopyStr(ResponseText, 1, 250));
        end;

        ImportedCount := ImportFromJsonPayload(ResponseText, Setup);
        exit(ImportedCount);
    end;

    local procedure ImportFromJsonPayload(ResponseText: Text; var Setup: Record "FacturaE Import Setup"): Integer
    var
        RootObject: JsonObject;
        InvoicesToken: JsonToken;
        InvoicesArray: JsonArray;
        InvoiceToken: JsonToken;
        InvoiceObject: JsonObject;
        ImportedCount: Integer;
    begin
        if not RootObject.ReadFrom(ResponseText) then
            Error(JsonReadErr);

        if RootObject.Get('invoices', InvoicesToken) then
            InvoicesArray := InvoicesToken.AsArray()
        else
            if RootObject.Get('value', InvoicesToken) then
                InvoicesArray := InvoicesToken.AsArray()
            else
                exit(0);

        foreach InvoiceToken in InvoicesArray do begin
            InvoiceObject := InvoiceToken.AsObject();
            if ImportJsonInvoice(InvoiceObject, Setup) then
                ImportedCount += 1;
        end;

        exit(ImportedCount);
    end;

    local procedure ImportJsonInvoice(InvoiceObject: JsonObject; var Setup: Record "FacturaE Import Setup"): Boolean
    var
        FacturaEXmlImport: Codeunit "FacturaE XML Import";
        TempBlob: Codeunit "Temp Blob";
        XmlInStream: InStream;
        XmlOutStream: OutStream;
        ExternalId: Text[100];
        FileName: Text[250];
        XmlText: Text;
        InvoicePlatformId: Code[20];
    begin
        ExternalId := CopyStr(GetJsonText(InvoiceObject, 'id'), 1, MaxStrLen(ExternalId));
        FileName := CopyStr(GetJsonText(InvoiceObject, 'fileName'), 1, MaxStrLen(FileName));
        XmlText := GetJsonText(InvoiceObject, 'xml');
        if FileName = '' then
            FileName := ExternalId + '.xml';

        TempBlob.CreateOutStream(XmlOutStream, TextEncoding::UTF8);
        XmlOutStream.WriteText(XmlText);
        TempBlob.CreateInStream(XmlInStream, TextEncoding::UTF8);

        InvoicePlatformId := CopyStr(FacturaEXmlImport.ImportXml(XmlInStream, FileName), 1, MaxStrLen(InvoicePlatformId));
        LogImport(ExternalId, FileName, InvoicePlatformId, '', "FacturaE Import Status"::Imported);
        MarkExternalInvoiceProcessed(Setup, ExternalId, InvoicePlatformId);
        exit(true);
    end;

    local procedure MarkExternalInvoiceProcessed(Setup: Record "FacturaE Import Setup"; ExternalId: Text[100]; InvoicePlatformId: Text[50])
    var
        Client: HttpClient;
        Content: HttpContent;
        Response: HttpResponseMessage;
        Url: Text;
        Body: Text;
        ResponseText: Text;
    begin
        if Setup."Mark Processed URL" = '' then
            exit;

        Url := StrSubstNo(Setup."Mark Processed URL", ExternalId);
        Body := StrSubstNo('{"id":"%1","invoicePlatformId":"%2"}', ExternalId, InvoicePlatformId);
        Content.WriteFrom(Body);
        Client.Post(Url, Content, Response);
        if not Response.IsSuccessStatusCode() then begin
            Response.Content().ReadAs(ResponseText);
            LogImport(ExternalId, '', CopyStr(InvoicePlatformId, 1, 50), CopyStr(ResponseText, 1, 250), "FacturaE Import Status"::Error);
        end;
    end;

    local procedure GetJsonText(JsonObject: JsonObject; PropertyName: Text): Text
    var
        JsonToken: JsonToken;
    begin
        if JsonObject.Get(PropertyName, JsonToken) then
            exit(JsonToken.AsValue().AsText());

        exit('');
    end;

    local procedure LogImport(ExternalId: Text[100]; FileName: Text[250]; InvoicePlatformId: Text[50]; Message: Text[250]; Status: Enum "FacturaE Import Status")
    var
        ImportLog: Record "FacturaE Import Log";
    begin
        ImportLog.Init();
        ImportLog."External Id" := ExternalId;
        ImportLog."File Name" := FileName;
        ImportLog."Invoice Platform Id" := InvoicePlatformId;
        ImportLog.Message := Message;
        ImportLog.Status := Status;
        ImportLog."Imported At" := CurrentDateTime();
        ImportLog."User ID" := CopyStr(UserId(), 1, MaxStrLen(ImportLog."User ID"));
        ImportLog.Insert(true);
    end;

    local procedure UpdateLastRun(var Setup: Record "FacturaE Import Setup"; ImportedCount: Integer; LastError: Text[250])
    begin
        Setup."Last Run DateTime" := CurrentDateTime();
        Setup."Last Imported Count" := ImportedCount;
        Setup."Last Error" := LastError;
        Setup.Modify(true);
    end;
}
