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
                field("Bill-to Customer No."; "Bill-to Customer No.")
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; "Posting Date")
                {
                    ApplicationArea = All;
                }
                field("No."; "No.")
                {
                    ApplicationArea = All;
                }
                field(Amount; Amount)
                {
                    ApplicationArea = All;
                }
                field("Importe IVA"; vIVA)
                {
                    ApplicationArea = All;
                }
                field("Amount Including VAT"; "Amount Including VAT")
                {
                    ApplicationArea = All;
                }
                field("Posting Description"; "Posting Description")
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
        CLEAR(vIVA);
        vIVA := "Amount Including VAT" - Amount;

        // Formato Base64
        fConvertValueToBase64(vFicheroBase64);
    end;

    trigger OnOpenPage()
    var
        vlLimitDate: Date;
    begin
        CLEAR(tSalesReceivablesSetup);
        tSalesReceivablesSetup.GET;
        CLEAR(vlLimitDate);
        vlLimitDate := CALCDATE('-' + FORMAT(tSalesReceivablesSetup."Plazo desde para docs WEB"), WORKDATE);
        SETFILTER("Posting Date", '>%1', vlLimitDate);

        CALCFIELDS(ClienteBloqueado, ContraseñaWeb);
        SETRANGE(ClienteBloqueado, FALSE);
        SETFILTER(ContraseñaWeb, '<>%1', '');
    end;

    var
        vIVA: Decimal;
        vFicheroBase64: BigText;
        tSalesReceivablesSetup: Record "Sales & Receivables Setup";
}

