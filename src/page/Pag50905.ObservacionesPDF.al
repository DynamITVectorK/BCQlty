page 50905 "Observaciones PDF"
{
    // //***Z001 -   4 - BGS - 27/04/15: Factura electrónica: generación, firma, subida y actualización

    PageType = StandardDialog;

    layout
    {
        area(content)
        {
            field(vObservaciones; vObservaciones)
            {
                ApplicationArea = All;
                MultiLine = true;

                trigger OnLookup(var Text: Text): Boolean
                begin
                    fvObservacionesOnLookUp();
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

    procedure fDevolverObservaciones(var pObservaciones: Text)
    begin
        pObservaciones := vObservaciones;
    end;

    procedure fSetDeseMotivoRectificacion(pDesdeMotivoRectificacion: Boolean)
    begin
        vDesdeMotivoRectificacion := pDesdeMotivoRectificacion;
    end;

    procedure fvObservacionesOnLookUp()
    var
        tlMaestroConfFactE: Record 50130;
        plMotivosRectificacion: Page 50902;
    begin
        if not vDesdeMotivoRectificacion then
            exit;

        //Página
        Clear(plMotivosRectificacion);
        plMotivosRectificacion.LookupMode(true);

        //Tabla
        Clear(tlMaestroConfFactE);
        tlMaestroConfFactE.SetRange(Tipo, tlMaestroConfFactE.Tipo::"Motivo rectificacion");

        //Si hay ya alguno definido
        if vObservaciones <> '' then begin
            //Nos posicionamos sobre el registro
            tlMaestroConfFactE.SetFilter(Codigo, vObservaciones);
            if tlMaestroConfFactE.FindFirst() then;
            plMotivosRectificacion.SetRecord(tlMaestroConfFactE);

            //Quitamos filtros
            tlMaestroConfFactE.SetRange(Codigo);
        end;

        //Abrimos
        plMotivosRectificacion.SetTableView(tlMaestroConfFactE);
        if plMotivosRectificacion.RunModal() = Action::LookupOK then begin
            plMotivosRectificacion.GetRecord(tlMaestroConfFactE);
            vObservaciones := Format(tlMaestroConfFactE.Codigo);
        end;
    end;
}