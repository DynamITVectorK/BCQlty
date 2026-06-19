page 50009 "Ficha Lecturas"
{
    // //***Z002 - 400 - RG- 14/11/2016 - Gestión de lecturas de agua / electricidad

    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    UsageCategory = Administration;
    PromotedActionCategories = 'Nuevo,Proceso,Informes,Lecturas';
    ShowFilter = false;
    SourceTable = 50003;
    SourceTableView = SORTING (No. Contador, Fecha lectura);

    layout
    {
        area(content)
        {
            group("Lectura Electricidad")
            {
                Visible = eselectricidad;
                field("No. Contador"; Rec."No. Contador")
                {
                    ApplicationArea = All;
                }
                field("No. Puesto/Pabellon"; Rec."No. Puesto/Pabellon")
                {
                    ApplicationArea = All;
                }
                field("Tarifa aplicada"; Rec."Tarifa aplicada")
                {
                    ApplicationArea = All;
                }
                field("Coeficiente TT"; Rec."Coeficiente TT")
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
                field("% desviación +/- aviso"; Rec."% desviación +/- aviso")
                {
                    ApplicationArea = All;
                }
                field(Condensadores; Rec.Condensadores)
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
                field("Descripcion Ubicacion Contador"; Rec."Descripcion Ubicacion Contador")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
            }
            group("Lectura Agua")
            {
                Visible = EsAgua;
                field("ANº Contador (DF*)>"; Rec."No. Contador")
                {
                    ApplicationArea = All;
                    Caption = 'Nº Contador';
                }
                field("ANº Puesto/Pabellon (DF*)>"; Rec."No. Puesto/Pabellon")
                {
                    ApplicationArea = All;
                    Caption = 'Nº Puesto/Pabellon';
                }
                field("ATarifa aplicada>"; Rec."Tarifa aplicada")
                {
                    ApplicationArea = All;
                    Caption = 'Tarifa aplicada';
                }
                field("ANombre cliente (DF*)>"; Rec."Nombre cliente")
                {
                    ApplicationArea = All;
                    Caption = 'Nombre cliente';
                }
                field("ANº contrato (DF*)>"; Rec."No. contrato")
                {
                    ApplicationArea = All;
                    Caption = 'Nº contrato';
                }
                field("A% desviación +/- aviso (DF*)>"; Rec."% desviación +/- aviso")
                {
                    ApplicationArea = All;
                    Caption = '% desviación +/- para aviso';
                }
                field(PabellonAgua; Rec.Pabellon)
                {
                    ApplicationArea = All;
                    Caption = 'Pabellon';
                }
                field("Tipo Consumo Agua"; Rec."Tipo Consumo")
                {
                    ApplicationArea = All;
                    Caption = 'Tipo Consumo';
                }
                field(DescripcionUbicacionContadorAgua; Rec."Descripcion Ubicacion Contador")
                {
                    ApplicationArea = All;
                    Caption = 'Descripcion Ubicacion Contador';
                    MultiLine = true;
                }
            }
            group()
            {
                //The GridLayout property is only supported on controls of type Grid
                //GridLayout = Columns;
                Visible = EsElectricidad;
                field(MeterNotAccess; Rec.Nuevo_MeterNotAcces)
                {
                    ApplicationArea = All;
                    Caption = 'Meter Not Accesible For Reading';

                    trigger OnValidate()
                    var
                        Readings: Record 50003;
                    begin
                        //ZAM_MEP
                        IF Nuevo_MeterNotAcces THEN BEGIN
                            CLEAR(Readings);
                            Readings.SETRANGE("No. Contador", Rec."No. Contador");
                            Readings.SETRANGE(Area, Rec.Area);
                            IF Readings.FINDLAST THEN BEGIN
                                Nuevo_LecturaHP := Readings."Lectura HP";
                                Nuevo_LecturaHLL := Readings."Lectura HLL";
                                Nuevo_LecturaHV := Readings."Lectura HV";
                                Nuevo_LecturaB2 := Readings."Lectura B2";
                            END;
                        END;
                        //ZAM_MEP END
                    end;
                }
                field(Nuevo_Fechalectura; Rec.Nuevo_Fechalectura)
                {
                    ApplicationArea = All;
                    Caption = 'Fecha Lectura';
                }
                field(Nuevo_LecturaHP; Rec.Nuevo_LecturaHP)
                {
                    ApplicationArea = All;
                    Caption = 'Lectura HP';

                    trigger OnValidate()
                    begin
                        ActConsumosAux
                    end;
                }
                field(Nuevo_LecturaHLL; Rec.Nuevo_LecturaHLL)
                {
                    ApplicationArea = All;
                    Caption = 'Lectura HLL';

                    trigger OnValidate()
                    begin
                        ActConsumosAux
                    end;
                }
                field(Nuevo_LecturaHV; Rec.Nuevo_LecturaHV)
                {
                    ApplicationArea = All;
                    Caption = 'Lectura HV';

                    trigger OnValidate()
                    begin
                        ActConsumosAux
                    end;
                }
                field(Nuevo_LecturaB2; Rec.Nuevo_LecturaB2)
                {
                    ApplicationArea = All;
                    Caption = 'Lectura B2';

                    trigger OnValidate()
                    begin
                        ActConsumosAux
                    end;
                }
                field(Nuevo_CódigoIncidencia; Rec.Nuevo_CódigoIncidencia)
                {
                    ApplicationArea = All;
                    Caption = 'Código Incidencia';
                    ColumnSpan = 2;
                    Editable = false;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        IF Nuevo_CódigoIncidencia <> '' THEN BEGIN
                            Lincidencia.GET(Nuevo_CódigoIncidencia);
                            PAGE.RUN(50010, Lincidencia);
                            CurrPage.UPDATE;
                        END
                    end;
                }
                field(NuevoTotal; Rec.NuevoTotal)
                {
                    ApplicationArea = All;
                    Caption = 'Total';
                    Editable = false;
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field(Nuevo_ConsumoHP; Rec.Nuevo_ConsumoHP)
                {
                    ApplicationArea = All;
                    Caption = 'Consumo HP';
                    Editable = false;
                }
                field(Nuevo_ConsumoHLL; Rec.Nuevo_ConsumoHLL)
                {
                    ApplicationArea = All;
                    Caption = 'Consumo HLL';
                    Editable = false;
                }
                field(Nuevo_ConsumoHV; Rec.Nuevo_ConsumoHV)
                {
                    ApplicationArea = All;
                    Caption = 'Consumo HV';
                    Editable = false;
                }
                field(Nuevo_ConsumoB2; Rec.Nuevo_ConsumoB2)
                {
                    ApplicationArea = All;
                    Caption = 'Consumo B2';
                    Editable = false;
                }
            }
            group()
            {
                //The GridLayout property is only supported on controls of type Grid
                //GridLayout = Columns;
                Visible = EsAgua;
                field(ZAM_MeterNotAccForReadingWater; Rec.Nuevo_MeterNotAcces)
                {
                    ApplicationArea = All;
                    Caption = 'Meter Not Accesible For Reading';

                    trigger OnValidate()
                    var
                        Readings: Record 50003;
                    begin
                        //ZAM_MEP
                        IF Nuevo_MeterNotAcces THEN BEGIN
                            CLEAR(Readings);
                            Readings.SETRANGE("No. Contador", Rec."No. Contador");
                            Readings.SETRANGE(Area, Rec.Area);
                            IF Readings.FINDLAST THEN BEGIN
                                Nuevo_LecturaHP := Readings."Lectura HP";
                            END;
                        END;
                        //ZAM_MEP END
                    end;
                }
                field(fl; Rec.Nuevo_Fechalectura)
                {
                    ApplicationArea = All;
                    Caption = 'Fecha Lectura';
                }
                field(_T1; Rec.Nuevo_LecturaHP)
                {
                    ApplicationArea = All;
                    Caption = 'Lectura T1';

                    trigger OnValidate()
                    begin
                        ActConsumosAux
                    end;
                }
                field(LInc; Rec.Nuevo_CódigoIncidencia)
                {
                    ApplicationArea = All;
                    Caption = 'Código Incidencia';
                    Editable = false;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        IF Nuevo_CódigoIncidencia <> '' THEN BEGIN
                            Lincidencia.GET(Nuevo_CódigoIncidencia);
                            PAGE.RUN(50010, Lincidencia);
                            CurrPage.UPDATE;
                        END
                    end;
                }
                field(Tot; Rec.NuevoTotal)
                {
                    ApplicationArea = All;
                    Caption = 'Total';
                    Editable = false;
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field(C_T1; Rec.Nuevo_ConsumoHP)
                {
                    ApplicationArea = All;
                    Caption = 'Consumo T1';
                    Editable = false;
                }
            }
            repeater(ELECTRICIDAD)
            {
                Caption = 'ELECTRICIDAD';
                Visible = eselectricidad;
                field("Fecha lectura"; Rec."Fecha lectura")
                {
                    ApplicationArea = All;
                }
                field("No. Factura registrada"; Rec."No. Factura registrada")
                {
                    ApplicationArea = All;
                }
                field("Código Incidencia"; Rec."Código Incidencia")
                {
                    ApplicationArea = All;
                }
                field("Lectura HP"; Rec."Lectura HP")
                {
                    ApplicationArea = All;
                    Caption = 'Lectura HP';
                }
                field("Consumo HP"; Rec."Consumo HP")
                {
                    ApplicationArea = All;
                    Caption = 'Consumo HP';
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
            }
            repeater(AGUA)
            {
                Caption = 'AGUA';
                Visible = EsAgua;
                field("<Fecha lecturaA>"; Rec."Fecha lectura")
                {
                    ApplicationArea = All;
                    Caption = 'Fecha lectura';
                }
                field("<Nº Factura registradaA>"; Rec."No. Factura registrada")
                {
                    ApplicationArea = All;
                    Caption = 'Nº Factura registrada';
                }
                field("<Código IncidenciaA>"; Rec."Código Incidencia")
                {
                    ApplicationArea = All;
                    Caption = 'Código Incidencia';
                }
                field("<Lectura HPA>"; Rec."Lectura HP")
                {
                    ApplicationArea = All;
                    Caption = 'Lectura T1';
                }
                field("<Consumo HPA>"; Rec."Consumo HP")
                {
                    ApplicationArea = All;
                    Caption = 'Consumo T1';
                }
                field("<TotalA>"; Rec.Total)
                {
                    ApplicationArea = All;
                    Caption = 'Total';
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            group(Botones)
            {
                Caption = 'Botones';
                action("Anterior Lectura")
                {
                    ApplicationArea = All;
                    Image = PreviousSet;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    RunPageMode = Create;

                    trigger OnAction()
                    var
                        PageLectura: Page 50007;
                        RLect: Record 50003;
                        LectTB: Record 50003;
                        LR_Contador: Record 50002;
                        ContadorAct: Code[10];
                        ordenact: Integer;
                        registros: Integer;
                        RLectAux: Record 50003;
                        ContAux: Integer;
                        LR_ContadorAux: Record 50002;
                    begin
                        IF NOT ((Nuevo_Fechalectura = 0D) OR ((Nuevo_LecturaB2 = 0) AND (Nuevo_LecturaHV = 0) AND (Nuevo_LecturaHLL = 0) AND (Nuevo_LecturaHP = 0))) THEN
                            Addlectura;

                        IF ((Nuevo_LecturaB2 = 0) AND (Nuevo_LecturaHV = 0) AND (Nuevo_LecturaHLL = 0) AND (Nuevo_LecturaHP = 0)) THEN
                            Nuevo_Fechalectura := 0D;

                        BorraAux;
                        LimpiarEntrada;

                        CLEAR(LectTB);
                        IF LR_Contador.GET("No. Contador") THEN BEGIN
                            ContadorAct := LR_Contador."No. Contador";
                            ordenact := LR_Contador."No. Orden de lectura";
                            LR_Contador.SETCURRENTKEY(Area, "No. Orden de lectura");
                            LR_Contador.SETRANGE(Area, Rec.Area);
                            LR_Contador.SETFILTER("No. Orden de lectura", '>%1', ordenact);
                            IF LR_Contador.FINDFIRST THEN BEGIN
                                LectTB.SETCURRENTKEY("No. Contador", "Fecha lectura");
                                LectTB.SETRANGE(LectTB."No. Contador", LR_Contador."No. Contador");
                                IF NOT LectTB.FINDFIRST THEN BEGIN
                                    LectTB.INIT;
                                    LectTB.VALIDATE("No. Contador", LR_Contador."No. Contador");
                                    IF NOT LectTB.INSERT THEN;
                                END;



                                //Busco el anterior contador segun el orden de lectura
                                CLEAR(LR_ContadorAux);
                                LR_ContadorAux.SETCURRENTKEY("No. Orden de lectura");
                                LR_ContadorAux.SETRANGE(Estado, 0);
                                LR_ContadorAux.SETFILTER("No. Contador", '<>%1', "No. Contador");
                                LR_ContadorAux.SETFILTER("No. Orden de lectura", '..%1', "No. Orden de lectura");
                                IF LR_ContadorAux.FINDLAST THEN BEGIN

                                    //Se toman las ultimas lecturas de la configuracion
                                    ConfVtas.GET;
                                    IF ConfVtas."Cantidad últimas lectura" <> 0 THEN BEGIN

                                        IF LectTB.COUNT < ConfVtas."Cantidad últimas lectura" THEN
                                            registros := Rec.COUNT
                                        ELSE
                                            registros := ConfVtas."Cantidad últimas lectura";
                                    END;
                                    CLEAR(RLect);
                                    RLect.SETCURRENTKEY("No. movimiento");
                                    //RLect.SETASCENDING("No. movimiento",FALSE);
                                    RLect.SETRANGE("No. Contador", LR_ContadorAux."No. Contador");
                                    ContAux := 1;
                                    //IF RLect.FINDSET() THEN
                                    IF RLect.FINDLAST() THEN
                                        REPEAT
                                            IF ContAux <= registros THEN
                                                RLect.MARK(TRUE);
                                            ContAux += 1;
                                        UNTIL RLect.NEXT(-1) = 0;
                                    RLect.MARKEDONLY(TRUE);


                                    PgLecturas.ContadorALeer(LR_ContadorAux."No. Contador");
                                    PgLecturas.SETTABLEVIEW(RLect);
                                    //PgLecturas.SETRECORD(RLectAux);
                                    PgLecturas.RUN;
                                    //ZAM_MEP - Ajustes siguiente factura END
                                    BotonSiguiente := TRUE;
                                    COMMIT;
                                    CurrPage.CLOSE;
                                END;
                            END
                            ELSE
                                MESSAGE('No hay mas lecturas')
                        END
                    end;
                }
                action(Aceptar)
                {
                    ApplicationArea = All;
                    Image = Add;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        tx50000: Label '¿Desea grabar la lectura?';
                        tlLecturas: Record 50003;
                        fLectura: Date;
                    begin
                        //IF CONFIRM(tx50000)THEN BEGIN
                        fLectura := Nuevo_Fechalectura;
                        Addlectura;
                        //MESSAGE('Lectura grabada');
                        //COMMIT;
                        IF (Lincidencia."Lec. Inicio  averiado no TT" <> 0) OR
                           (Lincidencia."Lec. Inicio  averiado HV TT" <> 0) OR
                           (Lincidencia."Lec. Inicio  averiado HLL  TT" <> 0) OR
                           (Lincidencia."Lec. Inicio  averiado HP  TT" <> 0) OR
                           (Lincidencia."Lec. fin  averiado no TT" <> 0) OR
                           (Lincidencia."Lec. fin  averiado HV TT" <> 0) OR
                           (Lincidencia."Lec. fin  averiado HLL  TT" <> 0) OR
                           (Lincidencia."Lec. fin  averiado HP  TT" <> 0)
                           THEN BEGIN

                            Nuevo_Fechalectura := CALCDATE('1D', fLectura);
                            fLectura := 0D;
                            /*
                            Nuevo_LecturaHP  := Lincidencia."Lec. Inicio  averiado no TT";
                            ActConsumosAux;
                            Nuevo_LecturaHLL := Lincidencia."Lec. Inicio  averiado HV TT";
                            ActConsumosAux;
                            Nuevo_LecturaHV :=  Lincidencia."Lec. Inicio  averiado HLL  TT";
                            ActConsumosAux;
                            Nuevo_LecturaB2 := Lincidencia."Lec. Inicio  averiado HP  TT";
                            ActConsumosAux;
                            */

                            Nuevo_LecturaHP := Lincidencia."Lec. Inicio  averiado HP  TT";
                            ActConsumosAux;
                            Nuevo_LecturaHLL := Lincidencia."Lec. Inicio  averiado HLL  TT";
                            ActConsumosAux;
                            Nuevo_LecturaHV := Lincidencia."Lec. Inicio  averiado HV TT";
                            ActConsumosAux;
                            Nuevo_LecturaB2 := Lincidencia."Lec. Inicio  averiado no TT";
                            ActConsumosAux;


                            Addlectura;
                            Nuevo_CódigoIncidencia := '';
                            CLEAR(Lincidencia);
                            /*
                            tlLecturas.INIT;
                            END ELSE BEGIN
                               tlLecturas.INSERT(TRUE);
                               tlLecturas.VALIDATE(tlLecturas."Nº Contador",ContadorPpal);
                            END;
                            tlLecturas."Fecha lectura":= Nuevo_Fechalectura + 1d;
                            tlLecturas."Lectura B2":= Nuevo_LecturaB2;
                            tlLecturas."Lectura HV":= Nuevo_LecturaHV;
                            tlLecturas."Lectura HLL":= Nuevo_LecturaHLL;
                            tlLecturas."Lectura HP":= Nuevo_LecturaHP;
                            tlLecturas."Consumo B2":=Nuevo_ConsumoB2;
                            tlLecturas."Consumo HV":= Nuevo_ConsumoHV;
                            tlLecturas."Consumo HLL":=Nuevo_ConsumoHLL;
                            tlLecturas."Consumo HP":=Nuevo_ConsumoHP ;
                            tlLecturas.Total :=NuevoTotal;
                            IF Nuevo_CódigoIncidencia <> '' THEN BEGIN
                               Lincidencia.GET(Nuevo_CódigoIncidencia);
                               Lincidencia."Nº Mov. lectura":=LNuevaLectura."Nº movimiento";
                               Lincidencia.MODIFY;
                               LNuevaLectura."Código Incidencia":= Nuevo_CódigoIncidencia;
                            END;
                            tlLecturas.MODIFY;
                            LimpiarEntrada;
                            */
                        END;
                        //END

                    end;
                }
                action(Rechazar)
                {
                    ApplicationArea = All;
                    Image = Delete;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin

                        IF Nuevo_CódigoIncidencia <> '' THEN BEGIN
                            Lincidencia.GET(Nuevo_CódigoIncidencia);
                            Lincidencia.DELETE;
                        END;
                        LimpiarEntrada;
                    end;
                }
                action("Crear Incidencia")
                {
                    ApplicationArea = All;
                    Image = ErrorLog;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        tltxt5000: Label 'La lectura ya tiene la incidencia %1';
                    begin
                        IF Nuevo_CódigoIncidencia <> '' THEN
                            ERROR(tltxt5000, Nuevo_CódigoIncidencia);
                        Nuevo_CódigoIncidencia := CrearIncidencia;
                        IF Nuevo_CódigoIncidencia <> '' THEN BEGIN
                            Lincidencia.GET(Nuevo_CódigoIncidencia);
                            COMMIT;
                            IF PAGE.RUNMODAL(50010, Lincidencia) = ACTION::LookupOK THEN BEGIN
                                Nuevo_LecturaHP := Lincidencia."Lec. fin  averiado HP  TT";
                                Fin_LecturaHP := Lincidencia."Lec. Inicio  averiado HP  TT";
                                ActConsumosAux;

                                Nuevo_LecturaHLL := Lincidencia."Lec. fin  averiado HLL  TT";
                                Fin_LecturaHLL := Lincidencia."Lec. Inicio  averiado HLL  TT";
                                ActConsumosAux;

                                Nuevo_LecturaHV := Lincidencia."Lec. fin  averiado HV TT";
                                Fin_LecturaHV := Lincidencia."Lec. Inicio  averiado HV TT";
                                ActConsumosAux;

                                Nuevo_LecturaB2 := Lincidencia."Lec. fin  averiado no TT";
                                Fin_LecturaB2 := Lincidencia."Lec. Inicio  averiado no TT";
                                ActConsumosAux;

                                CurrPage.UPDATE;
                            END;
                        END
                    end;
                }
                action("Siguente Lectura")
                {
                    ApplicationArea = All;
                    Image = NextSet;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    RunPageMode = Create;

                    trigger OnAction()
                    var
                        PageLectura: Page 50007;
                        RLect: Record 50003;
                        LectTB: Record 50003;
                        LR_Contador: Record 50002;
                        ContadorAct: Code[10];
                        ordenact: Integer;
                        registros: Integer;
                        RLectAux: Record 50003;
                        ContAux: Integer;
                        LR_ContadorAux: Record 50002;
                    begin
                        IF NOT ((Nuevo_Fechalectura = 0D) OR ((Nuevo_LecturaB2 = 0) AND (Nuevo_LecturaHV = 0) AND (Nuevo_LecturaHLL = 0) AND (Nuevo_LecturaHP = 0))) THEN
                            Addlectura;

                        IF ((Nuevo_LecturaB2 = 0) AND (Nuevo_LecturaHV = 0) AND (Nuevo_LecturaHLL = 0) AND (Nuevo_LecturaHP = 0)) THEN
                            Nuevo_Fechalectura := 0D;

                        BorraAux;
                        LimpiarEntrada;

                        CLEAR(LectTB);
                        IF LR_Contador.GET("No. Contador") THEN BEGIN
                            ContadorAct := LR_Contador."No. Contador";
                            ordenact := LR_Contador."No. Orden de lectura";
                            LR_Contador.SETCURRENTKEY(Area, "No. Orden de lectura");
                            LR_Contador.SETRANGE(Area, Rec.Area);
                            LR_Contador.SETFILTER("No. Orden de lectura", '>%1', ordenact);
                            IF LR_Contador.FINDFIRST THEN BEGIN
                                LectTB.SETCURRENTKEY("No. Contador", "Fecha lectura");
                                LectTB.SETRANGE(LectTB."No. Contador", LR_Contador."No. Contador");
                                IF NOT LectTB.FINDFIRST THEN BEGIN
                                    LectTB.INIT;
                                    LectTB.VALIDATE("No. Contador", LR_Contador."No. Contador");
                                    IF NOT LectTB.INSERT THEN;
                                END;


                                //ZAM_MEP - Ajustes siguiente factura
                                /*
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
                                RLect.SETRANGE("No. Contador",LR_Contador."No. Contador");
                                RLect.SETFILTER("Fecha lectura",'%1..',LectTB."Fecha lectura");
                                PgLecturas.ContadorALeer(LR_Contador."No. Contador");
                                PgLecturas.SETTABLEVIEW(RLect);
                                PgLecturas.SETRECORD(RLect);
                                PgLecturas.RUN;
                                */
                                //Busco el siguiente contador segun el orden de lectura
                                CLEAR(LR_ContadorAux);
                                LR_ContadorAux.SETCURRENTKEY("No. Orden de lectura");
                                LR_ContadorAux.SETRANGE(Estado, 0);
                                LR_ContadorAux.SETFILTER("No. Contador", '<>%1', "No. Contador");
                                LR_ContadorAux.SETFILTER("No. Orden de lectura", '%1..', "No. Orden de lectura");
                                IF LR_ContadorAux.FINDFIRST THEN BEGIN

                                    //Se toman las ultimas lecturas de la configuracion
                                    ConfVtas.GET;
                                    IF ConfVtas."Cantidad últimas lectura" <> 0 THEN BEGIN

                                        IF LectTB.COUNT < ConfVtas."Cantidad últimas lectura" THEN
                                            registros := Rec.COUNT
                                        ELSE
                                            registros := ConfVtas."Cantidad últimas lectura";
                                    END;
                                    CLEAR(RLect);
                                    RLect.SETCURRENTKEY("No. movimiento");
                                    //RLect.SETASCENDING("No. movimiento",FALSE);
                                    RLect.SETRANGE("No. Contador", LR_ContadorAux."No. Contador");
                                    ContAux := 1;
                                    //IF RLect.FINDSET() THEN
                                    IF RLect.FINDLAST() THEN
                                        REPEAT
                                            IF ContAux <= registros THEN
                                                RLect.MARK(TRUE);
                                            ContAux += 1;
                                        UNTIL RLect.NEXT(-1) = 0;
                                    RLect.MARKEDONLY(TRUE);


                                    PgLecturas.ContadorALeer(LR_ContadorAux."No. Contador");
                                    PgLecturas.SETTABLEVIEW(RLect);
                                    //PgLecturas.SETRECORD(RLectAux);
                                    PgLecturas.RUN;
                                    //ZAM_MEP - Ajustes siguiente factura END
                                    BotonSiguiente := TRUE;
                                    COMMIT;
                                    CurrPage.CLOSE;
                                END;
                            END
                            ELSE
                                MESSAGE('No hay mas lecturas')
                        END

                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        //Nuevo_Fechalectura := WORKDATE;
    end;

    trigger OnAfterGetRecord()
    var
        tlContadores: Record 50002;
        tlSalesLine: Record "Sales Line";
    begin
        //Nuevo_Fechalectura := WORKDATE;

        IF Area = Area::Electricidad THEN BEGIN
            EsElectricidad := TRUE;
            EsAgua := FALSE
        END ELSE BEGIN
            EsElectricidad := FALSE;
            EsAgua := TRUE
        END;

        //% desviación
        CLEAR(tlContadores);
        IF tlContadores.GET("No. Contador") THEN
            "% desviación +/- aviso" := tlContadores."% desviación +/- para aviso";

        IF Nuevo_CódigoIncidencia <> '' THEN BEGIN
            IF NOT Lincidencia.GET(Nuevo_CódigoIncidencia) THEN
                Nuevo_CódigoIncidencia := '';
        END;

        //Tarifa
        CLEAR(tlSalesLine);
        tlSalesLine.SETRANGE("Document Type", tlSalesLine."Document Type"::Order);
        tlSalesLine.SETRANGE("Document No.", "No. contrato");
        tlSalesLine.SETRANGE("No. contador", "No. Contador");
        tlSalesLine.SETRANGE("Fecha fin servicio", 0D);
        IF tlSalesLine.FINDSET THEN BEGIN
            "Tarifa aplicada" := tlSalesLine.Tarifa;
            "Potencia contratada" := tlSalesLine.Quantity;
        END;
    end;

    trigger OnClosePage()
    begin
        IF NOT BotonSiguiente THEN BEGIN
            //IF (NuevoTotal<>0)  THEN
            //Addlectura;
            BorraAux
        END
    end;

    trigger OnOpenPage()
    var
        registros: Integer;
    begin
        IF Nuevo_Fechalectura = 0D THEN
            Nuevo_Fechalectura := WORKDATE;
    end;

    var
        ConfVtas: Record "Sales & Receivables Setup";
        i: Integer;
        Nuevo_Fechalectura: Date;
        Nuevo_NFacturaregistrada: Code[20];
        "Nuevo_CódigoIncidencia": Code[20];
        Nuevo_LecturaHP: Integer;
        Nuevo_ConsumoHP: Integer;
        Nuevo_LecturaHLL: Integer;
        Nuevo_ConsumoHLL: Integer;
        Nuevo_LecturaHV: Integer;
        Nuevo_ConsumoHV: Integer;
        Nuevo_LecturaB2: Integer;
        Nuevo_ConsumoB2: Integer;
        NuevoTotal: Integer;
        Glectura: Record 50003;
        ContadorPpal: Code[10];
        GT50002: Label 'Proceso Cancelado';
        Lincidencia: Record 50004;
        Modificar: Boolean;
        GB_lectura: Record 50003;
        blanco: Text;
        Cap1: Text;
        EsElectricidad: Boolean;
        G_contador: Record 50002;
        EsAgua: Boolean;
        PgLecturas: Page 50009;
        BotonSiguiente: Boolean;
        Text0001: Label 'Atención!  Va a registrar un consumo negativo.  Desea continuar ?';
        Fin_LecturaHP: Integer;
        Fin_LecturaHV: Integer;
        Fin_LecturaHLL: Integer;
        Fin_LecturaB2: Integer;
        Nuevo_MeterNotAcces: Boolean;

    local procedure Addlectura()
    var
        LNuevaLectura: Record 50003;
        LT5000: Label 'Debe introducir fecha y alguna lectura';
        desvioL: Decimal;
        LT5001: Label '%Desviación de consumo con respecto al periodo anterior es de %1 %. ¿Quiere continuar y dar por válida la lectura?';
        Lincidencia: Record 50004;
        LT5002: Label 'La desviación de consumo con respecto al periodo anterior supera el % indicado como aceptable. ¿Desea continuar y dar por válida la lectura?';
    begin
        //Inserta lecturas
        //IF (Nuevo_Fechalectura=0D) OR ((Nuevo_LecturaB2=0) AND (Nuevo_LecturaHV=0) AND (Nuevo_LecturaHLL=0) AND (Nuevo_LecturaHP=0))THEN
        IF (Nuevo_Fechalectura = 0D) OR (((Nuevo_LecturaB2 = 0) AND (Nuevo_LecturaHV = 0) AND (Nuevo_LecturaHLL = 0) AND (Nuevo_LecturaHP = 0)) AND (Nuevo_CódigoIncidencia = '')) THEN
            ERROR(LT5000);
        //No permitir fecha lectura anterior a la ultima registrada
        fVerificarFecha(ContadorPpal, Nuevo_Fechalectura);

        //Dar aviso al guardar una lectura con consumo negativo.
        IF (Nuevo_ConsumoB2 < 0) OR (Nuevo_ConsumoHLL < 0) OR (Nuevo_ConsumoHP < 0) OR (Nuevo_ConsumoHV < 0) THEN
            IF NOT CONFIRM(Text0001) THEN BEGIN
                Nuevo_LecturaB2 := 0;
                Nuevo_ConsumoB2 := 0;
                Nuevo_LecturaHLL := 0;
                Nuevo_ConsumoHLL := 0;
                Nuevo_LecturaHP := 0;
                Nuevo_ConsumoHP := 0;
                Nuevo_LecturaHV := 0;
                Nuevo_ConsumoHV := 0;
                //ZAM_MEP
                Nuevo_MeterNotAcces := FALSE;
                //ZAM_MEP END
                EXIT;
            END;
        desvioL := TestDiferenciaExcesiva;
        //************
        IF desvioL > 0 THEN
            IF NOT CONFIRM(LT5002, FALSE, desvioL) THEN
                ERROR(GT50002);

        LNuevaLectura.INIT;
        IF Modificar THEN BEGIN
            LNuevaLectura := GB_lectura;
        END ELSE BEGIN
            LNuevaLectura.INSERT(TRUE);
            LNuevaLectura.VALIDATE(LNuevaLectura."No. Contador", ContadorPpal);
        END;
        LNuevaLectura."Fecha lectura" := Nuevo_Fechalectura;
        LNuevaLectura."Lectura B2" := Nuevo_LecturaB2;
        LNuevaLectura."Lectura HV" := Nuevo_LecturaHV;
        LNuevaLectura."Lectura HLL" := Nuevo_LecturaHLL;
        LNuevaLectura."Lectura HP" := Nuevo_LecturaHP;
        LNuevaLectura."Consumo B2" := Nuevo_ConsumoB2;
        LNuevaLectura."Consumo HV" := Nuevo_ConsumoHV;
        LNuevaLectura."Consumo HLL" := Nuevo_ConsumoHLL;
        LNuevaLectura."Consumo HP" := Nuevo_ConsumoHP;
        LNuevaLectura.Total := NuevoTotal;
        IF Nuevo_CódigoIncidencia <> '' THEN BEGIN
            Lincidencia.GET(Nuevo_CódigoIncidencia);
            Lincidencia."No. Mov. lectura" := LNuevaLectura."No. movimiento";
            Lincidencia.MODIFY;
            LNuevaLectura."Código Incidencia" := Nuevo_CódigoIncidencia;
        END;
        LNuevaLectura.MODIFY;
        Modificar := FALSE;
        BorraAux;
        LimpiarEntrada;
        //MESSAGE('Lectura grabada');
    end;

    local procedure ActConsumosAux()
    var
        lconsumo: Record 50003;
        Coeficiente: Decimal;
        Lt5000: Label 'Ya existe una lectura en %1 para %2';
    begin
        // Actualiza los consumos a partir de las lecturas
        testEntrada;
        //IF Glectura."Nº Contador" <> ContadorPpal THEN BEGIN
        CLEAR(Glectura);
        Glectura.SETCURRENTKEY("No. Contador", "Fecha lectura");
        Glectura.SETRANGE("No. Contador", ContadorPpal);
        Glectura.SETFILTER("Fecha lectura", '<=%1', Nuevo_Fechalectura);
        //Debe coger el último movimiento ignorando sobre el que estoy parada.
        //ZAM_MEP
        //Se comenta, ya que si debe tener en cuenta el ultimo movimiento
        //Glectura.SETFILTER("No. movimiento",'<>%1',"No. movimiento");
        //ZAM_MEP END
        //END ;
        IF Glectura."Coeficiente TT" <> 0 THEN
            Coeficiente := Glectura."Coeficiente TT"
        ELSE
            Coeficiente := 1;
        IF Glectura.FINDLAST THEN BEGIN
            IF (Glectura."Fecha lectura" = Nuevo_Fechalectura) AND (NOT Modificar) THEN
                ERROR(Lt5000, Nuevo_Fechalectura, ContadorPpal);

            IF Nuevo_LecturaB2 <> 0 THEN
                IF Glectura."Código Incidencia" = '' THEN
                    Nuevo_ConsumoB2 := (Nuevo_LecturaB2 - Glectura."Lectura B2") * Coeficiente  //* "Coeficiente TT"
                ELSE
                    IF Nuevo_CódigoIncidencia <> '' THEN
                        Nuevo_ConsumoB2 := 0  //(Nuevo_LecturaB2 * Coeficiente) + Glectura."Consumo B2"
                    ELSE
                        Nuevo_ConsumoB2 := (Nuevo_LecturaB2 - Glectura."Lectura B2") * Coeficiente
            ELSE
                //kk
                Nuevo_ConsumoB2 := 0;
            //Nuevo_ConsumoB2 := Glectura."Consumo B2";

            IF Nuevo_LecturaHV <> 0 THEN
                IF Glectura."Código Incidencia" = '' THEN
                    Nuevo_ConsumoHV := (Nuevo_LecturaHV - Glectura."Lectura HV") * Coeficiente  //* "Coeficiente TT"
                ELSE
                    IF Nuevo_CódigoIncidencia <> '' THEN
                        Nuevo_ConsumoHV := 0  //(Nuevo_LecturaHV * Coeficiente) + Glectura."Consumo HV"
                    ELSE
                        Nuevo_ConsumoHV := (Nuevo_LecturaHV - Glectura."Lectura HV") * Coeficiente
            ELSE
                //kk
                Nuevo_ConsumoHV := 0;
            //Nuevo_ConsumoHV:= Glectura."Consumo HV" ;

            IF Nuevo_LecturaHLL <> 0 THEN
                IF Glectura."Código Incidencia" = '' THEN
                    Nuevo_ConsumoHLL := (Nuevo_LecturaHLL - Glectura."Lectura HLL") * Coeficiente  //* "Coeficiente TT"
                ELSE
                    IF Nuevo_CódigoIncidencia <> '' THEN
                        Nuevo_ConsumoHLL := 0  //(Nuevo_LecturaHLL * Coeficiente) + Glectura."Consumo HLL"
                    ELSE
                        Nuevo_ConsumoHLL := (Nuevo_LecturaHLL - Glectura."Lectura HLL") * Coeficiente
            ELSE
                //kk
                Nuevo_ConsumoHLL := 0;
            //Nuevo_ConsumoHLL:= Glectura."Consumo HLL" ;

            IF Nuevo_LecturaHP <> 0 THEN
                IF Glectura."Código Incidencia" = '' THEN
                    Nuevo_ConsumoHP := (Nuevo_LecturaHP - Glectura."Lectura HP") * Coeficiente  //"Coeficiente TT"
                ELSE
                    IF Nuevo_CódigoIncidencia <> '' THEN
                        Nuevo_ConsumoHP := 0 //(Nuevo_LecturaHP *  Coeficiente ) + Glectura."Consumo HP"
                    ELSE
                        Nuevo_ConsumoHP := (Nuevo_LecturaHP - Glectura."Lectura HP") * Coeficiente
            ELSE
                //kk
                Nuevo_ConsumoHP := 0;
            //Nuevo_ConsumoHP:= Glectura."Consumo HP" ;

        END
        ELSE BEGIN
            Nuevo_ConsumoB2 := (Glectura."Lectura B2") * Coeficiente;  //* "Coeficiente TT" ; //* Coeficiente;
            Nuevo_ConsumoHV := (Glectura."Lectura HV") * Coeficiente;  //* "Coeficiente TT" ; //* Coeficiente;
            Nuevo_ConsumoHLL := (Glectura."Lectura HLL") * Coeficiente;  //* "Coeficiente TT" ; //* Coeficiente;
            Nuevo_ConsumoHP := (Glectura."Lectura HP") * Coeficiente;  //* "Coeficiente TT" ; //* Coeficiente;
        END;
        NuevoTotal := Nuevo_ConsumoB2 + Nuevo_ConsumoHV + Nuevo_ConsumoHLL + Nuevo_ConsumoHP;
    end;

    [Scope('Internal')]
    procedure ContadorALeer(Conta: Code[10])
    begin
        ContadorPpal := Conta;
    end;

    local procedure ActualizaPage()
    var
        LectTB: Record 50003;
        registros: Integer;
        filtro: Text;
    begin
        LectTB.SETCURRENTKEY("No. Contador", "No. movimiento");
        LectTB.SETRANGE(LectTB."No. Contador", ContadorPpal);
        ConfVtas.GET;
        IF ConfVtas."Cantidad últimas lectura" <> 0 THEN BEGIN
            LectTB.SETCURRENTKEY("No. movimiento");
            IF LectTB.COUNT < ConfVtas."Cantidad últimas lectura" THEN
                registros := Rec.COUNT
            ELSE
                registros := ConfVtas."Cantidad últimas lectura";

            IF LectTB.FINDLAST THEN
                FOR i := 1 TO registros DO BEGIN
                    IF i = 1 THEN
                        filtro := FORMAT(LectTB."No. movimiento")
                    ELSE
                        filtro := filtro + '|' + FORMAT(LectTB."No. movimiento");

                    LectTB.NEXT(-1)
                END
        END;
        Rec.SETFILTER("No. movimiento", filtro);
        CurrPage.UPDATE;
    end;

    local procedure TestDiferenciaExcesivaOrig() des: Decimal
    var
        Lcontador: Record 50002;
        Desvio: Decimal;
        AUX: Decimal;
    begin
        //% de desviación del consumo con respecto al consumo de la misma columna de la lectura anterior.
        //En caso de que el % de desviación a + o a - sobrepase el dato del campo "% desviación." del contador,
        // o si este campo estuviera en blanco,
        // del mismo campo en configuración de ventas y compras, se mostrará un aviso
        des := 0;
        Lcontador.GET(ContadorPpal);
        IF Lcontador."% desviación +/- para aviso" <> 0 THEN
            Desvio := Lcontador."% desviación +/- para aviso"
        ELSE BEGIN
            ConfVtas.GET;
            IF Area = Area::Electricidad THEN
                Desvio := ConfVtas."% Desv. Max Gral consumo elect"
            ELSE
                Desvio := ConfVtas."% Desv. Max Gral consumo agua"
        END;
        IF Desvio <> 0 THEN BEGIN
            IF Nuevo_ConsumoB2 <> 0 THEN BEGIN
                AUX := ROUND(ABS(100 - (Glectura."Consumo B2" * 100 / Nuevo_ConsumoB2)), 0.001);
                IF AUX > Desvio THEN
                    des := AUX;
            END;
            IF Nuevo_ConsumoHV <> 0 THEN BEGIN
                AUX := ROUND(ABS(100 - (Glectura."Consumo HV" * 100 / Nuevo_ConsumoHV)), 0.001);
                IF AUX > Desvio THEN
                    des := AUX;
            END;
            IF Nuevo_ConsumoHLL <> 0 THEN BEGIN
                AUX := ROUND(ABS(100 - (Glectura."Consumo HLL" * 100 / Nuevo_ConsumoHLL)), 0.001);
                IF AUX > Desvio THEN
                    des := AUX;
            END;
            IF Nuevo_ConsumoHP <> 0 THEN BEGIN
                AUX := ROUND(ABS(100 - (Glectura."Consumo HP" * 100 / Nuevo_ConsumoHP)), 0.001);
                IF AUX > Desvio THEN
                    des := AUX;
            END;
        END
    end;

    local procedure TestDiferenciaExcesiva() des: Decimal
    var
        Lcontador: Record 50002;
        Desvio: Decimal;
        AUX: Decimal;
        tlLecturas: Record 50003;
        vlDesvioConsumoB2: Decimal;
        vlDesvioConsumoHV: Decimal;
        vlDesvioConsumoHLL: Decimal;
        vlDesvioConsumoHP: Decimal;
        vlDesvioNegConsumoB2: Decimal;
        vlDesvioNegConsumoHV: Decimal;
        vlDesvioNegConsumoHLL: Decimal;
        vlDesvioNegConsumoHP: Decimal;
        StartDate: Date;
        EndDate: Date;
    begin
        //% de desviación del consumo con respecto al consumo de la misma columna de la lectura anterior.
        //En caso de que el % de desviación a + o a - sobrepase el dato del campo "% desviación." del contador,
        // o si este campo estuviera en blanco,
        // del mismo campo en configuración de ventas y compras, se mostrará un aviso

        des := 0;
        Lcontador.GET(ContadorPpal);
        IF Lcontador."% desviación +/- para aviso" <> 0 THEN
            Desvio := Lcontador."% desviación +/- para aviso"
        ELSE BEGIN
            ConfVtas.GET;
            IF Area = Area::Electricidad THEN
                Desvio := ConfVtas."% Desv. Max Gral consumo elect"
            ELSE
                Desvio := ConfVtas."% Desv. Max Gral consumo agua"
        END;

        IF Desvio <> 0 THEN BEGIN
            CLEAR(tlLecturas);
            tlLecturas.SETCURRENTKEY("No. Contador", "Fecha lectura");
            tlLecturas.SETRANGE("No. Contador", ContadorPpal);
            //ZAM_MEP
            //busco los consumos del mismo mes en el año anterior
            StartDate := DMY2DATE(1, DATE2DMY(Nuevo_Fechalectura, 2), DATE2DMY(Nuevo_Fechalectura, 3) - 1);
            EndDate := CALCDATE('<+CM>', StartDate);
            tlLecturas.SETRANGE("Fecha lectura", StartDate, EndDate);
            IF tlLecturas.FINDFIRST THEN BEGIN
                //IF tlLecturas.FINDLAST THEN BEGIN
                //ZAM_MEP END
                vlDesvioConsumoB2 := 0;
                vlDesvioConsumoHV := 0;
                vlDesvioConsumoHLL := 0;
                vlDesvioConsumoHP := 0;
                IF tlLecturas."Consumo B2" <> 0 THEN
                    vlDesvioConsumoB2 := tlLecturas."Consumo B2" + ((tlLecturas."Consumo B2" * Desvio) / 100);
                IF tlLecturas."Consumo HV" <> 0 THEN
                    vlDesvioConsumoHV := tlLecturas."Consumo HV" + ((tlLecturas."Consumo HV" * Desvio) / 100);
                IF tlLecturas."Consumo HLL" <> 0 THEN
                    vlDesvioConsumoHLL := tlLecturas."Consumo HLL" + ((tlLecturas."Consumo HLL" * Desvio) / 100);
                IF tlLecturas."Consumo HP" <> 0 THEN
                    vlDesvioConsumoHP := tlLecturas."Consumo HP" + ((tlLecturas."Consumo HP" * Desvio) / 100);

                vlDesvioNegConsumoB2 := 0;
                vlDesvioNegConsumoHV := 0;
                vlDesvioNegConsumoHLL := 0;
                vlDesvioNegConsumoHP := 0;

                IF tlLecturas."Consumo B2" <> 0 THEN
                    vlDesvioNegConsumoB2 := tlLecturas."Consumo B2" - ((tlLecturas."Consumo B2" * Desvio) / 100);
                IF tlLecturas."Consumo HV" <> 0 THEN
                    vlDesvioNegConsumoHV := tlLecturas."Consumo HV" - ((tlLecturas."Consumo HV" * Desvio) / 100);
                IF tlLecturas."Consumo HLL" <> 0 THEN
                    vlDesvioNegConsumoHLL := tlLecturas."Consumo HLL" - ((tlLecturas."Consumo HLL" * Desvio) / 100);
                IF tlLecturas."Consumo HP" <> 0 THEN
                    vlDesvioNegConsumoHP := tlLecturas."Consumo HP" - ((tlLecturas."Consumo HP" * Desvio) / 100);

                IF Nuevo_ConsumoB2 <> 0 THEN BEGIN
                    AUX := Nuevo_ConsumoB2;
                    IF AUX > vlDesvioConsumoB2 THEN
                        des := AUX;
                END;
                IF Nuevo_ConsumoHV <> 0 THEN BEGIN
                    AUX := Nuevo_ConsumoHV;
                    IF AUX > vlDesvioConsumoHV THEN
                        des := AUX;
                END;
                IF Nuevo_ConsumoHLL <> 0 THEN BEGIN
                    AUX := Nuevo_ConsumoHLL;
                    IF AUX > vlDesvioConsumoHLL THEN
                        des := AUX;
                END;
                IF Nuevo_ConsumoHP <> 0 THEN BEGIN
                    AUX := Nuevo_ConsumoHP;
                    IF AUX > vlDesvioConsumoHP THEN
                        des := AUX;
                END;
                IF Nuevo_ConsumoB2 <> 0 THEN BEGIN
                    AUX := Nuevo_ConsumoB2;
                    IF AUX < vlDesvioNegConsumoB2 THEN
                        des := AUX;
                END;
                IF Nuevo_ConsumoHV <> 0 THEN BEGIN
                    AUX := Nuevo_ConsumoHV;
                    IF AUX < vlDesvioNegConsumoHV THEN
                        des := AUX;
                END;
                IF Nuevo_ConsumoHLL <> 0 THEN BEGIN
                    AUX := Nuevo_ConsumoHLL;
                    IF AUX < vlDesvioNegConsumoHLL THEN
                        des := AUX;
                END;
                IF Nuevo_ConsumoHP <> 0 THEN BEGIN
                    AUX := Nuevo_ConsumoHP;
                    IF AUX < vlDesvioNegConsumoHP THEN
                        des := AUX;
                END;
                //ZAM_MEP
                //END;
            END ELSE
                //Si no encuentra el mismo mes en el año anterior, debe mostrar el mesaje igual
                des := 1;
            //ZAM_MEP END
        END
    end;

    local procedure CrearIncidencia(): Code[20]
    var
        LT50000: Label 'Introduzca fecha para la lectura';
        LIncidencia: Record 50004;
        LContador: Record 50002;
    begin
        IF (Nuevo_Fechalectura = 0D) THEN
            ERROR(LT50000);
        LIncidencia.INIT;
        LIncidencia.VALIDATE("No. Contador", ContadorPpal);
        LIncidencia.INSERT(TRUE);
        LContador.GET(ContadorPpal);
        LIncidencia."Área incidencia" := LContador.Area;
        LIncidencia."No. Puesto/Pabellón" := "No. Puesto/Pabellon";
        LIncidencia."Nombre cliente" := "Nombre cliente";
        LIncidencia."No. contrato" := "No. contrato";
        LIncidencia.Tarifa := "Tarifa aplicada";
        LIncidencia."Potencia contratada" := "Potencia contratada";
        LIncidencia."No. Mov. lectura" := "No. movimiento";
        LIncidencia.MODIFY;
        EXIT(LIncidencia."No. incidencia");
    end;

    [Scope('Internal')]
    procedure LecturaAmodificar(P_Lec: Record 50003)
    begin
        //carga los datos con las modificaciones

        Nuevo_CódigoIncidencia := P_Lec."Código Incidencia";
        Nuevo_ConsumoHLL := P_Lec."Consumo HLL";
        Nuevo_ConsumoHP := P_Lec."Consumo HP";
        Nuevo_ConsumoHV := P_Lec."Consumo HV";
        Nuevo_ConsumoB2 := P_Lec."Consumo B2";
        Nuevo_Fechalectura := P_Lec."Fecha lectura";
        Nuevo_LecturaHLL := P_Lec."Lectura HLL";
        Nuevo_LecturaHP := P_Lec."Lectura HP";
        Nuevo_LecturaHV := P_Lec."Lectura HV";
        Nuevo_LecturaB2 := P_Lec."Lectura B2";
        NuevoTotal := P_Lec.Total;
        Modificar := TRUE;
        GB_lectura := P_Lec;
    end;

    local procedure LimpiarEntrada()
    begin
        //limpiaVbles
        Nuevo_Fechalectura := 0D;
        Nuevo_NFacturaregistrada := '';
        //Nuevo_CódigoIncidencia:='';
        Nuevo_LecturaHP := 0;
        Nuevo_ConsumoHP := 0;
        Nuevo_LecturaHLL := 0;
        Nuevo_ConsumoHLL := 0;
        Nuevo_LecturaHV := 0;
        Nuevo_ConsumoHV := 0;
        Nuevo_LecturaB2 := 0;
        Nuevo_ConsumoB2 := 0;
        NuevoTotal := 0;
        //ZAM_MEP
        Nuevo_MeterNotAcces := FALSE;
        //ZAM_MEP END
    end;

    local procedure BorraAux()
    var
        lauxlec: Record 50003;
    begin
        //Borramos el registro que generamos en la 1º lectura en caso de que exista
        CLEAR(lauxlec);
        lauxlec.SETCURRENTKEY("No. Contador", "No. movimiento");
        lauxlec.SETRANGE("No. Contador", ContadorPpal);
        lauxlec.SETFILTER("Fecha lectura", '%1', 0D);
        IF lauxlec.FINDLAST THEN
            lauxlec.DELETE;
    end;

    local procedure testEntrada()
    begin
        IF (Nuevo_Fechalectura = 0D) THEN
            ERROR('Introduzca fecha');
    end;
}

