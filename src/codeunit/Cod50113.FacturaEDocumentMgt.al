codeunit 50113 "FacturaE Document Mgt."
{
    Access = Internal;

    procedure OpenDocument(DocumentUrlOrPath: Text)
    begin
        if DocumentUrlOrPath = '' then
            exit;

        Hyperlink(DocumentUrlOrPath);
    end;

    procedure OpenContainer(ContainerUrlOrPath: Text)
    begin
        if ContainerUrlOrPath = '' then
            exit;

        Hyperlink(ContainerUrlOrPath);
    end;

    procedure CopyDocumentLinksToPurchase(var FacturaEHeader: Record "Cabecera FacturaE Recibida"; var PurchaseHeader: Record "Purchase Header")
    begin
        AddLinkIfNotBlank(PurchaseHeader, FacturaEHeader."DOCUMENTO PDF");
        AddLinkIfNotBlank(PurchaseHeader, FacturaEHeader."DOCUMENTO FACTURA");
        AddLinkIfNotBlank(PurchaseHeader, FacturaEHeader."DOCUMENTACIÓN ADJUNTA");
        OnAfterCopyDocumentLinks(FacturaEHeader, PurchaseHeader);
    end;

    local procedure AddLinkIfNotBlank(var PurchaseHeader: Record "Purchase Header"; LinkValue: Text)
    begin
        if LinkValue = '' then
            exit;

        PurchaseHeader.AddLink(LinkValue);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterCopyDocumentLinks(var FacturaEHeader: Record "Cabecera FacturaE Recibida"; var PurchaseHeader: Record "Purchase Header")
    begin
    end;
}
