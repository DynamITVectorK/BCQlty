page 50026 "WS Consumos Agua y Elect"
{
    // //***Z029 - AT - 16/01/18 - Area Privada WEB
    //                             WS5 - Consumos agua y electricidad

    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    UsageCategory = Administration;
    SourceTable = 50003;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Area; Rec.Area)
                {
                    ApplicationArea = All;
                }
                field("No. Contador"; Rec."No. Contador")
                {
                    ApplicationArea = All;
                }
                field("No. Puesto/Pabellon"; Rec."No. Puesto/Pabellon")
                {
                    ApplicationArea = All;
                }
                field("Tarifa aplicada"; Rec."Tarifa aplicada")
                {
                    ApplicationArea = All;
                }
                field("Potencia contratada"; Rec."Potencia contratada")
                {
                    ApplicationArea = All;
                }
                field("Coeficiente TT"; Rec."Coeficiente TT")
                {
                    ApplicationArea = All;
                }
                field("Fecha lectura"; Rec."Fecha lectura")
                {
                    ApplicationArea = All;
                }
                field("Consumo HP"; Rec."Consumo HP")
                {
                    ApplicationArea = All;
                }
                field("Consumo HLL"; Rec."Consumo HLL")
                {
                    ApplicationArea = All;
                }
                field("Consumo HV"; Rec."Consumo HV")
                {
                    ApplicationArea = All;
                }
                field(Total; Rec.Total)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    var
        vlLimitDate: Date;
    begin
        Clear(tSalesReceivablesSetup);
        tSalesReceivablesSetup.Get();
        Clear(vlLimitDate);
        vlLimitDate := CalcDate('-' + Format(tSalesReceivablesSetup."Plazo desde para lecturas WEB"), WorkDate());
        Rec.SetFilter("Fecha lectura", '>%1', vlLimitDate);
        Rec.SetFilter("Fecha factura registrada", '<>%1', 0D);
        Rec.CalcFields("No Cliente", ClienteBloqueado, ContraseñaWeb);
        Rec.SetRange(ClienteBloqueado, false);
        Rec.SetFilter(ContraseñaWeb, '<>%1', '');
    end;

    var
        tSalesReceivablesSetup: Record "Sales & Receivables Setup";
        tCustomer: Record "Customer";
        tSalesHeader: Record "Sales Header";
}