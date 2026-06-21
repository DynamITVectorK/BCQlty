page 50026 "WS Consumos Agua y Elect"
{
    // //***Z029 - AT - 16/01/18 - Area Privada WEB
    //                             WS5 - Consumos agua y electricidad

    PageType = API;
    SourceTable = 50003;
    DelayedInsert = true;
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;
    Editable = false;
    Extensible = false;

    APIPublisher = 'zamundi';
    APIGroup = 'privateweb';
    APIVersion = 'v1.0';
    EntityName = 'waterElectricityConsumption';
    EntitySetName = 'waterElectricityConsumptions';
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
                field(area; Rec.Area)
                {
                    Caption = 'Area';
                    Editable = false;
                }
                field(noContador; Rec."No. Contador")
                {
                    Caption = 'No. Contador';
                    Editable = false;
                }
                field(noPuestoPabellon; Rec."No. Puesto/Pabellon")
                {
                    Caption = 'No. Puesto/Pabellon';
                    Editable = false;
                }
                field(tarifaAplicada; Rec."Tarifa aplicada")
                {
                    Caption = 'Tarifa aplicada';
                    Editable = false;
                }
                field(potenciaContratada; Rec."Potencia contratada")
                {
                    Caption = 'Potencia contratada';
                    Editable = false;
                }
                field(coeficienteTT; Rec."Coeficiente TT")
                {
                    Caption = 'Coeficiente TT';
                    Editable = false;
                }
                field(fechaLectura; Rec."Fecha lectura")
                {
                    Caption = 'Fecha lectura';
                    Editable = false;
                }
                field(consumoHP; Rec."Consumo HP")
                {
                    Caption = 'Consumo HP';
                    Editable = false;
                }
                field(consumoHLL; Rec."Consumo HLL")
                {
                    Caption = 'Consumo HLL';
                    Editable = false;
                }
                field(consumoHV; Rec."Consumo HV")
                {
                    Caption = 'Consumo HV';
                    Editable = false;
                }
                field(total; Rec.Total)
                {
                    Caption = 'Total';
                    Editable = false;
                }
            }
        }
    }

    trigger OnOpenPage()
    var
        LimitDate: Date;
    begin
        Clear(SalesReceivablesSetup);
        SalesReceivablesSetup.Get();

        Clear(LimitDate);
        LimitDate := CalcDate('-' + Format(SalesReceivablesSetup."Plazo desde para lecturas WEB"), WorkDate());

        Rec.SetFilter("Fecha lectura", '>%1', LimitDate);
        Rec.SetFilter("Fecha factura registrada", '<>%1', 0D);
        Rec.CalcFields("No Cliente", ClienteBloqueado, ContraseñaWeb);
        Rec.SetRange(ClienteBloqueado, false);
        Rec.SetFilter(ContraseñaWeb, '<>%1', '');
    end;

    var
        SalesReceivablesSetup: Record "Sales & Receivables Setup";
}