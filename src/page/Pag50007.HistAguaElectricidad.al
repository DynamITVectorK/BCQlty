page 50007 "Hist. Agua /Electricidad"
{
    // //***Z002 - 400 - RG- 11/11/2016 - Gestión de lecturas de agua / electricidad nuevo objeto

    DataCaptionFields = Area;
    Editable = false;
    PageType = List;
    UsageCategory = Administration;
    PromotedActionCategories = 'Nuevo,Proceso,Informes,Lecturas';
    SourceTable = 50003;
    SourceTableView = SORTING(Area, "Fecha lectura", "No. Contador")
                      ORDER(Ascending);

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
                field("No. Orden de lectura"; Rec."No. Orden de lectura")
                {
                    ApplicationArea = All;
                }
                field("Nombre cliente"; Rec."Nombre cliente")
                {
                    ApplicationArea = All;
                }
                field("No. contrato"; Rec."No. contrato")
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
                field("Código Incidencia"; Rec."Código Incidencia")
                {
                    ApplicationArea = All;
                }
                field("Fecha lectura"; Rec."Fecha lectura")
                {
                    ApplicationArea = All;
                }
                field("Lectura HP"; Rec."Lectura HP")
                {
                    ApplicationArea = All;
                }
                field("Consumo HP"; Rec."Consumo HP")
                {
                    ApplicationArea = All;
                }
                field("Lectura HLL"; Rec."Lectura HLL")
                {
                    ApplicationArea = All;
                }
                field("Consumo HLL"; Rec."Consumo HLL")
                {
                    ApplicationArea = All;
                }
                field("Lectura HV"; Rec."Lectura HV")
                {
                    ApplicationArea = All;
                }
                field("Consumo HV"; Rec."Consumo HV")
                {
                    ApplicationArea = All;
                }
                field("Lectura B2"; Rec."Lectura B2")
                {
                    ApplicationArea = All;
                }
                field("Consumo B2"; Rec."Consumo B2")
                {
                    ApplicationArea = All;
                }
                field(Total; Rec.Total)
                {
                    ApplicationArea = All;
                }
                field("No. Pre factura"; Rec."No. Pre factura")
                {
                    ApplicationArea = All;
                }
                field("No. Factura registrada"; Rec."No. Factura registrada")
                {
                    ApplicationArea = All;
                }
                field("Fecha factura registrada"; Rec."Fecha factura registrada")
                {
                    ApplicationArea = All;
                }
                field("Tarifa aplicada"; Rec."Tarifa aplicada")
                {
                    ApplicationArea = All;
                }
                field(Pabellon; Rec.Pabellon)
                {
                    ApplicationArea = All;
                }
                field("Tipo Consumo"; Rec."Tipo Consumo")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            group(botones)
            {
                Caption = 'botones';
                action("Ficha Contador")
                {
                    ApplicationArea = All;
                    Image = CostCenter;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    RunObject = Page Contadores;
                    RunPageLink = "No. Contador" = FIELD("No. Contador");
                }
                action(Contratos)
                {
                    ApplicationArea = All;
                    Caption = 'Contratos';
                    Image = "Order";
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        SalesHeader: Record "Sales Header";
                    begin
                        SalesHeader.SetCurrentKey("Document Type", "Sell-to Contact No.");
                        SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::Order);
                        SalesHeader.SetRange("No.", Rec."No. contrato");
                        if SalesHeader.FindFirst() then
                            Page.Run(Page::"Sales Order", SalesHeader)
                        else
                            Message(NoContractMsg, Rec."No. Contador");
                    end;
                }
                action("Ver factura")
                {
                    ApplicationArea = All;
                    Caption = 'Ver factura';
                    Image = Invoice;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        SalesHeader: Record "Sales Header";
                        SalesInvoiceHeader: Record "Sales Invoice Header";
                    begin
                        if Rec."No. Factura registrada" <> '' then begin
                            Clear(SalesInvoiceHeader);
                            SalesInvoiceHeader.Get(Rec."No. Factura registrada");
                            Page.Run(Page::"Posted Sales Invoice", SalesInvoiceHeader);
                        end else
                            if Rec."No. Pre factura" <> '' then begin
                                if SalesHeader.Get(SalesHeader."Document Type"::Invoice, Rec."No. Pre factura") then
                                    Page.Run(Page::"Sales Invoice", SalesHeader);
                            end else
                                Message(NoInvoicesMsg, Rec."No. Contador");
                    end;
                }
                action("Modificar Lectura ")
                {
                    ApplicationArea = All;
                    Caption = 'Modificar Lectura';
                    Image = UpdateDescription;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        RLect: Record 50003;
                    begin
                        if (Rec."No. Factura registrada" <> '') or (Rec."No. Pre factura" <> '') then
                            Error(LT50000);

                        if HayLecturasPosteriores(Rec) then
                            Error(LT50001);

                        Clear(LectTB);
                        LectTB.SetCurrentKey("No. Contador", "Fecha lectura");
                        LectTB.SetRange("No. Contador", Rec."No. Contador");
                        ConfVtas.Get();

                        if ConfVtas."Cantidad últimas lectura" <> 0 then begin
                            if LectTB.Count() < ConfVtas."Cantidad últimas lectura" then
                                registros := Rec.Count()
                            else
                                registros := ConfVtas."Cantidad últimas lectura";

                            if LectTB.FindLast() then
                                for i := 1 to registros - 1 do
                                    LectTB.Next(-1);
                        end;

                        RLect.SetCurrentKey("No. Contador", "Fecha lectura");
                        RLect.SetRange("No. Contador", Rec."No. Contador");
                        RLect.SetFilter("Fecha lectura", '%1..', LectTB."Fecha lectura");
                        PgLecturas.ContadorALeer(Rec."No. Contador");
                        PgLecturas.LecturaAmodificar(Rec);
                        PgLecturas.SetTableView(RLect);
                        PgLecturas.SetRecord(RLect);
                        PgLecturas.Run();
                    end;
                }
                action("Borrar Lectura ")
                {
                    ApplicationArea = All;
                    Caption = 'Borrar Lectura';
                    Image = Delete;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        if (Rec."No. Factura registrada" <> '') or (Rec."No. Pre factura" <> '') then
                            Error(LT50000);

                        if HayLecturasPosteriores(Rec) then
                            Error(LT50001);

                        if Confirm(LT50002, false, Rec."No. Contador", Rec."Fecha lectura") then
                            Rec.Delete(true);
                    end;
                }
                action("Nueva lectura ")
                {
                    ApplicationArea = All;
                    Image = NewDocument;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        RLect: Record 50003;
                    begin
                        Clear(LectTB);
                        LectTB.SetCurrentKey("No. Contador", "Fecha lectura");
                        LectTB.SetRange("No. Contador", Rec."No. Contador");
                        ConfVtas.Get();

                        if ConfVtas."Cantidad últimas lectura" <> 0 then begin
                            if LectTB.Count() < ConfVtas."Cantidad últimas lectura" then
                                registros := Rec.Count()
                            else
                                registros := ConfVtas."Cantidad últimas lectura";

                            if LectTB.FindLast() then
                                for i := 1 to registros - 1 do
                                    LectTB.Next(-1);
                        end;

                        RLect.SetCurrentKey("No. Contador", "Fecha lectura");
                        RLect.SetRange("No. Contador", Rec."No. Contador");
                        RLect.SetFilter("Fecha lectura", '%1..', LectTB."Fecha lectura");
                        PgLecturas.ContadorALeer(Rec."No. Contador");
                        PgLecturas.SetTableView(RLect);
                        PgLecturas.SetRecord(RLect);
                        PgLecturas.Run();
                    end;
                }
                action("Ver Incidencia")
                {
                    ApplicationArea = All;
                    Image = ErrorLog;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        Rinc: Record 50004;
                        PageInc: Page "Ficha de Incidencias";
                    begin
                        if Rec."Código Incidencia" <> '' then
                            if Rinc.Get(Rec."Código Incidencia") then begin
                                PageInc.SetTableView(Rinc);
                                PageInc.SetRecord(Rinc);
                                PageInc.Run();
                            end;
                    end;
                }
            }
        }
    }

    var
        LectTB: Record 50003;
        LT50000: Label 'La Lectura ya tiene Factura';
        LT50001: Label 'La Lectura no se puede modificar porque tiene lecturas posteriores';
        ConfVtas: Record "Sales & Receivables Setup";
        registros: Integer;
        i: Integer;
        PgLecturas: Page "Ficha Lecturas";
        LT50002: Label '¿Desea eliminar la lectura %1 del día %2?';
        NoOrdenLectura: Integer;
        Contador: Record 50002;
        NoContractMsg: Label 'No hay contrato para %1';
        NoInvoicesMsg: Label 'No hay Facturas para %1';
}