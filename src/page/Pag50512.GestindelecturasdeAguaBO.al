page 50512 "Gestión de lecturas de Agua BO"
{
    // //***Z002 - 400 - RG- 14/11/2016 - Gestión de lecturas de agua / electricidad ** nueva page

    Editable = false;
    PageType = List;
    UsageCategory = Administration;
    PromotedActionCategories = 'Nuevo,Proceso,Informes,Lecturas';
    SourceTable = 50002;
    SourceTableView = SORTING (Area, No. Orden de lectura)
                      ORDER(Ascending)
                      WHERE (Area = CONST (Agua),
                            Estado = CONST (Activo));

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
            systempart(; Notes)
            {
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
                        PageLectura: Page 50007;
                        RLect: Record 50003;
                    begin
                        CLEAR(LectTB);
                        LectTB.SETCURRENTKEY("No. Contador", "Fecha lectura");
                        LectTB.SETRANGE(LectTB."No. Contador", "No. Contador");
                        IF NOT LectTB.FINDFIRST THEN
                            CrearLineaLectura;
                        ConfVtas.GET;
                        IF ConfVtas."Cantidad últimas lectura" <> 0 THEN BEGIN

                            IF LectTB.COUNT < ConfVtas."Cantidad últimas lectura" THEN
                                registros := Rec.COUNT
                            ELSE
                                registros := ConfVtas."Cantidad últimas lectura";

                            IF LectTB.FINDLAST THEN
                                FOR i := 1 TO registros - 1 DO BEGIN
                                    LectTB.NEXT(-1)
                                END
                        END;
                        //LectTB.MARKEDONLY(TRUE);

                        RLect.SETCURRENTKEY("No. Contador", "Fecha lectura");
                        RLect.SETRANGE("No. Contador", "No. Contador");
                        //RLect.SETFILTER("Fecha lectura",'%1..',LectTB."Fecha lectura");
                        PgLecturas.ContadorALeer("No. Contador");
                        PgLecturas.SETTABLEVIEW(RLect);
                        PgLecturas.SETRECORD(RLect);
                        PgLecturas.RUN;
                    end;
                }
                action("Ficha Contador")
                {
                    ApplicationArea = All;
                    Image = CostCenter;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    RunObject = Page 50006;
                    RunPageLink = No. Contador=FIELD(No. Contador);
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
                        ped: Record "Sales Header";
                    begin
                        ped.SETCURRENTKEY("Document Type","Sell-to Contact No.");
                        ped.SETRANGE("Document Type", ped."Document Type"::Order);
                        ped.SETRANGE("No.", "No. Contrato");
                        IF ped.FINDFIRST THEN
                        PAGE.RUN(42,ped)
                        ELSE
                          MESSAGE('No hay contrato para %1', "No. Contador")
                    end;
                }
                action("Histórico de Lecturas")
                {
                    ApplicationArea = All;
                    Image = History;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    RunObject = Page 50007;
                                    RunPageLink = No. Contador=FIELD(No. Contador);
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
        PgLecturas: Page 50009;

    local procedure CrearLineaLectura()
    var
        AUXLectTB: Record 50003;
    begin
        /*CLEAR(AUXLectTB);
        IF AUXLectTB.FINDLAST THEN
          numlin:=1000
        ELSE
          numlin:= AUXLectTB."Nº movimiento" + 1000;
          */
        LectTB.INIT;
        LectTB.VALIDATE("No. Contador", "No. Contador");
        LectTB.INSERT;

    end;
}

