page 90000 ZAMTicketBaiSetup
{
    // Z0041GEN PBS 17/12/21: TicketBai.
    // Z170 PBS 01/06/21.

    Caption = 'TBSupplySetup';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Report';
    SourceTable = Table90000;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("ZAM_Activate Ticket Bai"; "ZAM_Activate Ticket Bai")
                {
                }
                field(ZAM_SendAutoTB; ZAM_SendAutoTB)
                {
                }
                field("ZAM_Activate Batuz"; "ZAM_Activate Batuz")
                {
                }
                field("Version No."; "ZAM_Version No.")
                {
                }
                field("ZAM_Version No. Batuz"; "ZAM_Version No. Batuz")
                {
                }
                field("Settlement Period"; "ZAM_Settlement Period")
                {
                }
                field("ES VAT Registration Type"; "ZAM_ES VAT Registration Type")
                {
                    LookupPageID = ZAMVATRegistrationType;
                }
                field("Total Type"; "ZAM_Total Type")
                {
                }
                field("Macrodata Amount"; "ZAM_Macrodata Amount")
                {
                }
                field(Agency; ZAM_Agency)
                {
                }
                group(Comunication)
                {
                    Caption = 'Communication';
                    field("Set Up Communication"; "ZAM_Set Up Communication")
                    {
                        LookupPageID = ZAMCommunicationTypes;
                    }
                    field("Modification Communication"; "ZAM_Modification Communication")
                    {
                        LookupPageID = ZAMCommunicationTypes;
                    }
                }
            }
            group("Sales Documents Book")
            {
                Caption = 'Sales Documents Book';
                field("Sales Invoice"; "ZAM_Sales Invoice")
                {
                    LookupPageID = ZAMSalesDocumentType;
                }
                field("Sales Cr.Memo"; "ZAM_Sales Cr.Memo")
                {
                    LookupPageID = ZAMSalesDocumentType;
                }
                field("Sales Documents URL"; "ZAM_Sales Documents URL")
                {
                }
                field("Sales Real Estate URL"; "ZAM_Sales Real Estate URL")
                {
                }
                field(ZAM_IdentifierURL; ZAM_IdentifierURL)
                {
                }
                field(ZAM_SimpledInvoice; ZAM_SimpledInvoice)
                {
                }
                field(ZAM_SimpledCRMemo; ZAM_SimpledCRMemo)
                {
                }
                field(ZAM_SimpInvSerialNo; ZAM_SimpInvSerialNo)
                {
                }
                field(ZAM_SimpCRSerialNo; ZAM_SimpCRSerialNo)
                {
                }
                field("ZAM DUA Document"; "ZAM DUA Document")
                {
                }
            }
            group(Certificate)
            {
                Caption = 'Certificate';
                field(Enabled; ZAM_Enabled)
                {
                }
                field("Certificate Installed"; ZAM_Certificate.HASVALUE())
                {
                    Caption = 'Certificate Installed';
                    Editable = false;
                }
                field(Password; ZAM_Password)
                {
                }
            }
            group(NamespacePrefix)
            {
                Caption = 'Namespaces and Prefixes';
                field("General Namespace"; "ZAM_General Namespace")
                {
                }
                field(ZAM_SoftwareVersion; ZAM_SoftwareVersion)
                {
                }
            }
            group(QR)
            {
                Caption = 'QR';
                field(ZAM_QR_URL; ZAM_QR_URL)
                {
                }
                field(ZAM_QRHeight; ZAM_QRHeight)
                {
                }
                field(ZAM_QRWeight; ZAM_QRWeight)
                {
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
                Caption = 'Importar Certificado Izenpe';

                trigger OnAction()
                begin
                    Rec.ImportCertificateIZENPE();
                end;
            }
            action(BORRARCERT)
            {

                trigger OnAction()
                begin
                    CLEAR(Rec.ZAM_Cert_Izenpe);
                    CLEAR(ZAM_Certificate);

                    MODIFY;
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

