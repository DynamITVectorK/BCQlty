page 50512 "Gestión de lecturas de Agua BO"
{
    // //***Z002 - 400 - RG- 14/11/2016 - Gestión de lecturas de agua / electricidad ** nueva page

    Editable = false;
    PageType = List;
    UsageCategory = Administration;
    SourceTable = 50002;
    SourceTableView = SORTING(Area, "No. Orden de lectura")
                      ORDER(Ascending)
                      WHERE(Area = CONST(Agua),
                            Estado = CONST(Activo));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No. Orden de lectura"; Rec."No. Orden de lectura")
                {
                    ApplicationArea = All;
                }
                field("No. puesto"; Rec."No. puesto")
                {
                    ApplicationArea = All;
                }
                field("No. Contador"; Rec."No. Contador")
                {
                    ApplicationArea = All;
                }
                field("Nombre cliente"; Rec."Nombre cliente")
                {
                    ApplicationArea = All;
                }
                field("No. Contrato"; Rec."No. Contrato")
                {
                    ApplicationArea = All;
                }
                field(Destino; Rec.Destino)
                {
                    ApplicationArea = All;
                }
                field(Tarifa; Rec.Tarifa)
                {
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
            systempart(Notes; Notes)
            {
                ApplicationArea = All;
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
                action("Nueva lectura ")
                {
                    ApplicationArea = All;
                    Image = NewDocument;

                    trigger OnAction()
                    var
                        RLect: Record 50003;
                    begin
                        Clear(LectTB);
                        LectTB.SetCurrentKey("No. Contador", "Fecha lectura");
                        LectTB.SetRange("No. Contador", Rec."No. Contador");
                        if not LectTB.FindFirst() then
                            CrearLineaLectura();

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

                        //LectTB.MARKEDONLY(TRUE);
                        RLect.SetCurrentKey("No. Contador", "Fecha lectura");
                        RLect.SetRange("No. Contador", Rec."No. Contador");
                        //RLect.SETFILTER("Fecha lectura",'%1..',LectTB."Fecha lectura");
                        PgLecturas.ContadorALeer(Rec."No. Contador");
                        PgLecturas.SetTableView(RLect);
                        PgLecturas.SetRecord(RLect);
                        PgLecturas.Run();
                    end;
                }
                action("Ficha Contador")
                {
                    ApplicationArea = All;
                    Image = CostCenter;
                    RunObject = Page Contadores;
                    RunPageLink = "No. Contador" = FIELD("No. Contador");
                }
                action(Contratos)
                {
                    ApplicationArea = All;
                    Caption = 'Contratos';
                    Image = "Order";

                    trigger OnAction()
                    var
                        SalesHeader: Record "Sales Header";
                    begin
                        SalesHeader.SetCurrentKey("Document Type", "Sell-to Contact No.");
                        SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::Order);
                        SalesHeader.SetRange("No.", Rec."No. Contrato");
                        if SalesHeader.FindFirst() then
                            Page.Run(Page::"Sales Order", SalesHeader)
                        else
                            Message(NoContractMsg, Rec."No. Contador");
                    end;
                }
                action("Histórico de Lecturas")
                {
                    ApplicationArea = All;
                    Image = History;
                    RunObject = Page "Hist. Agua /Electricidad";
                    RunPageLink = "No. Contador" = FIELD("No. Contador");
                }
            }
        }
        area(Promoted)
        {
            group(Category_Lecturas)
            {
                Caption = 'Lecturas';

                actionref(NuevaLectura_Promoted; "Nueva lectura ")
                {
                }
                actionref(FichaContador_Promoted; "Ficha Contador")
                {
                }
                actionref(Contratos_Promoted; Contratos)
                {
                }
                actionref(HistoricoLecturas_Promoted; "Histórico de Lecturas")
                {
                }
            }
        }
    }

    var
        LectTB: Record 50003;
        ConfVtas: Record "Sales & Receivables Setup";
        registros: Integer;
        i: Integer;
        PgLecturas: Page "Ficha Lecturas";
        NoContractMsg: Label 'No hay contrato para %1';

    local procedure CrearLineaLectura()
    begin
        /*CLEAR(AUXLectTB);
        IF AUXLectTB.FINDLAST THEN
          numlin:=1000
        ELSE
          numlin:= AUXLectTB."Nº movimiento" + 1000;
          */
        LectTB.Init();
        LectTB.Validate("No. Contador", Rec."No. Contador");
        LectTB.Insert();
    end;
}