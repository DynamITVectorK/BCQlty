page 50000 "Lecturas DORLET"
{
    // //***Z003 - 400 - AT- 25/10/2016 - Importación y gestión de lecturas DORLET

    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = Table50000;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Fecha ticket"; "Fecha ticket")
                {
                }
                field("No. Ticket"; "No. Ticket")
                {
                }
                field(Signo; Signo)
                {
                }
                field("Importe sin IVA"; "Importe sin IVA")
                {
                }
                field("% IVA"; "% IVA")
                {
                }
                field("Importe IVA"; "Importe IVA")
                {
                }
                field("No. Cliente"; "No. Cliente")
                {
                }
                field("CIF de la empresa"; "CIF de la empresa")
                {
                }
                field(Puesto; Puesto)
                {
                }
                field("Nº Pre factura"; "Nº Pre factura")
                {
                }
                field("Nº Factura registrada"; "Nº Factura registrada")
                {
                }
                field("Fecha factura registrada"; "Fecha factura registrada")
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group()
            {
                action("Importar Fichero y Generar Factura")
                {
                    Caption = 'Importar Fichero y Generar Facturas';

                    trigger OnAction()
                    var
                        tlSalesReceivablesSetup: Record "311";
                    begin
                        REPORT.RUN(50002, TRUE);
                    end;
                }
            }
        }
    }
}

