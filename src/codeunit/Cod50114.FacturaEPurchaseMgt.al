codeunit 50114 "FacturaE Purchase Mgt."
{
    Access = Internal;

    procedure CreatePurchaseDocument(var FacturaEHeader: Record "Cabecera FacturaE Recibida"; PostDocument: Boolean)
    var
        PurchaseHeader: Record "Purchase Header";
    begin
        ValidateCanCreatePurchaseDocument(FacturaEHeader);
        BuildPurchaseHeader(FacturaEHeader, PurchaseHeader);
        OnCreatePurchaseLines(FacturaEHeader, PurchaseHeader);
        OnCopyPurchaseComments(FacturaEHeader, PurchaseHeader);
        OnHandlePurchaseApproval(FacturaEHeader, PurchaseHeader);
        OnAfterCreatePurchaseDocument(FacturaEHeader, PurchaseHeader, PostDocument);
    end;

    local procedure ValidateCanCreatePurchaseDocument(var FacturaEHeader: Record "Cabecera FacturaE Recibida")
    var
        AlreadyPostedErr: Label 'Esta factura ya está registrada.';
        AlreadyOpenErr: Label 'Esta factura ya está cargada como factura en curso.';
        RejectedErr: Label 'Esta factura está rechazada, no se puede registrar.';
    begin
        FacturaEHeader.CalcFields(Registrada, "Documento en Curso", "Documento Registrado", "Abono Registrado");
        if FacturaEHeader.Registrada or (FacturaEHeader."Documento Registrado" <> '') or (FacturaEHeader."Abono Registrado" <> '') then
            Error(AlreadyPostedErr);
        if FacturaEHeader."Documento en Curso" <> '' then
            Error(AlreadyOpenErr);
        if FacturaEHeader.Rechazada then
            Error(RejectedErr);
    end;

    local procedure BuildPurchaseHeader(var FacturaEHeader: Record "Cabecera FacturaE Recibida"; var PurchaseHeader: Record "Purchase Header")
    var
        FacturaEDocumentMgt: Codeunit "FacturaE Document Mgt.";
    begin
        FacturaEHeader.TestField("Proveedor NAV");

        PurchaseHeader.Init();
        if FacturaEHeader.TOTAL_PAGAR >= 0 then
            PurchaseHeader.Validate("Document Type", PurchaseHeader."Document Type"::Invoice)
        else
            PurchaseHeader.Validate("Document Type", PurchaseHeader."Document Type"::"Credit Memo");
        PurchaseHeader.Insert(true);

        PurchaseHeader.Validate("Buy-from Vendor No.", FacturaEHeader."Proveedor NAV");
        PurchaseHeader.Validate("ID Plataforma FacturaE", FacturaEHeader.ID_PLATAFORMA);
        PurchaseHeader.Validate("Numero FacturaE", FacturaEHeader.NUM);
        PurchaseHeader.Validate("Document Date", FacturaEHeader.FECHA_DEVENGO);
        PurchaseHeader.Validate("Fecha recepcion documento", FacturaEHeader.FECHA_ENTRADA);
        PurchaseHeader.Validate("Posting Date", FacturaEHeader.FECHA_ENTRADA);
        PurchaseHeader."No. expediente adjudicacion" := FacturaEHeader.EXPEDIENTE;
        PurchaseHeader.Lote := FacturaEHeader.Lote;
        PurchaseHeader.Validate("Dimension Set ID", FacturaEHeader."Dimension Set ID");
        PurchaseHeader.Validate("Shortcut Dimension 1 Code", FacturaEHeader."Shortcut Dimension 1 Code");
        PurchaseHeader.Validate("Shortcut Dimension 2 Code", FacturaEHeader."Shortcut Dimension 2 Code");
        OnBeforeModifyPurchaseHeader(FacturaEHeader, PurchaseHeader);
        PurchaseHeader.Modify(true);

        FacturaEDocumentMgt.CopyDocumentLinksToPurchase(FacturaEHeader, PurchaseHeader);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnCreatePurchaseLines(var FacturaEHeader: Record "Cabecera FacturaE Recibida"; var PurchaseHeader: Record "Purchase Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnCopyPurchaseComments(var FacturaEHeader: Record "Cabecera FacturaE Recibida"; var PurchaseHeader: Record "Purchase Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnHandlePurchaseApproval(var FacturaEHeader: Record "Cabecera FacturaE Recibida"; var PurchaseHeader: Record "Purchase Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterCreatePurchaseDocument(var FacturaEHeader: Record "Cabecera FacturaE Recibida"; var PurchaseHeader: Record "Purchase Header"; PostDocument: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeModifyPurchaseHeader(var FacturaEHeader: Record "Cabecera FacturaE Recibida"; var PurchaseHeader: Record "Purchase Header")
    begin
    end;
}
