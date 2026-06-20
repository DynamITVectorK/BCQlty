page 50071 "Posted Sales Invoices Accesos"
{
    // //***Z024 - 402 - AT- 03/03/2017 - Firma Electrónica de las facturas
    //                                    Nueva opción para "Generar facturas seleccionadas en PDF"

    Caption = 'Posted Sales Invoices';
    CardPageID = "Posted Sales Invoice";
    Editable = false;
    PageType = List;
    UsageCategory = Administration;
    SourceTable = "Sales Invoice Header";
    SourceTableView = WHERE("Concepto agrupador" = FILTER(ACCESOS));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.") { ApplicationArea = All; }
                field("Sell-to Customer No."; Rec."Sell-to Customer No.") { ApplicationArea = All; }
                field("Sell-to Customer Name"; Rec."Sell-to Customer Name") { ApplicationArea = All; }
                field("Currency Code"; Rec."Currency Code") { ApplicationArea = All; }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    begin
                        Rec.SetRange("No.");
                        Page.RunModal(Page::"Posted Sales Invoice", Rec);
                    end;
                }
                field("Amount Including VAT"; Rec."Amount Including VAT")
                {
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    begin
                        Rec.SetRange("No.");
                        Page.RunModal(Page::"Posted Sales Invoice", Rec);
                    end;
                }
                field("Sell-to Post Code"; Rec."Sell-to Post Code") { ApplicationArea = All; Visible = false; }
                field("Sell-to Country/Region Code"; Rec."Sell-to Country/Region Code") { ApplicationArea = All; Visible = false; }
                field("Sell-to Contact"; Rec."Sell-to Contact") { ApplicationArea = All; Visible = false; }
                field("Bill-to Customer No."; Rec."Bill-to Customer No.") { ApplicationArea = All; Visible = false; }
                field("Bill-to Name"; Rec."Bill-to Name") { ApplicationArea = All; Visible = false; }
                field("Bill-to Post Code"; Rec."Bill-to Post Code") { ApplicationArea = All; Visible = false; }
                field("Bill-to Country/Region Code"; Rec."Bill-to Country/Region Code") { ApplicationArea = All; Visible = false; }
                field("Bill-to Contact"; Rec."Bill-to Contact") { ApplicationArea = All; Visible = false; }
                field("Ship-to Code"; Rec."Ship-to Code") { ApplicationArea = All; Visible = false; }
                field("Ship-to Name"; Rec."Ship-to Name") { ApplicationArea = All; Visible = false; }
                field("Ship-to Post Code"; Rec."Ship-to Post Code") { ApplicationArea = All; Visible = false; }
                field("Ship-to Country/Region Code"; Rec."Ship-to Country/Region Code") { ApplicationArea = All; Visible = false; }
                field("Ship-to Contact"; Rec."Ship-to Contact") { ApplicationArea = All; Visible = false; }
                field("Posting Date"; Rec."Posting Date") { ApplicationArea = All; Visible = false; }
                field("Salesperson Code"; Rec."Salesperson Code") { ApplicationArea = All; Visible = false; }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code") { ApplicationArea = All; Visible = false; }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code") { ApplicationArea = All; Visible = false; }
                field("Location Code"; Rec."Location Code") { ApplicationArea = All; Visible = true; }
                field("No. Printed"; Rec."No. Printed") { ApplicationArea = All; }
                field("Document Date"; Rec."Document Date") { ApplicationArea = All; Visible = false; }
                field("Payment Terms Code"; Rec."Payment Terms Code") { ApplicationArea = All; Visible = false; }
                field("Due Date"; Rec."Due Date") { ApplicationArea = All; Visible = false; }
                field("Payment Discount %"; Rec."Payment Discount %") { ApplicationArea = All; Visible = false; }
                field("Shipment Method Code"; Rec."Shipment Method Code") { ApplicationArea = All; Visible = false; }
                field("Shipment Date"; Rec."Shipment Date") { ApplicationArea = All; Visible = false; }
                field("Document Exchange Status"; Rec."Document Exchange Status")
                {
                    ApplicationArea = All;
                    StyleExpr = DocExchStatusStyle;
                    trigger OnDrillDown()
                    begin
                        DocExchStatusDrillDown();
                    end;
                }
                field("Coupled to CRM"; Rec."Coupled to CRM") { ApplicationArea = All; Visible = CRMIntegrationEnabled; }
                field("E-Mail"; Rec."E-Mail") { ApplicationArea = All; }
                field("Concepto agrupador"; Rec."Concepto agrupador") { ApplicationArea = All; }
                field("Posting Description"; Rec."Posting Description") { ApplicationArea = All; }
                field("VAT Registration No."; Rec."VAT Registration No.") { ApplicationArea = All; }
            }
        }
        area(factboxes)
        {
            part(IncomingDocAttachFactBox; "Incoming Doc. Attach. FactBox")
            {
                ApplicationArea = All;
                ShowFilter = false;
            }
            systempart(Links; Links)
            {
                ApplicationArea = All;
                Visible = false;
            }
            systempart(Notes; Notes)
            {
                ApplicationArea = All;
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
                        Page.Run(Page::"Posted Sales Invoice", Rec);
                    end;
                }
                action(Statistics)
                {
                    ApplicationArea = All;
                    Caption = 'Statistics';
                    Image = Statistics;
                    RunObject = Page "Sales Invoice Statistics";
                    RunPageLink = "No." = FIELD("No.");
                    ShortCutKey = 'F7';
                }
                action("Co&mments")
                {
                    ApplicationArea = All;
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Sales Comment Sheet";
                    RunPageLink = "Document Type" = CONST("Posted Invoice"),
                                  "No." = FIELD("No.");
                }
                action(Dimensions)
                {
                    ApplicationArea = All;
                    AccessByPermission = TableData 348 = R;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';
                    trigger OnAction()
                    begin
                        ShowDimensions();
                    end;
                }
                action(IncomingDoc)
                {
                    ApplicationArea = All;
                    AccessByPermission = TableData 130 = R;
                    Caption = 'Incoming Document';
                    Image = Document;
                    trigger OnAction()
                    var
                        IncomingDocument: Record "Incoming Document";
                    begin
                        IncomingDocument.ShowCard(Rec."No.", Rec."Posting Date");
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
                        CRMIntegrationManagement.ShowCRMEntityFromRecordID(Rec.RecordId());
                    end;
                }
                action(CreateInCRM)
                {
                    ApplicationArea = All;
                    Caption = 'Create Invoice in Dynamics CRM';
                    Enabled = not CRMIsCoupledToRecord;
                    Image = NewInvoice;
                    trigger OnAction()
                    var
                        SalesInvoiceHeader: Record "Sales Invoice Header";
                        CRMIntegrationManagement: Codeunit "CRM Integration Management";
                        CRMCouplingManagement: Codeunit "CRM Coupling Management";
                        SalesInvoiceHeaderRecordRef: RecordRef;
                    begin
                        CurrPage.SetSelectionFilter(SalesInvoiceHeader);
                        SalesInvoiceHeader.Next();

                        if SalesInvoiceHeader.Count() = 1 then
                            CRMIntegrationManagement.CreateNewRecordInCRM(Rec.RecordId(), false)
                        else begin
                            SalesInvoiceHeaderRecordRef.GetTable(SalesInvoiceHeader);
                            CRMIntegrationManagement.CreateNewRecordsInCRM(SalesInvoiceHeaderRecordRef);
                        end;

                        repeat
                            if CRMCouplingManagement.IsRecordCoupledToCRM(SalesInvoiceHeader.RecordId()) then begin
                                SalesInvoiceHeader.Validate("Coupled to CRM", true);
                                SalesInvoiceHeader.Modify();
                            end;
                        until SalesInvoiceHeader.Next() = 0;
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
                trigger OnAction()
                var
                    SalesInvHeader: Record "Sales Invoice Header";
                begin
                    SalesInvHeader := Rec;
                    CurrPage.SetSelectionFilter(SalesInvHeader);
                    SalesInvHeader.SendRecords();
                end;
            }
            action("&Print")
            {
                ApplicationArea = All;
                Caption = '&Print';
                Ellipsis = true;
                Image = Print;
                trigger OnAction()
                var
                    SalesInvHeader: Record "Sales Invoice Header";
                begin
                    SalesInvHeader := Rec;
                    CurrPage.SetSelectionFilter(SalesInvHeader);
                    SalesInvHeader.PrintRecords(true);
                end;
            }
            action("&Email")
            {
                ApplicationArea = All;
                Caption = '&Email';
                Image = Email;
                trigger OnAction()
                var
                    SalesInvHeader: Record "Sales Invoice Header";
                begin
                    SalesInvHeader := Rec;
                    CurrPage.SetSelectionFilter(SalesInvHeader);
                    SalesInvHeader.EmailRecords(true);
                end;
            }
            action("&Navigate")
            {
                ApplicationArea = All;
                Caption = '&Navigate';
                Image = Navigate;
                trigger OnAction()
                begin
                    Navigate();
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
                    ActivityLog.ShowEntries(Rec.RecordId());
                end;
            }
            action("Generar facturas seleccionadas en PDF")
            {
                ApplicationArea = All;
                Caption = 'Generar facturas seleccionadas en PDF';
                Image = SendEmailPDFNoAttach;
                trigger OnAction()
                begin
                    fExportarFacturaElectronicaPDF(true);
                end;
            }
            action("Generar facturas seleccionadas en PDF WEB")
            {
                ApplicationArea = All;
                Caption = 'Generar facturas seleccionadas en PDF WEB';
                Image = SendEmailPDFNoAttach;
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
                Scope = Repeater;
                ToolTip = 'Create a credit memo for this posted invoice that you complete and post manually to reverse the posted invoice.';
                trigger OnAction()
                var
                    SalesHeader: Record "Sales Header";
                    CorrectPostedSalesInvoice: Codeunit "Correct Posted Sales Invoice";
                begin
                    CorrectPostedSalesInvoice.CreateCreditMemoCopyDocument(Rec, SalesHeader);
                    Page.Run(Page::"Sales Credit Memo", SalesHeader);
                end;
            }
        }
        area(Promoted)
        {
            group(Category_Invoice)
            {
                Caption = 'Invoice';

                actionref(Statistics_Promoted; Statistics) { }
                actionref(Comments_Promoted; "Co&mments") { }
                actionref(Dimensions_Promoted; Dimensions) { }
                actionref(IncomingDoc_Promoted; IncomingDoc) { }
            }
            group(Category_Process)
            {
                Caption = 'Process';

                actionref(SendCustom_Promoted; SendCustom) { }
                actionref(GeneratePdf_Promoted; "Generar facturas seleccionadas en PDF") { }
                actionref(GeneratePdfWeb_Promoted; "Generar facturas seleccionadas en PDF WEB") { }
            }
            group(Category_Navigate)
            {
                Caption = 'Navigate';

                actionref(Navigate_Promoted; "&Navigate") { }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    var
        CRMCouplingManagement: Codeunit "CRM Coupling Management";
    begin
        DocExchStatusStyle := GetDocExchStatusStyle();
        CurrPage.IncomingDocAttachFactBox.Page.LoadDataFromRecord(Rec);
        CRMIsCoupledToRecord := CRMIntegrationEnabled and CRMCouplingManagement.IsRecordCoupledToCRM(Rec.RecordId());
    end;

    trigger OnAfterGetRecord()
    begin
        DocExchStatusStyle := GetDocExchStatusStyle();
    end;

    trigger OnOpenPage()
    var
        CRMIntegrationManagement: Codeunit "CRM Integration Management";
    begin
        SetSecurityFilterOnRespCenter();
        CRMIntegrationEnabled := CRMIntegrationManagement.IsCRMIntegrationEnabled();
    end;

    var
        DocExchStatusStyle: Text;
        CRMIntegrationEnabled: Boolean;
        CRMIsCoupledToRecord: Boolean;
        tSalesInvHeader: Record "Sales Invoice Header";

    [Scope('Internal')]
    procedure fExportarFacturaElectronicaPDF(pSeleccionados: Boolean)
    begin
        Clear(tSalesInvHeader);

        if pSeleccionados then
            DevuelveSelecionados(tSalesInvHeader)
        else
            fDevuelveFiltroNoExportadasPDF(tSalesInvHeader);

        fCrearPDFFacturaE(tSalesInvHeader);
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
        CurrPage.SetSelectionFilter(RecFactVra);
    end;

    [Scope('Internal')]
    procedure fDevuelveFiltroNoExportadasPDF(var RecFactVra: Record "Sales Invoice Header")
    begin
        RecFactVra.SetRange("Factura E exportada PDF", false);
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
        IF tSalesInvHeader.FINDSET THEN BEGIN
          CLEAR(clFuncionesGenerales2);
          REPEAT
            CLEAR(tlSalesInvHeader2);
            tlSalesInvHeader2.SETRANGE("No.",tSalesInvHeader."No.");
            IF tlSalesInvHeader2.FINDFIRST THEN;
            clFuncionesGenerales2.fExportarFacturaE(tlSalesInvHeader2,1);
            tlSalesInvHeader2.MODIFY;
            COMMIT;
          UNTIL tSalesInvHeader.NEXT = 0;
          clFuncionesGenerales2.fMensaje(Text50000);
        END;
        //***Z024 - 402 - AT- 03/03/2017 - Fin
        */
    end;
}