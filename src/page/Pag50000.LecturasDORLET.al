page 50000 "Lecturas DORLET"
{
    // //***Z003 - 400 - AT- 25/10/2016 - Importación y gestión de lecturas DORLET

    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    UsageCategory = Administration;
    SourceTable = 50000;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Fecha ticket"; "Fecha ticket")
                {
                    ApplicationArea = All;
                }
                field("No. Ticket"; "No. Ticket")
                {
                    ApplicationArea = All;
                }
                field(Signo; Signo)
                {
                    ApplicationArea = All;
                }
                field("Importe sin IVA"; "Importe sin IVA")
                {
                    ApplicationArea = All;
                }
                field("% IVA"; "% IVA")
                {
                    ApplicationArea = All;
                }
                field("Importe IVA"; "Importe IVA")
                {
                    ApplicationArea = All;
                }
                field("No. Cliente"; "No. Cliente")
                {
                    ApplicationArea = All;
                }
                field("CIF de la empresa"; "CIF de la empresa")
                {
                    ApplicationArea = All;
                }
                field(Puesto; Puesto)
                {
                    ApplicationArea = All;
                }
                field("Nº Pre factura"; "Nº Pre factura")
                {
                    ApplicationArea = All;
                }
                field("Nº Factura registrada"; "Nº Factura registrada")
                {
                    ApplicationArea = All;
                }
                field("Fecha factura registrada"; "Fecha factura registrada")
                {
                    ApplicationArea = All;
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
                    ApplicationArea = All;
                    Caption = 'Importar Fichero y Generar Facturas';

                    trigger OnAction()
                    var
                        tlSalesReceivablesSetup: Record "Sales & Receivables Setup";
                    begin
                        REPORT.RUN(50002, TRUE);
                    end;
                }
            }
        }
    }
}

