page 50008 "Gestión de lecturas "
{
    // //***Z002 - 400 - RG- 14/11/2016 - Gestión de lecturas de agua / electricidad ** nueva page

    Caption = 'Gestión de lecturas ';
    Editable = false;
    PageType = List;
    UsageCategory = Administration;
    PromotedActionCategories = 'Nuevo,Proceso,Informes,Lecturas';
    SourceTable = 50002;
    SourceTableView = SORTING("No. Orden de lectura")
                      ORDER(Ascending)
                      WHERE(Estado = CONST(Activo));

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
                field(Condensadores; Rec.Condensadores)
                {
                    ApplicationArea = All;
                }
                field("Tipo contador"; Rec."Tipo contador")
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
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        RLect: Record 50003;
                    begin
                        if Rec."No. Contador" = '' then
                            Error(GT50000);

                        Clear(LectTB);
                        //LectTB.SETCURRENTKEY("Nº Contador (DF*)","Nº movimiento");
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
                        RLect.SetFilter("Fecha lectura", '%1..', LectTB."Fecha lectura");
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
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    RunObject = Page "Hist. Agua /Electricidad";
                    RunPageLink = "No. Contador" = FIELD("No. Contador");
                }
            }
        }
    }

    var
        LectTB: Record 50003;
        numlin: Decimal;
        ConfVtas: Record "Sales & Receivables Setup";
        registros: Integer;
        i: Integer;
        PgLecturas: Page "Ficha Lecturas";
        GT50000: Label 'Por favor, seleccione un contador';
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