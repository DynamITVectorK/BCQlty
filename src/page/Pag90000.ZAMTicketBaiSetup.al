page 90000 ZAMTicketBaiSetup
{
    // Z0041GEN PBS 17/12/21: TicketBai.
    // Z170 PBS 01/06/21.

    Caption = 'TBSupplySetup';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    UsageCategory = Administration;
    PromotedActionCategories = 'New,Process,Report';
    SourceTable = 90000;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("ZAM_Activate Ticket Bai"; Rec."ZAM_Activate Ticket Bai")
                {
                    ApplicationArea = All;
                }
                field(ZAM_SendAutoTB; Rec.ZAM_SendAutoTB)
                {
                    ApplicationArea = All;
                }
                field("ZAM_Activate Batuz"; Rec."ZAM_Activate Batuz")
                {
                    ApplicationArea = All;
                }
                field("Version No."; Rec."ZAM_Version No.")
                {
                    ApplicationArea = All;
                }
                field("ZAM_Version No. Batuz"; Rec."ZAM_Version No. Batuz")
                {
                    ApplicationArea = All;
                }
                field("Settlement Period"; Rec."ZAM_Settlement Period")
                {
                    ApplicationArea = All;
                }
                field("ES VAT Registration Type"; Rec."ZAM_ES VAT Registration Type")
                {
                    ApplicationArea = All;
                    LookupPageID = ZAMVATRegistrationType;
                }
                field("Total Type"; Rec."ZAM_Total Type")
                {
                    ApplicationArea = All;
                }
                field("Macrodata Amount"; Rec."ZAM_Macrodata Amount")
                {
                    ApplicationArea = All;
                }
                field(Agency; Rec.ZAM_Agency)
                {
                    ApplicationArea = All;
                }
                group(Comunication)
                {
                    Caption = 'Communication';
                    field("Set Up Communication"; Rec."ZAM_Set Up Communication")
                    {
                        ApplicationArea = All;
                        LookupPageID = ZAMCommunicationTypes;
                    }
                    field("Modification Communication"; Rec."ZAM_Modification Communication")
                    {
                        ApplicationArea = All;
                        LookupPageID = ZAMCommunicationTypes;
                    }
                }
            }
            group("Sales Documents Book")
            {
                Caption = 'Sales Documents Book';
                field("Sales Invoice"; Rec."ZAM_Sales Invoice")
                {
                    ApplicationArea = All;
                    LookupPageID = ZAMSalesDocumentType;
                }
                field("Sales Cr.Memo"; Rec."ZAM_Sales Cr.Memo")
                {
                    ApplicationArea = All;
                    LookupPageID = ZAMSalesDocumentType;
                }
                field("Sales Documents URL"; Rec."ZAM_Sales Documents URL")
                {
                    ApplicationArea = All;
                }
                field("Sales Real Estate URL"; Rec."ZAM_Sales Real Estate URL")
                {
                    ApplicationArea = All;
                }
                field(ZAM_IdentifierURL; Rec.ZAM_IdentifierURL)
                {
                    ApplicationArea = All;
                }
                field(ZAM_SimpledInvoice; Rec.ZAM_SimpledInvoice)
                {
                    ApplicationArea = All;
                }
                field(ZAM_SimpledCRMemo; Rec.ZAM_SimpledCRMemo)
                {
                    ApplicationArea = All;
                }
                field(ZAM_SimpInvSerialNo; Rec.ZAM_SimpInvSerialNo)
                {
                    ApplicationArea = All;
                }
                field(ZAM_SimpCRSerialNo; Rec.ZAM_SimpCRSerialNo)
                {
                    ApplicationArea = All;
                }
                field("ZAM DUA Document"; Rec."ZAM DUA Document")
                {
                    ApplicationArea = All;
                }
            }
            group(Certificate)
            {
                Caption = 'Certificate';
                field(Enabled; Rec.ZAM_Enabled)
                {
                    ApplicationArea = All;
                }
                field("Certificate Installed"; Rec.ZAM_Certificate.HASVALUE())
                {
                    ApplicationArea = All;
                    Caption = 'Certificate Installed';
                    Editable = false;
                }
                field(Password; Rec.ZAM_Password)
                {
                    ApplicationArea = All;
                }
            }
            group(NamespacePrefix)
            {
                Caption = 'Namespaces and Prefixes';
                field("General Namespace"; Rec."ZAM_General Namespace")
                {
                    ApplicationArea = All;
                }
                field(ZAM_SoftwareVersion; Rec.ZAM_SoftwareVersion)
                {
                    ApplicationArea = All;
                }
            }
            group(QR)
            {
                Caption = 'QR';
                field(ZAM_QR_URL; Rec.ZAM_QR_URL)
                {
                    ApplicationArea = All;
                }
                field(ZAM_QRHeight; Rec.ZAM_QRHeight)
                {
                    ApplicationArea = All;
                }
                field(ZAM_QRWeight; Rec.ZAM_QRWeight)
                {
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
            systempart(; Links)
            {
                Visible = false;
            }
            systempart(; Notes)
            {
                Visible = false;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Payment)
            {
                Caption = 'Payment';
                action("Payment Methods")
                {
                    ApplicationArea = All;
                    Caption = 'Payment Methods';
                    Image = Payment;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page 427;
                    ToolTip = 'Set up the payment methods that you select from the customer card to define how the customer must pay, for example by bank transfer.';
                }
                action("Payment Terms")
                {
                    ApplicationArea = All;
                    Caption = 'Payment Terms';
                    Image = Payment;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page 4;
                    ToolTip = 'Set up the payment terms that you select from on customer cards to define when the customer must pay, such as within 14 days.';
                }
            }
        }
        area(processing)
        {
            action(ImportCert)
            {
                ApplicationArea = All;
                Caption = 'Import digital certificate';
                Image = UserCertificate;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Choose your digital certificate file, and import it. You will need it to send the IIS document.';

                trigger OnAction()
                begin
                    Rec.ImportCertificate();
                end;
            }
            action(ImportCertIZENPE)
            {
                ApplicationArea = All;
                Caption = 'Importar Certificado Izenpe';

                trigger OnAction()
                begin
                    Rec.ImportCertificateIZENPE();
                end;
            }
            action(BORRARCERT)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin
                    CLEAR(Rec.ZAM_Cert_Izenpe);
                    CLEAR(ZAM_Certificate);

                    Rec.MODIFY;
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.RESET();
        IF NOT Rec.GET() THEN BEGIN
            Rec.INIT();
            Rec.INSERT();
        END;
    end;
}

