page 50905 "Observaciones PDF"
{
    // //***Z001 -   4 - BGS - 27/04/15: Factura electrónica: generación, firma, subida y actualización


    layout
    {
        area(content)
        {
            field(vObservaciones; Rec.vObservaciones)
            {
                ApplicationArea = All;
                MultiLine = true;

                trigger OnLookup(var Text: Text): Boolean
                begin
                    fvObservacionesOnLookUp;
                end;
            }
        }
    }

    actions
    {
    }

    var
        vObservaciones: Text;
        vDesdeMotivoRectificacion: Boolean;

    [Scope('Internal')]
    procedure fDevolverObservaciones(var pObservaciones: Text)
    begin
        pObservaciones := vObservaciones;
    end;

    [Scope('Internal')]
    procedure fSetDeseMotivoRectificacion(pDesdeMotivoRectificacion: Boolean)
    begin
        vDesdeMotivoRectificacion := pDesdeMotivoRectificacion;
    end;

    [Scope('Internal')]
    procedure fvObservacionesOnLookUp()
    var
        tlMaestroConfFactE: Record 50130;
        plMotivosRectificacion: Page 50902;
    begin
        IF NOT vDesdeMotivoRectificacion THEN
            EXIT;

        //Página
        CLEAR(plMotivosRectificacion);
        plMotivosRectificacion.LOOKUPMODE(TRUE);

        //Tabla
        CLEAR(tlMaestroConfFactE);
        tlMaestroConfFactE.SETRANGE(Tipo, tlMaestroConfFactE.Tipo::"Motivo rectificacion");

        //Si hay ya alguno definido
        IF vObservaciones <> '' THEN BEGIN

            //Nos posicionamos sobre el registro
            tlMaestroConfFactE.SETFILTER(Codigo, vObservaciones);
            IF tlMaestroConfFactE.FINDFIRST THEN;
            plMotivosRectificacion.SETRECORD(tlMaestroConfFactE);

            //Quitamos filtros
            tlMaestroConfFactE.SETRANGE(Codigo);
        END;

        //Abrimos
        plMotivosRectificacion.SETTABLEVIEW(tlMaestroConfFactE);
        IF plMotivosRectificacion.RUNMODAL = ACTION::LookupOK THEN BEGIN
            plMotivosRectificacion.GETRECORD(tlMaestroConfFactE);
            vObservaciones := FORMAT(tlMaestroConfFactE.Codigo);
        END;
    end;
}

