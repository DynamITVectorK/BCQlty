page 50023 "WS Historico de facturas"
{
    // //***Z029 - AT - 16/01/18 - Area Privada WEB
    //                             WS2.1 - Histórico de facturas

    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    UsageCategory = Administration;
    SourceTable = "Sales Invoice Header";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Bill-to Customer No."; Rec."Bill-to Customer No.")
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                }
                field("Importe IVA"; vIVA)
                {
                    ApplicationArea = All;
                }
                field("Amount Including VAT"; Rec."Amount Including VAT")
                {
                    ApplicationArea = All;
                }
                field("Posting Description"; Rec."Posting Description")
                {
                    ApplicationArea = All;
                }
                field(Fichero_Base_64; vFicheroBase64)
                {
                    ApplicationArea = All;
                    Caption = 'Fichero_Base_64';
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        // Calcular Importe IVA
        Clear(vIVA);
        vIVA := Rec."Amount Including VAT" - Rec.Amount;

        // Formato Base64
        fConvertValueToBase64(vFicheroBase64);
    end;

    trigger OnOpenPage()
    var
        vlLimitDate: Date;
    begin
        Clear(tSalesReceivablesSetup);
        tSalesReceivablesSetup.Get();
        Clear(vlLimitDate);
        vlLimitDate := CalcDate('-' + Format(tSalesReceivablesSetup."Plazo desde para docs WEB"), WorkDate());
        Rec.SetFilter("Posting Date", '>%1', vlLimitDate);

        Rec.CalcFields(ClienteBloqueado, ContraseñaWeb);
        Rec.SetRange(ClienteBloqueado, false);
        Rec.SetFilter(ContraseñaWeb, '<>%1', '');
    end;

    var
        vIVA: Decimal;
        vFicheroBase64: BigText;
        tSalesReceivablesSetup: Record "Sales & Receivables Setup";
}