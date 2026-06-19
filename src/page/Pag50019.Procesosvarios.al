page 50019 "Procesos varios"
{
    // Pagina para llamado a procesos.
    // 1- Carga de saldos.

    PageType = Card;
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            field(vFechaDesde; Rec.vFechaDesde)
            {
                ApplicationArea = All;
                Caption = 'Fecha de la lectura';
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(Approval)
            {
                Caption = 'Approval';
                action("Cargar Saldos")
                {
                    ApplicationArea = All;
                    Caption = 'Cargar Saldos';
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    Visible = false;

                    trigger OnAction()
                    var
                        xmlSaldos: XMLport "50004";
                    begin
                        xmlSaldos.RUN;
                    end;
                }
                action("Actualizar consumos Mayo 2017")
                {
                    ApplicationArea = All;
                    Visible = false;

                    trigger OnAction()
                    begin
                        cuProcesos.fActualizarConsumos;
                    end;
                }
                action("Actualizar Fecha AF")
                {
                    ApplicationArea = All;
                    Visible = false;

                    trigger OnAction()
                    begin
                        cuProcesos.fActualizarAF;
                    end;
                }
                action("Actualizar Clientes en Lecturas")
                {
                    ApplicationArea = All;
                    Visible = false;

                    trigger OnAction()
                    begin
                        cuProcesos.fActualizarDatosLecturas;
                    end;
                }
                action("Borrar Lecturas sin fecha")
                {
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        cuProcesos.fBorrarLecturasVacias;
                    end;
                }
                action("Eliminar Lecturas Agua")
                {
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        cuProcesos.fBorrarLecturasAgua(vFechaDesde);
                    end;
                }
                action("Eliminar Lecturas Electricidad")
                {
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        cuProcesos.fBorrarLecturasElect(vFechaDesde);
                    end;
                }
                action("Eliminar Lecturas Agua/Elec Facturados")
                {
                    ApplicationArea = All;
                    Caption = 'Eliminar Lecturas Agua/Elec Facturados';

                    trigger OnAction()
                    begin
                        IF vFechaDesde <> 0D THEN
                            IF CONFIRM('Se van a borrar las fechas de facturación de agua y electricidad de la fecha seleccionada.  Desea continuar ?') THEN
                                cuProcesos.fBorrarFechaFacturacion(vFechaDesde);
                    end;
                }
                action("Eliminar Lineas Pedido con fecha Fin")
                {
                    ApplicationArea = All;
                    Caption = 'Eliminar Lineas Pedido con fecha Fin';
                    Visible = false;

                    trigger OnAction()
                    begin
                        IF CONFIRM('Se van a borrar las lineas de pedidos de venta con fecha fin servicio.  Desea continuar ?') THEN
                            cuProcesos.fBorrarLineasVtaConFechaFin;

                        MESSAGE('Proceso Finalizado');
                    end;
                }
                action("Eliminar Nro pre facturas")
                {
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        IF CONFIRM('Se van a borrar los nros de pre facturas de lecturas sin facturar.  Desea continuar ?') THEN
                            cuProcesos.fBorrarNroPreFacturas;

                        MESSAGE('Proceso Finalizado');
                    end;
                }
                action("Cargar Fecha inicio en Electricidad")
                {
                    ApplicationArea = All;
                    Caption = 'Cargar Fecha inicio en Electricidad';

                    trigger OnAction()
                    begin
                        IF CONFIRM('Se van a inicializar la fecha inicio en las lineas tipo vacío de los pedidos de electricidad.  Desea continuar ?') THEN
                            cuProcesos.fCargarFInicio;

                        MESSAGE('Proceso Finalizado');
                    end;
                }
            }
        }
    }

    var
        cuProcesos: Codeunit 50000;
        vFechaDesde: Date;
}

