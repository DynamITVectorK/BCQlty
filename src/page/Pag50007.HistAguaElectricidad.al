page 50007 "Hist. Agua /Electricidad"
{
    // //***Z002 - 400 - RG- 11/11/2016 - Gestión de lecturas de agua / electricidad nuevo objeto

    DataCaptionFields = "Area";
    Editable = false;
    PageType = List;
    UsageCategory = Administration;
    PromotedActionCategories = 'Nuevo,Proceso,Informes,Lecturas';
    SourceTable = 50003;
    SourceTableView = SORTING (Area, Fecha lectura, No. Contador)
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
                        ped.SETRANGE("No.", "No. contrato");
                        IF ped.FINDFIRST THEN
                        PAGE.RUN(42,ped)
                        ELSE
                          MESSAGE('No hay contrato para %1', "No. Contador")
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
                        ped: Record "Sales Header";
                        LR_HistFacVta: Record "Sales Invoice Header";
                    begin
                        IF "No. Factura registrada" <>'' THEN BEGIN
                          CLEAR(LR_HistFacVta);
                          LR_HistFacVta.GET("No. Factura registrada");
                          PAGE.RUN(132,LR_HistFacVta);
                        END ELSE
                          IF "No. Pre factura" <> '' THEN BEGIN
                            IF ped.GET( ped."Document Type"::Invoice,"No. Pre factura" )THEN
                              PAGE.RUN(43,ped)
                          END
                          ELSE
                            MESSAGE('No hay Facturas para %1', "No. Contador")

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
                        PageLectura: Page 50007;
                                         RLect: Record 50003;
                    begin
                        IF ("No. Factura registrada"<>'') OR ("No. Pre factura" <>'') THEN
                           ERROR(LT50000);
                        IF HayLecturasPosteriores(Rec) THEN
                          ERROR(LT50001);
                        CLEAR(LectTB);

                        LectTB.SETCURRENTKEY("No. Contador","Fecha lectura");
                        LectTB.SETRANGE(LectTB."No. Contador","No. Contador");
                        ConfVtas.GET;
                        IF ConfVtas."Cantidad últimas lectura"<>0 THEN BEGIN
                           IF LectTB.COUNT<ConfVtas."Cantidad últimas lectura" THEN
                            registros:= Rec.COUNT
                          ELSE
                            registros:= ConfVtas."Cantidad últimas lectura" ;

                          IF LectTB.FINDLAST THEN
                          FOR i:= 1 TO registros-1 DO BEGIN
                            LectTB.NEXT(-1)
                            END
                        END;

                        RLect.SETCURRENTKEY("No. Contador","Fecha lectura");
                        RLect.SETRANGE("No. Contador","No. Contador");
                        RLect.SETFILTER("Fecha lectura",'%1..',LectTB."Fecha lectura");
                        PgLecturas.ContadorALeer("No. Contador");
                        PgLecturas.LecturaAmodificar(Rec);
                        PgLecturas.SETTABLEVIEW(RLect);
                        PgLecturas.SETRECORD(RLect);
                        PgLecturas.RUN;
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
                    var
                        PageLectura: Page 50007;
                                         RLect: Record 50003;
                    begin
                        IF ("No. Factura registrada"<>'') OR ("No. Pre factura" <>'') THEN
                           ERROR(LT50000);
                        IF HayLecturasPosteriores(Rec) THEN
                          ERROR(LT50001);
                        IF CONFIRM(LT50002,FALSE,"No. Contador","Fecha lectura")THEN
                            Rec.DELETE(TRUE);
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
                        PageLectura: Page 50007;
                                         RLect: Record 50003;
                    begin
                        CLEAR(LectTB);
                        LectTB.SETCURRENTKEY("No. Contador","Fecha lectura");
                        LectTB.SETRANGE(LectTB."No. Contador","No. Contador");
                        ConfVtas.GET;
                        IF ConfVtas."Cantidad últimas lectura"<>0 THEN BEGIN

                           IF LectTB.COUNT<ConfVtas."Cantidad últimas lectura" THEN
                            registros:= Rec.COUNT
                          ELSE
                            registros:= ConfVtas."Cantidad últimas lectura" ;

                          IF LectTB.FINDLAST THEN
                          FOR i:= 1 TO registros-1 DO BEGIN
                            LectTB.NEXT(-1)
                            END
                        END;

                        RLect.SETCURRENTKEY("No. Contador","Fecha lectura");
                        RLect.SETRANGE("No. Contador","No. Contador");
                        RLect.SETFILTER("Fecha lectura",'%1..',LectTB."Fecha lectura");
                        PgLecturas.ContadorALeer("No. Contador");
                        PgLecturas.SETTABLEVIEW(RLect);
                        PgLecturas.SETRECORD(RLect);
                        PgLecturas.RUN;
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
                        PageInc: Page 50010;
                    begin
                        IF "Código Incidencia"<>'' THEN
                        IF Rinc.GET("Código Incidencia")THEN BEGIN
                         PageInc.SETTABLEVIEW(Rinc);
                         PageInc.SETRECORD(Rinc);
                         PageInc.RUN
                        END

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
        PgLecturas: Page 50009;
                        LT50002: Label '¿Desea eliminar la lectura %1 del día %2?';
        NoOrdenLectura: Integer;
        Contador: Record 50002;
}

