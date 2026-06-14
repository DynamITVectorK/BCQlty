codeunit 50007 "FacturaE Recibida Mgt."
{
    Access = Internal;

    procedure DeleteRelatedData(var FacturaEHeader: Record "Cabecera FacturaE Recibida")
    var
        FacturaELine: Record "Linea FacturaE Recibida";
        FacturaETax: Record "Tasa FacturaE Recibida";
    begin
        FacturaELine.SetRange("ID Factura", FacturaEHeader.ID_PLATAFORMA);
        FacturaELine.DeleteAll(true);

        FacturaETax.SetRange("ID Factura", FacturaEHeader.ID_PLATAFORMA);
        FacturaETax.DeleteAll(true);
    end;

    procedure PropagateExpedienteToLines(var FacturaEHeader: Record "Cabecera FacturaE Recibida")
    var
        FacturaELine: Record "Linea FacturaE Recibida";
    begin
        FacturaELine.SetRange("ID Factura", FacturaEHeader.ID_PLATAFORMA);
        if FacturaELine.FindSet(true) then
            repeat
                FacturaELine.Validate(EXPEDIENTE, FacturaEHeader.EXPEDIENTE);
                FacturaELine.Modify(true);
            until FacturaELine.Next() = 0;

        OnAfterPropagateExpedienteToLines(FacturaEHeader);
    end;

    procedure PropagateLoteToLines(var FacturaEHeader: Record "Cabecera FacturaE Recibida")
    var
        FacturaELine: Record "Linea FacturaE Recibida";
    begin
        FacturaELine.SetRange("ID Factura", FacturaEHeader.ID_PLATAFORMA);
        if FacturaELine.FindSet(true) then
            repeat
                FacturaELine.Validate(Lote, FacturaEHeader.Lote);
                FacturaELine.Modify(true);
            until FacturaELine.Next() = 0;

        OnAfterPropagateLoteToLines(FacturaEHeader);
    end;

    procedure CheckFacturaEAmount(PurchaseHeader: Record "Purchase Header")
    var
        FacturaEHeader: Record "Cabecera FacturaE Recibida";
        PurchaseLine: Record "Purchase Line";
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
        InvoiceAmount: Decimal;
        ToleranceAmount: Decimal;
        AmountErr: Label 'El importe de la factura (%1) aplicando la tolerancia (%2) es distinto del total de la factura proveniente de Facturación electrónica (%3).';
    begin
        if (PurchaseHeader."ID Plataforma FacturaE" = '') or (PurchaseHeader."Numero FacturaE" = '') then
            exit;

        PurchaseLine.SetRange("Document Type", PurchaseHeader."Document Type");
        PurchaseLine.SetRange("Document No.", PurchaseHeader."No.");
        if PurchaseLine.FindSet() then
            repeat
                InvoiceAmount += PurchaseLine."Line Amount";
            until PurchaseLine.Next() = 0;

        if not FacturaEHeader.Get(PurchaseHeader."ID Plataforma FacturaE", PurchaseHeader."Numero FacturaE") then
            exit;

        if PurchasesPayablesSetup.Get() then
            OnGetFacturaEAmountTolerance(PurchasesPayablesSetup, ToleranceAmount);

        if (FacturaEHeader.TOTAL_PAGAR > InvoiceAmount + ToleranceAmount) or
           (FacturaEHeader.TOTAL_PAGAR < InvoiceAmount - ToleranceAmount) then
            Error(AmountErr, InvoiceAmount, ToleranceAmount, FacturaEHeader.TOTAL_PAGAR);
    end;

    procedure RejectFacturaE(var FacturaEHeader: Record "Cabecera FacturaE Recibida")
    begin
        FacturaEHeader.CalcFields("Documento en Curso", "Documento Registrado");
        FacturaEHeader.TestField("Documento en Curso", '');
        FacturaEHeader.TestField("Documento Registrado", '');
        FacturaEHeader.TestField(Rechazada, false);
        FacturaEHeader.TestField("Motivo rechazo");

        OnBeforeRejectFacturaE(FacturaEHeader);
        FacturaEHeader.Rechazada := true;
        FacturaEHeader."Approval Status" := FacturaEHeader."Approval Status"::Rejected;
        FacturaEHeader.Modify(true);
        OnAfterRejectFacturaE(FacturaEHeader);
    end;

    procedure ApproveFacturaE(var FacturaEHeader: Record "Cabecera FacturaE Recibida")
    begin
        FacturaEHeader.TestField(Rechazada, false);
        OnBeforeApproveFacturaE(FacturaEHeader);
        FacturaEHeader."Approval Status" := FacturaEHeader."Approval Status"::Approved;
        FacturaEHeader.Modify(true);
        OnAfterApproveFacturaE(FacturaEHeader);
    end;

    procedure LinesExist(FacturaEHeader: Record "Cabecera FacturaE Recibida"): Boolean
    var
        FacturaELine: Record "Linea FacturaE Recibida";
    begin
        FacturaELine.SetRange("ID Factura", FacturaEHeader.ID_PLATAFORMA);
        exit(not FacturaELine.IsEmpty());
    end;

    procedure UpdateAllLineDim(var FacturaEHeader: Record "Cabecera FacturaE Recibida"; NewParentDimSetID: Integer; OldParentDimSetID: Integer)
    var
        FacturaELine: Record "Linea FacturaE Recibida";
        DimensionManagement: Codeunit DimensionManagement;
        NewDimSetID: Integer;
    begin
        if NewParentDimSetID = OldParentDimSetID then
            exit;

        FacturaELine.SetRange("ID Factura", FacturaEHeader.ID_PLATAFORMA);
        FacturaELine.LockTable();
        if FacturaELine.FindSet(true) then
            repeat
                NewDimSetID := DimensionManagement.GetDeltaDimSetID(FacturaELine."Dimension Set ID", NewParentDimSetID, OldParentDimSetID);
                if FacturaELine."Dimension Set ID" <> NewDimSetID then begin
                    FacturaELine."Dimension Set ID" := NewDimSetID;
                    DimensionManagement.UpdateGlobalDimFromDimSetID(FacturaELine."Dimension Set ID", FacturaELine."Shortcut Dimension 1 Code", FacturaELine."Shortcut Dimension 2 Code");
                    FacturaELine.Modify(true);
                end;
            until FacturaELine.Next() = 0;
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterPropagateExpedienteToLines(var FacturaEHeader: Record "Cabecera FacturaE Recibida")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterPropagateLoteToLines(var FacturaEHeader: Record "Cabecera FacturaE Recibida")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnGetFacturaEAmountTolerance(PurchasesPayablesSetup: Record "Purchases & Payables Setup"; var ToleranceAmount: Decimal)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeRejectFacturaE(var FacturaEHeader: Record "Cabecera FacturaE Recibida")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterRejectFacturaE(var FacturaEHeader: Record "Cabecera FacturaE Recibida")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeApproveFacturaE(var FacturaEHeader: Record "Cabecera FacturaE Recibida")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterApproveFacturaE(var FacturaEHeader: Record "Cabecera FacturaE Recibida")
    begin
    end;
}
