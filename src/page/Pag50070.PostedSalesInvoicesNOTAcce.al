page 50070 "Posted Sales Invoices NOT Acce"
{
    // //***Z024 - 402 - AT- 03/03/2017 - Firma Electrónica de las facturas
    //                                    Nueva opción para "Generar facturas seleccionadas en PDF"

    Caption = 'Posted Sales Invoices';
    CardPageID = "Posted Sales Invoice";
    Editable = false;
    PageType = List;
    UsageCategory = Administration;
    PromotedActionCategories = 'New,Process,Report,Invoice,Navigate';
    SourceTable = "Sales Invoice Header";
    SourceTableView = WHERE (Concepto agrupador=FILTER(<>ACCESOS));

    layout
    {
        area(content)
        {
            repeater()
            {
                field("No.";"No.")
                {
                    ApplicationArea = All;
                }
                field("Sell-to Customer No.";"Sell-to Customer No.")
                {
                    ApplicationArea = All;
                }
                field("Sell-to Customer Name";"Sell-to Customer Name")
                {
                    ApplicationArea = All;
                }
                field("Currency Code";"Currency Code")
                {
                    ApplicationArea = All;
                }
                field(Amount;Amount)
                {
                    ApplicationArea = All;

                    trigger OnDrillDown()
                    begin
                        SETRANGE("No.");
                        PAGE.RUNMODAL(132,Rec)
                    end;
                }
                field("Amount Including VAT";"Amount Including VAT")
                {
                    ApplicationArea = All;

                    trigger OnDrillDown()
                    begin
                        SETRANGE("No.");
                        PAGE.RUNMODAL(132,Rec)
                    end;
                }
                field("Sell-to Post Code";"Sell-to Post Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Sell-to Country/Region Code";"Sell-to Country/Region Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Sell-to Contact";"Sell-to Contact")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Bill-to Customer No.";"Bill-to Customer No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Bill-to Name";"Bill-to Name")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Bill-to Post Code";"Bill-to Post Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Bill-to Country/Region Code";"Bill-to Country/Region Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Bill-to Contact";"Bill-to Contact")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Ship-to Code";"Ship-to Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Ship-to Name";"Ship-to Name")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Ship-to Post Code";"Ship-to Post Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Ship-to Country/Region Code";"Ship-to Country/Region Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Ship-to Contact";"Ship-to Contact")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Posting Date";"Posting Date")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Salesperson Code";"Salesperson Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Shortcut Dimension 1 Code";"Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Shortcut Dimension 2 Code";"Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Location Code";"Location Code")
                {
                    ApplicationArea = All;
                    Visible = true;
                }
                field("No. Printed";"No. Printed")
                {
                    ApplicationArea = All;
                }
                field("Document Date";"Document Date")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Payment Terms Code";"Payment Terms Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Due Date";"Due Date")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Payment Discount %";"Payment Discount %")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Shipment Method Code";"Shipment Method Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Shipment Date";"Shipment Date")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Document Exchange Status";"Document Exchange Status")
                {
                    ApplicationArea = All;
                    StyleExpr = DocExchStatusStyle;

                    trigger OnDrillDown()
                    begin
                        DocExchStatusDrillDown;
                    end;
                }
                field("Coupled to CRM";"Coupled to CRM")
                {
                    ApplicationArea = All;
                    Visible = CRMIntegrationEnabled;
                }
                field("E-Mail";"E-Mail")
                {
                    ApplicationArea = All;
                }
                field("Concepto agrupador";"Concepto agrupador")
                {
                    ApplicationArea = All;
                }
                field("Posting Description";"Posting Description")
                {
                    ApplicationArea = All;
                }
                field("VAT Registration No.";"VAT Registration No.")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
            part(IncomingDocAttachFactBox;193)
            {
                ShowFilter = false;
            }
            systempart(;Links)
            {
                Visible = false;
            }
            systempart(;Notes)
            {
                Visible = true;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Invoice")
            {
                Caption = '&Invoice';
                Image = Invoice;
                action(Card)
                {
                    ApplicationArea = All;
                    Caption = 'Card';
                    Image = EditLines;
                    ShortCutKey = 'Shift+F7';

                    trigger OnAction()
                    begin
                        PAGE.RUN(132,Rec)
                    end;
                }
                action(Statistics)
                {
                    ApplicationArea = All;
                    Caption = 'Statistics';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    RunObject = Page 397;
                                    RunPageLink = No.=FIELD(No.);
                    ShortCutKey = 'F7';
                }
                action("Co&mments")
                {
                    ApplicationArea = All;
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    RunObject = Page 67;
                                    RunPageLink = Document Type=CONST(Posted Invoice),
                                  No.=FIELD(No.);
                }
                action(Dimensions)
                {
                    ApplicationArea = All;
                    AccessByPermission = TableData 348=R;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    ShortCutKey = 'Shift+Ctrl+D';

                    trigger OnAction()
                    begin
                        ShowDimensions;
                    end;
                }
                action(IncomingDoc)
                {
                    ApplicationArea = All;
                    AccessByPermission = TableData 130=R;
                    Caption = 'Incoming Document';
                    Image = Document;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        IncomingDocument: Record "Incoming Document";
                    begin
                        IncomingDocument.ShowCard("No.","Posting Date");
                    end;
                }
            }
            group(ActionGroupCRM)
            {
                Caption = 'Dynamics CRM';
                Visible = CRMIntegrationEnabled;
                action(CRMGotoInvoice)
                {
                    ApplicationArea = All;
                    Caption = 'Invoice';
                    Enabled = CRMIsCoupledToRecord;
                    Image = CoupledInvoice;
                    ToolTip = 'Open the coupled Microsoft Dynamics CRM account.';

                    trigger OnAction()
                    var
                        CRMIntegrationManagement: Codeunit "CRM Integration Management";
                    begin
                        CRMIntegrationManagement.ShowCRMEntityFromRecordID(RECORDID);
                    end;
                }
                action(CreateInCRM)
                {
                    ApplicationArea = All;
                    Caption = 'Create Invoice in Dynamics CRM';
                    Enabled = NOT CRMIsCoupledToRecord;
                    Image = NewInvoice;

                    trigger OnAction()
                    var
                        SalesInvoiceHeader: Record "Sales Invoice Header";
                        CRMIntegrationManagement: Codeunit "CRM Integration Management";
                        CRMCouplingManagement: Codeunit "CRM Coupling Management";
                        SalesInvoiceHeaderRecordRef: RecordRef;
                    begin
                        CurrPage.SETSELECTIONFILTER(SalesInvoiceHeader);
                        SalesInvoiceHeader.NEXT;

                        IF SalesInvoiceHeader.COUNT = 1 THEN
                          CRMIntegrationManagement.CreateNewRecordInCRM(RECORDID,FALSE)
                        ELSE BEGIN
                          SalesInvoiceHeaderRecordRef.GETTABLE(SalesInvoiceHeader);
                          CRMIntegrationManagement.CreateNewRecordsInCRM(SalesInvoiceHeaderRecordRef);
                        END;

                        REPEAT
                          IF CRMCouplingManagement.IsRecordCoupledToCRM(SalesInvoiceHeader.RECORDID) THEN BEGIN
                            SalesInvoiceHeader.VALIDATE("Coupled to CRM",TRUE);
                            SalesInvoiceHeader.MODIFY;
                          END;
                        UNTIL SalesInvoiceHeader.NEXT = 0;
                    end;
                }
            }
        }
        area(processing)
        {
            action(SendCustom)
            {
                ApplicationArea = All;
                Caption = 'Send';
                Ellipsis = true;
                Image = SendToMultiple;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    SalesInvHeader: Record "Sales Invoice Header";
                begin
                    SalesInvHeader := Rec;
                    CurrPage.SETSELECTIONFILTER(SalesInvHeader);
                    SalesInvHeader.SendRecords;
                end;
            }
            action("&Print")
            {
                ApplicationArea = All;
                Caption = '&Print';
                Ellipsis = true;
                Image = Print;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;

                trigger OnAction()
                var
                    SalesInvHeader: Record "Sales Invoice Header";
                begin
                    SalesInvHeader := Rec;
                    CurrPage.SETSELECTIONFILTER(SalesInvHeader);
                    SalesInvHeader.PrintRecords(TRUE);
                end;
            }
            action("&Email")
            {
                ApplicationArea = All;
                Caption = '&Email';
                Image = Email;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;

                trigger OnAction()
                var
                    SalesInvHeader: Record "Sales Invoice Header";
                begin
                    SalesInvHeader := Rec;
                    CurrPage.SETSELECTIONFILTER(SalesInvHeader);
                    SalesInvHeader.EmailRecords(TRUE);
                end;
            }
            action("&Navigate")
            {
                ApplicationArea = All;
                Caption = '&Navigate';
                Image = Navigate;
                Promoted = true;
                PromotedCategory = Category5;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Navigate;
                end;
            }
            action(ActivityLog)
            {
                ApplicationArea = All;
                Caption = 'Activity Log';
                Image = Log;

                trigger OnAction()
                var
                    ActivityLog: Record "Activity Log";
                begin
                    ActivityLog.ShowEntries(RECORDID);
                end;
            }
            action("Generar facturas seleccionadas en PDF")
            {
                ApplicationArea = All;
                Caption = 'Generar facturas seleccionadas en PDF';
                Image = SendEmailPDFNoAttach;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    //***Z024 - 402 - AT- 03/03/2017 - Inicio
                    fExportarFacturaElectronicaPDF(TRUE);
                    //***Z024 - 402 - AT- 03/03/2017 - Fin
                end;
            }
            action("Generar facturas seleccionadas en PDF WEB")
            {
                ApplicationArea = All;
                Caption = 'Generar facturas seleccionadas en PDF WEB';
                Image = SendEmailPDFNoAttach;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = false;

                trigger OnAction()
                begin
                    //***Z029 - AT - 16/01/18 - Inicio
                    //fExportarFacturaWEB(TRUE);
                    //***Z029 - AT - 16/01/18 - Fin
                end;
            }
            action(CreateCreditMemo)
            {
                ApplicationArea = All;
                Caption = 'Create Corrective Credit Memo';
                Image = CreateCreditMemo;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Category6;
                Scope = Repeater;
                ToolTip = 'Create a credit memo for this posted invoice that you complete and post manually to reverse the posted invoice.';

                trigger OnAction()
                var
                    SalesHeader: Record "Sales Header";
                    CorrectPostedSalesInvoice: Codeunit "Correct Posted Sales Invoice";
                begin
                    CorrectPostedSalesInvoice.CreateCreditMemoCopyDocument(Rec,SalesHeader);
                    PAGE.RUN(PAGE::"Sales Credit Memo",SalesHeader);
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    var
        CRMCouplingManagement: Codeunit "CRM Coupling Management";
    begin
        DocExchStatusStyle := GetDocExchStatusStyle;
        CurrPage.IncomingDocAttachFactBox.PAGE.LoadDataFromRecord(Rec);
        CRMIsCoupledToRecord := CRMIntegrationEnabled AND CRMCouplingManagement.IsRecordCoupledToCRM(RECORDID);
    end;

    trigger OnAfterGetRecord()
    begin
        DocExchStatusStyle := GetDocExchStatusStyle;
    end;

    trigger OnOpenPage()
    var
        CRMIntegrationManagement: Codeunit "CRM Integration Management";
    begin
        SetSecurityFilterOnRespCenter;
        CRMIntegrationEnabled := CRMIntegrationManagement.IsCRMIntegrationEnabled;
    end;

    var
        DocExchStatusStyle: Text;
        CRMIntegrationEnabled: Boolean;
        CRMIsCoupledToRecord: Boolean;
        tSalesInvHeader: Record "Sales Invoice Header";

    [Scope('Internal')]
    procedure fExportarFacturaElectronicaPDF(pSeleccionados: Boolean)
    begin
        //Función que exporta la o las facturas electrónicas a uno o varios PDF

        //***Z024 - 402 - AT- 03/03/2017 - Inicio

        //Limpiamos variable
        CLEAR(tSalesInvHeader);

        //Devolvemos seleccionados
        IF pSeleccionados THEN
          DevuelveSelecionados(tSalesInvHeader)
        ELSE
          fDevuelveFiltroNoExportadasPDF(tSalesInvHeader);

        //Exportamos
        fCrearPDFFacturaE(tSalesInvHeader);

        //***Z024 - 402 - AT- 03/03/2017 - Fin
    end;

    [Scope('Internal')]
    procedure fExportarFacturaWEB(pSeleccionados: Boolean)
    begin
        //Función que exporta la o las facturas electrónicas a uno o varios PDF

        //***Z029 - AT - 16/01/18 - Inicio

        //CLEAR(tSalesInvHeader);

        //IF pSeleccionados THEN
        //  DevuelveSelecionados(tSalesInvHeader)
        //ELSE
        //  fDevuelveFiltroNoExportadasPDF(tSalesInvHeader);

        //fCrearPDFFacturaWEB(tSalesInvHeader);

        //***Z029 - AT - 16/01/18 - Fin
    end;

    [Scope('Internal')]
    procedure DevuelveSelecionados(var RecFactVra: Record "Sales Invoice Header")
    begin
        CurrPage.SETSELECTIONFILTER(RecFactVra);
    end;

    [Scope('Internal')]
    procedure fDevuelveFiltroNoExportadasPDF(var RecFactVra: Record "Sales Invoice Header")
    begin
        //Función que devuelve el filtro de las facturas no exportadas

        //***Z024 - 402 - AT- 03/03/2017 - Inicio
        RecFactVra.SETRANGE("Factura E exportada PDF",FALSE);
        //***Z024 - 402 - AT- 03/03/2017 - Fin
    end;

    [Scope('Internal')]
    procedure fExportarFacturaEPDFDesdePagina()
    var
        tlSalesInvHeader2: Record "Sales Invoice Header";
        tlSalesInvHeader3: Record "Sales Invoice Header";
        vlGenerarPDF: Boolean;
    begin
        //Función que exporta la o las facturas electrónicas a uno o varios PDF pero desde la página
        /*
        //***Z024 - 402 - AT- 03/03/2017 - Inicio
        
        //Nos vamos recorriendo cada una de las facturas
        IF tSalesInvHeader.FINDSET THEN BEGIN
        
          //Limpiamos Codeunit
          CLEAR(clFuncionesGenerales2);
        
          //Inicializamos ventana de dialogo
          //CLEAR(vDialog);
          //vDialog.OPEN(Text50001);
        
          REPEAT
            //Actualizamos ventana de diálogo
            //vDialog.UPDATE(1,tSalesInvHeader."No.");
        
            //Filtro único
            CLEAR(tlSalesInvHeader2);
            tlSalesInvHeader2.SETRANGE("No.",tSalesInvHeader."No.");
            IF tlSalesInvHeader2.FINDFIRST THEN;
        
            //Exportamos la factura y la marcamos como tal
            clFuncionesGenerales2.fExportarFacturaE(tlSalesInvHeader2,1);
            tlSalesInvHeader2.MODIFY;
        
            //COMMIT porque si exportamos muchas y hay algún error, el fichero se creará pero no quedará marcada la factura como exportada
            COMMIT;
        
          UNTIL tSalesInvHeader.NEXT = 0;
        
          //Cerramos ventana de diálogo
          //vDialog.CLOSE;
        
          //Mensaje
          clFuncionesGenerales2.fMensaje(Text50000);
        
        END;
        //***Z024 - 402 - AT- 03/03/2017 - Fin
        */

    end;
}

