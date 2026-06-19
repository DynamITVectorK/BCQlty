page 50512 "Gestión de lecturas de Agua BO"
{
    // //***Z002 - 400 - RG- 14/11/2016 - Gestión de lecturas de agua / electricidad ** nueva page

    Editable = false;
    PageType = List;
    PromotedActionCategories = 'Nuevo,Proceso,Informes,Lecturas';
    SourceTable = Table50002;
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
                field("No. Orden de lectura"; "No. Orden de lectura")
                {
                }
                field("No. puesto"; "No. puesto")
                {
                }
                field("No. Contador"; "No. Contador")
                {
                }
                field("Nombre cliente"; "Nombre cliente")
                {
                }
                field("No. Contrato"; "No. Contrato")
                {
                }
                field(Destino; Destino)
                {
                }
                field(Tarifa; Tarifa)
                {
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
                    Image = NewDocument;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        PageLectura: Page "50007";
                        RLect: Record "50003";
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
                    Image = CostCenter;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    RunObject = Page 50006;
                    RunPageLink = No. Contador=FIELD(No. Contador);
                }
                action(Contratos)
                {
                    Caption = 'Contratos';
                    Image = "Order";
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        ped: Record "36";
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
        LectTB: Record "50003";
        numlin: Decimal;
        ConfVtas: Record "311";
        registros: Integer;
        i: Integer;
        PgLecturas: Page "50009";

    local procedure CrearLineaLectura()
    var
        AUXLectTB: Record "50003";
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

