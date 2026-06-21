page 50024 "WS Historico de abonos"
{
    // //***Z029 - AT - 16/01/18 - Area Privada WEB
    //                             WS3.1 - Histórico de abonos

    PageType = API;
    SourceTable = "Sales Cr.Memo Header";
    DelayedInsert = true;
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;
    Editable = false;
    Extensible = false;

    APIPublisher = 'zamundi';
    APIGroup = 'privateweb';
    APIVersion = 'v1.0';
    EntityName = 'salesCreditMemoHistory';
    EntitySetName = 'salesCreditMemoHistories';
    ODataKeyFields = SystemId;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(id; Rec.SystemId)
                {
                    Caption = 'Id';
                    Editable = false;
                }
                field(billToCustomerNo; Rec."Bill-to Customer No.")
                {
                    Caption = 'Bill-to Customer No.';
                    Editable = false;
                }
                field(postingDate; Rec."Posting Date")
                {
                    Caption = 'Posting Date';
                    Editable = false;
                }
                field(no; Rec."No.")
                {
                    Caption = 'No.';
                    Editable = false;
                }
                field(amount; Rec.Amount)
                {
                    Caption = 'Amount';
                    Editable = false;
                }
                field(importeIVA; vIVA)
                {
                    Caption = 'Importe IVA';
                    Editable = false;
                }
                field(amountIncludingVAT; Rec."Amount Including VAT")
                {
                    Caption = 'Amount Including VAT';
                    Editable = false;
                }
                field(postingDescription; Rec."Posting Description")
                {
                    Caption = 'Posting Description';
                    Editable = false;
                }
                field(ficheroBase64; vFicheroBase64)
                {
                    Caption = 'Fichero_Base_64';
                    Editable = false;
                }
            }
        }
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
        LimitDate: Date;
    begin
        Clear(SalesReceivablesSetup);
        SalesReceivablesSetup.Get();

        Clear(LimitDate);
        LimitDate := CalcDate('-' + Format(SalesReceivablesSetup."Plazo desde para docs WEB"), WorkDate());
        Rec.SetFilter("Posting Date", '>%1', LimitDate);

        Rec.CalcFields(ClienteBloqueado, ContraseñaWeb);
        Rec.SetRange(ClienteBloqueado, false);
        Rec.SetFilter(ContraseñaWeb, '<>%1', '');
    end;

    var
        vIVA: Decimal;
        vFicheroBase64: BigText;
        SalesReceivablesSetup: Record "Sales & Receivables Setup";
}