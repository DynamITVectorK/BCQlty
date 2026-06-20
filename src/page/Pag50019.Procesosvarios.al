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
            field(vFechaDesde; vFechaDesde)
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

                action(CargarSaldos)
                {
                    ApplicationArea = All;
                    Caption = 'Cargar Saldos';
                    Image = Import;
                    Visible = false;

                    trigger OnAction()
                    var
                        xmlSaldos: XmlPort 50004;
                    begin
                        xmlSaldos.Run();
                    end;
                }
                action(ActualizarConsumosMayo2017)
                {
                    ApplicationArea = All;
                    Caption = 'Actualizar consumos Mayo 2017';
                    Visible = false;

                    trigger OnAction()
                    begin
                        cuProcesos.fActualizarConsumos();
                    end;
                }
                action(ActualizarFechaAF)
                {
                    ApplicationArea = All;
                    Caption = 'Actualizar Fecha AF';
                    Visible = false;

                    trigger OnAction()
                    begin
                        cuProcesos.fActualizarAF();
                    end;
                }
                action(ActualizarClientesEnLecturas)
                {
                    ApplicationArea = All;
                    Caption = 'Actualizar Clientes en Lecturas';
                    Visible = false;

                    trigger OnAction()
                    begin
                        cuProcesos.fActualizarDatosLecturas();
                    end;
                }
                action(BorrarLecturasSinFecha)
                {
                    ApplicationArea = All;
                    Caption = 'Borrar Lecturas sin fecha';

                    trigger OnAction()
                    begin
                        cuProcesos.fBorrarLecturasVacias();
                    end;
                }
                action(EliminarLecturasAgua)
                {
                    ApplicationArea = All;
                    Caption = 'Eliminar Lecturas Agua';

                    trigger OnAction()
                    begin
                        cuProcesos.fBorrarLecturasAgua(vFechaDesde);
                    end;
                }
                action(EliminarLecturasElectricidad)
                {
                    ApplicationArea = All;
                    Caption = 'Eliminar Lecturas Electricidad';

                    trigger OnAction()
                    begin
                        cuProcesos.fBorrarLecturasElect(vFechaDesde);
                    end;
                }
                action(EliminarLecturasAguaElecFacturados)
                {
                    ApplicationArea = All;
                    Caption = 'Eliminar Lecturas Agua/Elec Facturados';

                    trigger OnAction()
                    begin
                        if vFechaDesde <> 0D then
                            if Confirm('Se van a borrar las fechas de facturación de agua y electricidad de la fecha seleccionada.  Desea continuar ?') then
                                cuProcesos.fBorrarFechaFacturacion(vFechaDesde);
                    end;
                }
                action(EliminarLineasPedidoConFechaFin)
                {
                    ApplicationArea = All;
                    Caption = 'Eliminar Lineas Pedido con fecha Fin';
                    Visible = false;

                    trigger OnAction()
                    begin
                        if Confirm('Se van a borrar las lineas de pedidos de venta con fecha fin servicio.  Desea continuar ?') then
                            cuProcesos.fBorrarLineasVtaConFechaFin();

                        Message('Proceso Finalizado');
                    end;
                }
                action(EliminarNroPreFacturas)
                {
                    ApplicationArea = All;
                    Caption = 'Eliminar Nro pre facturas';

                    trigger OnAction()
                    begin
                        if Confirm('Se van a borrar los nros de pre facturas de lecturas sin facturar.  Desea continuar ?') then
                            cuProcesos.fBorrarNroPreFacturas();

                        Message('Proceso Finalizado');
                    end;
                }
                action(CargarFechaInicioEnElectricidad)
                {
                    ApplicationArea = All;
                    Caption = 'Cargar Fecha inicio en Electricidad';

                    trigger OnAction()
                    begin
                        if Confirm('Se van a inicializar la fecha inicio en las lineas tipo vacío de los pedidos de electricidad.  Desea continuar ?') then
                            cuProcesos.fCargarFInicio();

                        Message('Proceso Finalizado');
                    end;
                }
            }
        }
        area(Promoted)
        {
            group(Category_Process)
            {
                Caption = 'Process';

                actionref(CargarSaldos_Promoted; CargarSaldos)
                {
                }
            }
        }
    }

    var
        cuProcesos: Codeunit 50000;
        vFechaDesde: Date;
}