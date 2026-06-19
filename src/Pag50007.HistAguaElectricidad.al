page 50007 "Hist. Agua /Electricidad"
{
    // //***Z002 - 400 - RG- 11/11/2016 - Gestión de lecturas de agua / electricidad nuevo objeto

    DataCaptionFields = "Area";
    Editable = false;
    PageType = List;
    PromotedActionCategories = 'Nuevo,Proceso,Informes,Lecturas';
    SourceTable = Table50003;
    SourceTableView = SORTING (Area, Fecha lectura, No. Contador)
                      ORDER(Ascending);

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
                field("No. Orden de lectura";"No. Orden de lectura")
                {
                }
                field("Nombre cliente";"Nombre cliente")
                {
                }
                field("No. contrato";"No. contrato")
                {
                }
                field("Potencia contratada";"Potencia contratada")
                {
                }
                field("Coeficiente TT";"Coeficiente TT")
                {
                }
                field("Código Incidencia";"Código Incidencia")
                {
                }
                field("Fecha lectura";"Fecha lectura")
                {
                }
                field("Lectura HP";"Lectura HP")
                {
                }
                field("Consumo HP";"Consumo HP")
                {
                }
                field("Lectura HLL";"Lectura HLL")
                {
                }
                field("Consumo HLL";"Consumo HLL")
                {
                }
                field("Lectura HV";"Lectura HV")
                {
                }
                field("Consumo HV";"Consumo HV")
                {
                }
                field("Lectura B2";"Lectura B2")
                {
                }
                field("Consumo B2";"Consumo B2")
                {
                }
                field(Total;Total)
                {
                }
                field("No. Pre factura";"No. Pre factura")
                {
                }
                field("No. Factura registrada";"No. Factura registrada")
                {
                }
                field("Fecha factura registrada";"Fecha factura registrada")
                {
                }
                field("Tarifa aplicada";"Tarifa aplicada")
                {
                }
                field(Pabellon;Pabellon)
                {
                }
                field("Tipo Consumo";"Tipo Consumo")
                {
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
                        ped.SETRANGE("No.", "No. contrato");
                        IF ped.FINDFIRST THEN
                        PAGE.RUN(42,ped)
                        ELSE
                          MESSAGE('No hay contrato para %1', "No. Contador")
                    end;
                }
                action("Ver factura")
                {
                    Caption = 'Ver factura';
                    Image = Invoice;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        ped: Record "36";
                        LR_HistFacVta: Record "112";
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
                    Caption = 'Modificar Lectura';
                    Image = UpdateDescription;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        PageLectura: Page "50007";
                                         RLect: Record "50003";
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
                    Caption = 'Borrar Lectura';
                    Image = Delete;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        PageLectura: Page "50007";
                                         RLect: Record "50003";
                    begin
                        IF ("No. Factura registrada"<>'') OR ("No. Pre factura" <>'') THEN
                           ERROR(LT50000);
                        IF HayLecturasPosteriores(Rec) THEN
                          ERROR(LT50001);
                        IF CONFIRM(LT50002,FALSE,"No. Contador","Fecha lectura")THEN
                            DELETE(TRUE);
                    end;
                }
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
                    Image = ErrorLog;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        Rinc: Record "50004";
                        PageInc: Page "50010";
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
        LectTB: Record "50003";
        LT50000: Label 'La Lectura ya tiene Factura';
        LT50001: Label 'La Lectura no se puede modificar porque tiene lecturas posteriores';
        ConfVtas: Record "311";
        registros: Integer;
        i: Integer;
        PgLecturas: Page "50009";
                        LT50002: Label '¿Desea eliminar la lectura %1 del día %2?';
        NoOrdenLectura: Integer;
        Contador: Record "50002";
}

