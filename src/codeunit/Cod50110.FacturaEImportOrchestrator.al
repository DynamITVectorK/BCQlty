codeunit 50110 "FacturaE Import Orchestrator"
{
    Access = Internal;

    procedure ImportPendingInvoices(): Boolean
    var
        Handled: Boolean;
        Imported: Boolean;
    begin
        OnImportPendingInvoices(Handled, Imported);
        if Handled then
            exit(Imported);

        Error(NoImportSourceConfiguredErr);
    end;

    procedure ImportXml(var XmlInStream: InStream; FileName: Text[250]): Boolean
    var
        Handled: Boolean;
        Imported: Boolean;
    begin
        OnImportXml(XmlInStream, FileName, Handled, Imported);
        if Handled then
            exit(Imported);

        Error(NoXmlImporterConfiguredErr);
    end;

    procedure MarkAsProcessed(ExternalId: Text; FacturaEPlatformId: Text)
    var
        Handled: Boolean;
    begin
        OnMarkAsProcessed(ExternalId, FacturaEPlatformId, Handled);
        if Handled then
            exit;
    end;

    var
        NoImportSourceConfiguredErr: Label 'No hay origen de importación FacturaE configurado para SaaS. Debe implementarse mediante evento, API HTTP o carga manual por stream.';
        NoXmlImporterConfiguredErr: Label 'No hay importador XML FacturaE configurado. Debe implementarse el parser SaaS con XmlDocument o suscribirse al evento de importación.';

    [IntegrationEvent(false, false)]
    local procedure OnImportPendingInvoices(var Handled: Boolean; var Imported: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnImportXml(var XmlInStream: InStream; FileName: Text[250]; var Handled: Boolean; var Imported: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnMarkAsProcessed(ExternalId: Text; FacturaEPlatformId: Text; var Handled: Boolean)
    begin
    end;
}
