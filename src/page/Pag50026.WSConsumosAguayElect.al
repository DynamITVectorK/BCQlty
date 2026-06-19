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
                field(Area;Area)
        {
            ApplicationArea = All;
        }
                field("No. Contador";"No. Contador")
                {
                    ApplicationArea = All;
                }
                field("No. Puesto/Pabellon";"No. Puesto/Pabellon")
                {
                    ApplicationArea = All;
                }
                field("Tarifa aplicada";"Tarifa aplicada")
                {
                    ApplicationArea = All;
                }
                field("Potencia contratada";"Potencia contratada")
                {
                    ApplicationArea = All;
                }
                field("Coeficiente TT";"Coeficiente TT")
                {
                    ApplicationArea = All;
                }
                field("Fecha lectura";"Fecha lectura")
                {
                    ApplicationArea = All;
                }
                field("Consumo HP";"Consumo HP")
                {
                    ApplicationArea = All;
                }
                field("Consumo HLL";"Consumo HLL")
                {
                    ApplicationArea = All;
                }
                field("Consumo HV";"Consumo HV")
                {
                    ApplicationArea = All;
                }
                field(Total;Total)
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
        CLEAR(tSalesReceivablesSetup);
        tSalesReceivablesSetup.GET;
        CLEAR(vlLimitDate);
        vlLimitDate := CALCDATE('-' +FORMAT(tSalesReceivablesSetup."Plazo desde para lecturas WEB"),WORKDATE);
        SETFILTER("Fecha lectura",'>%1', vlLimitDate);
        SETFILTER("Fecha factura registrada", '<>%1', 0D);
        CALCFIELDS("No Cliente",ClienteBloqueado,ContraseñaWeb);
        SETRANGE(ClienteBloqueado,FALSE);
        SETFILTER(ContraseñaWeb,'<>%1', '');
    end;

    var
        tSalesReceivablesSetup: Record "Sales & Receivables Setup";
        tCustomer: Record "Customer";
        tSalesHeader: Record "Sales Header";
}

