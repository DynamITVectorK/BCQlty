page 90014 ZAMTBRoleCenter
{
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
            group(Control1900724808)
            {
                part(; 90016)
                {
                }
            }
            group(Control1900724708)
            {
                part(; 675)
                {
                    Visible = false;
                }
                part(; 681)
                {
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            ToolTip = 'Manage sales processes. See KPIs and your favorite items and customers.';
            action(SalesOrders)
            {
                Caption = 'Pedidos venta';
                Image = "order";
                RunObject = Page 9305;
                ToolTip = 'Abre la lista de pedidos de venta, donde puede vender productos y servicios.';
            }
            action(SalesOrdersShptNotInv)
            {
                Caption = 'Enviado no facturado';
                Image = OrderList;
                RunObject = Page 9305;
                RunPageView = WHERE (Shipped Not Invoiced=CONST(Yes));
                ToolTip = 'Permite ver las ventas enviadas que todavía no se han facturado.';
            }
            action(SalesOrdersComplShtNotInv)
            {
                Caption = 'Enviados por completo no facturados';
                Image = Sales;
                RunObject = Page 9305;
                RunPageView = WHERE (Completely Shipped=CONST(Yes),
                                    Invoice=CONST(No));
                ToolTip = 'Enviados por completo no facturados';
            }
            action("Dynamics CRM Sales Orders")
            {
                Caption = 'Pedidos de ventas de Dynamics CRM';
                Image = SalesInvoice;
                RunObject = Page 5353;
                RunPageView = WHERE (StateCode = FILTER (Submitted),
                                    LastBackofficeSubmit = FILTER (''));
                ToolTip = 'View sales orders in Dynamics CRM that are coupled with sales orders in Dynamics NAV.';
            }
            action("Sales Quotes")
            {
                Caption = 'Ofertas Venta';
                Image = Quote;
                RunObject = Page 9300;
                ToolTip = 'Abre la lista de ofertas de ventas, donde puede ofrecer productos o servicios a los clientes.';
            }
            action("Blanket Sales Orders")
            {
                Caption = 'Pedidos abiertos venta';
                Image = "BlanketOrder<Undefined>";
                RunObject = Page 9303;
            }
            action("Sales Invoices")
            {
                Caption = 'Facturas venta';
                Image = Invoice;
                RunObject = Page 9301;
                ToolTip = 'Abre la lista de facturas de venta, donde puede facturar productos o servicios';
            }
            action("Sales Return Orders")
            {
                Caption = 'Devoluciones ventas';
                Image = ReturnOrder;
                RunObject = Page 9304;
            }
            action("Sales Credit Memos")
            {
                Caption = 'Abonos de venta';
                Image = CreditMemo;
                RunObject = Page 9302;
                ToolTip = 'Abre la lista de abonos de venta, donde puede revertir facturas de venta registradas.';
            }
            action(Items)
            {
                Caption = 'Productos';
                Image = "Item<Undefined>";
                RunObject = Page 31;
                ToolTip = 'Abre la lista de productos que puede comercializar.';
            }
            action(Customers)
            {
                Caption = 'Customers';
                Image = "Customer<Undefined>";
                RunObject = Page 22;
                ToolTip = 'Abre la lista de clientes.';
            }
            action("Item Journals")
            {
                Caption = 'Diarios de productos';
                Image = Journals;
                RunObject = Page 262;
                RunPageView = WHERE (Template Type=CONST(Item),
                                    Recurring=CONST(No));
                ToolTip = 'Abre una lista de diarios, donde puede ajustar la cantidad física de productos en stock.';
            }
            action(SalesJournals)
            {
                Caption = 'Diarios de ventas';
                RunObject = Page 251;
                RunPageView = WHERE (Template Type=CONST(Sales),
                                    Recurring=CONST(No));
            }
            action(CashReceiptJournals)
            {
                Caption = 'Diarios de recibos de efectivo';
                Image = CashReceiptJournal;
                RunObject = Page 251;
                RunPageView = WHERE (Template Type=CONST(Cash Receipts),
                                    Recurring=CONST(No));
            }
            group("Posted Documents")
            {
                Caption = 'Documentos históricos';
                Image = FiledPosted;
                action("Posted Sales Shipments")
                {
                    Caption = 'Histórico albaranes venta';
                    Image = PostedShipment;
                    RunObject = Page 142;
                }
                action("Posted Sales Invoices")
                {
                    Caption = 'Histórico facturas venta';
                    Image = "PostedOrder<Undefined>";
                    RunObject = Page 143;
                }
                action("Posted Return Receipts")
                {
                    Image = PostedReturnReceipt;
                    RunObject = Page 6662;
                    ToolTip = 'Histórico recep. devolución';
                }
                action("Posted Sales Credit Memos")
                {
                    Caption = 'Histórico abonos venta';
                    Image = PostedOrder;
                    RunObject = Page 144;
                }
                action("Posted Purchase Receipts")
                {
                    Caption = 'Posted Purchase Receipts';
                    Image = PostedReceipts;
                    RunObject = Page 145;
                }
                action("Posted Purchase Invoices")
                {
                    Caption = 'Histórico facturas compra';
                    Image = PostedTaxInvoice;
                    RunObject = Page 146;
                }
            }
            group("Self-Service")
            {
                Caption = 'Autoservicio';
                Image = HumanResources;
                action("Time Sheets")
                {
                    Caption = 'Time Sheets';
                    Image = "Timesheet<Undefined>";
                    RunObject = Page 951;
                }
            }
            group(creation)
            {
                action("Sales Quote")
                {
                    Caption = 'Sales Quote';
                    Image = NewSalesQuote;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page 41;
                }
                action("Sales Invoice")
                {
                    Caption = 'Factura venta';
                    Image = NewSalesInvoice;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page 43;
                }
                action("Sales Order")
                {
                    Caption = 'Pedido venta';
                    Image = Document;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page 42;
                }
                action("Sales Return Order")
                {
                    Caption = 'Devolución venta';
                    Image = ReturnOrder;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page 6630;
                }
                action("Sales Credit Memo")
                {
                    Caption = 'Abono venta';
                    Image = CreditMemo;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page 44;
                }
            }
            group(Tasks)
            {
                Caption = 'tareas';
                action("Sales Journal")
                {
                    Caption = 'Diario ventas';
                    Image = Journals;
                    RunObject = Page 253;
                }
                action("Sales Price Worksheet")
                {
                    Caption = 'Hoja precios venta';
                    Image = PriceWorksheet;
                    RunObject = Page 7023;
                }
            }
            group(sales)
            {
                Caption = 'Ventas';
                action(Prices)
                {
                    Caption = 'Precios';
                    Image = SalesPrices;
                    RunObject = Page 7002;
                }
                action("Line Discounts")
                {
                    Caption = 'Descuentos línea';
                    Image = SalesLineDisc;
                    RunObject = Page 7004;
                }
            }
            group(reports)
            {
                Caption = 'Informes';
                group(Customer)
                {
                    Caption = 'Cliente';
                    Image = Customer;
                    action("Customer - Order Summary")
                    {
                        Caption = 'Cliente - Total pedidos';
                        Image = "Report";
                        RunObject = Report 107;
                    }
                    action("Customer - Top 10 List")
                    {
                        Caption = 'Cliente - Listado 10 mejores';
                        Image = "Report";
                        RunObject = Report 111;
                    }
                    action("Customer - Item Sales")
                    {
                        Caption = 'Cliente - Ventas por productos';
                        Image = "Report";
                        RunObject = Report 113;
                    }
                }
                group(ActionGroup1000000005)
                {
                    Caption = 'Ventas';
                    Image = Sales;
                    action("Salesperson - Sales Statistics")
                    {
                        Caption = 'Vendedor - Estadísticas ventas';
                        Image = "Report";
                        RunObject = Report 114;
                    }
                    action("Price List")
                    {
                        Caption = 'Lista de precios';
                        Image = "Report";
                        RunObject = Report 715;
                    }
                    action("Inventory - Sales Back Orders")
                    {
                        Caption = 'Inventario: &pedidos pendientes de ventas';
                        Image = "Report<Undefined>";
                        RunObject = Report 718;
                    }
                }
                group(History)
                {
                    Caption = 'Historial';
                    action(Navigate)
                    {
                        Caption = 'Navegar';
                        Image = Navigate;
                        RunObject = Page 344;
                    }
                }
            }
        }
    }
}

