page 50030 registrarFactura
{
    PageType = List;
    SourceTable = Table50014;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(QR_URL; QR_URL)
                {
                }
                field(QR_ID; QR_ID)
                {
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetCurrRecord()
    begin
        /*
        QR_URL:='https://batuz.eus/QRTBAI/?id=TBAI-78871042V-031120-epEs2rfuC2EoP-207&s=DFB_2020&nf=7&i=299.5&cr=046&authenticated=false#/';
        QR_ID:='TBAI-78871042V-031120-epEs2rfuC2EoP-207';
        */

    end;

    trigger OnAfterGetRecord()
    begin
        /*
        // ACTIVAR EN PRODUCCION Y PARA PRUEBAS WEB ADOS
        MESSAGE(FORMAT(NumReg));
        
        IF NumFacturaADOS<>'' THEN BEGIN
           CLEAR(rRegistroADOS);
           rRegistroADOS.fRegistroWS(NumFacturaADOS); //Crear factura
           COMMIT;
           //Registrar factura
           CLEAR(tSalesHeader);
           tSalesHeader.SETRANGE("No.",NumFacturaADOS);
           IF tSalesHeader.FINDSET THEN BEGIN
              MESSAGE('Entra');
           END;
        END;
        */
        //
        /*
        QR_URL:='https://batuz.eus/QRTBAI/?id=TBAI-78871042V-031120-epEs2rfuC2EoP-207&s=DFB_2020&nf=7&i=299.5&cr=046&authenticated=false#/';
        QR_ID:='TBAI-78871042V-031120-epEs2rfuC2EoP-207';
        */

    end;

    trigger OnFindRecord(Which: Text): Boolean
    var
        SalesHeader: Record "36";
    begin
    end;

    trigger OnOpenPage()
    var
        FactAdos: Record "50014";
    begin
        /*
        FactAdos.SETFILTER(Origen, 'BO|AB');
        FactAdos.SETRANGE(Tratado, FALSE);
        IF FactAdos.FINDFIRST THEN REPEAT
          IF FactAdos.NumFacturaADOS<>'' THEN BEGIN
             CLEAR(rRegistroADOS);
             rRegistroADOS.fRegistroWS(FactAdos.NumFacturaADOS); //Crear factura
             COMMIT;
             //Registrar factura
        {     CLEAR(tSalesHeader);
             tSalesHeader.SETRANGE("No.",FactAdos.NumFacturaADOS);
             IF tSalesHeader.FINDSET THEN BEGIN
                MESSAGE('Entra');
             END;}
          END;
        UNTIL FactAdos.NEXT = 0;
        */

        FactAdos.SETFILTER(Origen, 'BO|AB|TK');
        FactAdos.SETRANGE(Tratado, FALSE);
        IF FactAdos.FINDFIRST THEN
            REPEAT
                IF FactAdos.NumFacturaADOS <> '' THEN BEGIN
                    IF (FactAdos.Origen = 'TK') AND (FactAdos.Cantidad > 0) AND (FactAdos.MedPago = 'FACTIQUE') THEN BEGIN
                        CLEAR(rRegistroADOS);
                        rRegistroADOS.fRegistroWS(FactAdos.NumFacturaADOS); //Crear factura
                        COMMIT;
                    END ELSE BEGIN
                        IF (FactAdos.Origen <> 'TK') THEN BEGIN
                            CLEAR(rRegistroADOS);
                            rRegistroADOS.fRegistroWS(FactAdos.NumFacturaADOS); //Crear factura
                            COMMIT;
                        END;
                    END;
                END;
            UNTIL FactAdos.NEXT = 0;

    end;

    var
        rRegistroADOS: Report "50009";
        tSalesHeader: Record "36";
}

