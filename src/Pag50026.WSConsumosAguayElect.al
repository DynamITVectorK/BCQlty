page 50026 "WS Consumos Agua y Elect"
{
    // //***Z029 - AT - 16/01/18 - Area Privada WEB
    //                             WS5 - Consumos agua y electricidad

    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = Table50003;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Area;Area)
        {
        }
                field("No. Contador";"No. Contador")
                {
                }
                field("No. Puesto/Pabellon";"No. Puesto/Pabellon")
                {
                }
                field("Tarifa aplicada";"Tarifa aplicada")
                {
                }
                field("Potencia contratada";"Potencia contratada")
                {
                }
                field("Coeficiente TT";"Coeficiente TT")
                {
                }
                field("Fecha lectura";"Fecha lectura")
                {
                }
                field("Consumo HP";"Consumo HP")
                {
                }
                field("Consumo HLL";"Consumo HLL")
                {
                }
                field("Consumo HV";"Consumo HV")
                {
                }
                field(Total;Total)
                {
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
        tSalesReceivablesSetup: Record "311";
        tCustomer: Record "18";
        tSalesHeader: Record "36";
}

