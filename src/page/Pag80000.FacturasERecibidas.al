page 80000 "FacturasE Recibidas"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Cabecera FacturaE Recibida";
    Caption = 'FacturasE Recibidas';
    Editable = true;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("ID Plataforma"; Rec."ID Plataforma")
                {
                    ApplicationArea = All;
                }
                field("Numero"; Rec."Numero")
                {
                    ApplicationArea = All;
                }
                field("Serie"; Rec."Serie")
                {
                    ApplicationArea = All;
                }
                field("Fecha Devengo"; Rec."Fecha Devengo")
                {
                    ApplicationArea = All;
                }
                field("Emisor CIF"; Rec."Emisor CIF")
                {
                    ApplicationArea = All;
                }
                field("Emisor Nombre"; Rec."Emisor Nombre")
                {
                    ApplicationArea = All;
                }
                field("Proveedor NAV"; Rec."Proveedor NAV")
                {
                    ApplicationArea = All;
                }
                field("Total Pagar"; Rec."Total Pagar")
                {
                    ApplicationArea = All;
                }
                field("Approval Status"; Rec."Approval Status")
                {
                    ApplicationArea = All;
                }
                field(Rechazada; Rec.Rechazada)
                {
                    ApplicationArea = All;
                }
                field(Registrada; Rec.Registrada)
                {
                    ApplicationArea = All;
                }
                field("Documento en Curso"; Rec."Documento en Curso")
                {
                    ApplicationArea = All;
                }
                field("Documento Registrado"; Rec."Documento Registrado")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ImportPending)
            {
                ApplicationArea = All;
                Caption = 'Importar pendientes';
                Image = Import;

                trigger OnAction()
                var
                    ImportOrchestrator: Codeunit "FacturaE Import Orchestrator";
                begin
                    ImportOrchestrator.ImportPending();
                    CurrPage.Update(false);
                end;
            }
            action(ImportXml)
            {
                ApplicationArea = All;
                Caption = 'Importar XML FacturaE';
                Image = Import;

                trigger OnAction()
                begin
                    Rec.ImportarXmlFacturaE();
                    CurrPage.Update(false);
                end;
            }
            action(Setup)
            {
                ApplicationArea = All;
                Caption = 'Configuración importación';
                Image = Setup;
                RunObject = page "FacturaE Import Setup";
            }
            action(ImportLog)
            {
                ApplicationArea = All;
                Caption = 'Log importación';
                Image = Setup;
                RunObject = page "FacturaE Import Log";
            }
            action(Approve)
            {
                ApplicationArea = All;
                Caption = 'Aprobar';
                Image = Approve;

                trigger OnAction()
                begin
                    Rec.ApproveEInvoice();
                    CurrPage.Update(false);
                end;
            }
            action(Reject)
            {
                ApplicationArea = All;
                Caption = 'Rechazar';
                Image = Reject;

                trigger OnAction()
                begin
                    Rec.RechazarFacturaEPaso1();
                    CurrPage.Update(false);
                end;
            }
            action(CreatePurchaseInvoice)
            {
                ApplicationArea = All;
                Caption = 'Crear factura compra';
                Image = CreateDocument;

                trigger OnAction()
                begin
                    Rec.Registrar(Rec, false);
                    CurrPage.Update(false);
                end;
            }
            action(ViewDocument)
            {
                ApplicationArea = All;
                Caption = 'Ver documento';
                Image = View;

                trigger OnAction()
                begin
                    Rec.VerFacturaE(Rec);
                end;
            }
        }
    }
}
