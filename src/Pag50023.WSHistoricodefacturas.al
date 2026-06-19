page 50023 "WS Historico de facturas"
{
    // //***Z029 - AT - 16/01/18 - Area Privada WEB
    //                             WS2.1 - Histórico de facturas

    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = Table112;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Bill-to Customer No."; "Bill-to Customer No.")
                {
                }
                field("Posting Date"; "Posting Date")
                {
                }
                field("No."; "No.")
                {
                }
                field(Amount; Amount)
                {
                }
                field("Importe IVA"; vIVA)
                {
                }
                field("Amount Including VAT"; "Amount Including VAT")
                {
                }
                field("Posting Description"; "Posting Description")
                {
                }
                field(Fichero_Base_64; vFicheroBase64)
                {
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
        tSalesReceivablesSetup: Record "311";
}

