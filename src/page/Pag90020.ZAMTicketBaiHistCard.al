page 90020 ZAMTicketBaiHistCard
{
    Editable = false;
    PageType = Card;
    UsageCategory = Administration;
    SourceTable = 90001;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'Gneral';
                field(ZAM_Type; Rec.ZAM_Type)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("ZAM_Document No."; Rec."ZAM_Document No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Importance = Promoted;
                }
                field("ZAM_External Document No."; Rec."ZAM_External Document No.")
                {
                    ApplicationArea = All;
                }
                field(ZAM_Status; Rec.ZAM_Status)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Importance = Promoted;
                }
                field("ZAM_Posting Date"; Rec."ZAM_Posting Date")
                {
                    ApplicationArea = All;
                }
                field("ZAM_Accounting Posting Date"; Rec."ZAM_Accounting Posting Date")
                {
                    ApplicationArea = All;
                    Editable = PurchaseFieldVisible;
                    Visible = PurchaseFieldVisible;
                }
                field("ZAM_Transaction Date"; Rec."ZAM_Transaction Date")
                {
                    ApplicationArea = All;
                }
                field("ZAM_Version No."; Rec."ZAM_Version No.")
                {
                    ApplicationArea = All;
                }
                field("ZAM_Company Name"; Rec."ZAM_Company Name")
                {
                    ApplicationArea = All;
                }
                field("ZAM_Company VAT Reg No."; Rec."ZAM_Company VAT Reg No.")
                {
                    ApplicationArea = All;
                }
                field("ZAM_Communication Type"; Rec."ZAM_Communication Type")
                {
                    ApplicationArea = All;
                }
                field("ZAM_Tax Year"; Rec."ZAM_Tax Year")
                {
                    ApplicationArea = All;
                }
                field("ZAM_Settlement Period"; Rec."ZAM_Settlement Period")
                {
                    ApplicationArea = All;
                    LookupPageID = ZAMSettlementPeriods;
                }
                field("ZAM_Company VAT Reg No. 2"; Rec."ZAM_Company VAT Reg No. 2")
                {
                    ApplicationArea = All;
                }
                field("ZAM_Issuing Document No."; Rec."ZAM_Issuing Document No.")
                {
                    ApplicationArea = All;
                }
                field("ZAM_Expedition Date"; Rec."ZAM_Expedition Date")
                {
                    ApplicationArea = All;
                }
                field("ZAM_Expedition Time"; Rec."ZAM_Expedition Time")
                {
                    ApplicationArea = All;
                }
                field("ZAM_Document Type"; Rec."ZAM_Document Type")
                {
                    ApplicationArea = All;
                }
                field("ZAM_Special Regime Key 1"; Rec."ZAM_Special Regime Key 1")
                {
                    ApplicationArea = All;
                }
                field("ZAM_Special Regime Key 2"; Rec."ZAM_Special Regime Key 2")
                {
                    ApplicationArea = All;
                }
                field("ZAM_Special Regime Key 3"; Rec."ZAM_Special Regime Key 3")
                {
                    ApplicationArea = All;
                }
                field("ZAM_Total Amount"; Rec."ZAM_Total Amount")
                {
                    ApplicationArea = All;
                }
                field("ZAM_Transaction Description"; Rec."ZAM_Transaction Description")
                {
                    ApplicationArea = All;
                }
                field("ZAM_Cust/Vend Name"; Rec."ZAM_Cust/Vend Name")
                {
                    ApplicationArea = All;
                }
                field("ZAM_Cust/Vend VAT Reg No."; Rec."ZAM_Cust/Vend VAT Reg No.")
                {
                    ApplicationArea = All;
                }
                field("ZAM_Cust/Vend Country/Reg Code"; Rec."ZAM_Cust/Vend Country/Reg Code")
                {
                    ApplicationArea = All;
                }
                field("ZAM_Credit Memo Type"; Rec."ZAM_Credit Memo Type")
                {
                    ApplicationArea = All;
                    LookupPageID = ZAMTicketBaiCreditMemoTypes;
                }
                field("ZAM_Corrected Invoice No."; Rec."ZAM_Corrected Invoice No.")
                {
                    ApplicationArea = All;
                }
                field("ZAM_Corrected Invo Post Date"; Rec."ZAM_Corrected Invo Post Date")
                {
                    ApplicationArea = All;
                }
                field("ZAM_Shipment Comments"; Rec."ZAM_Shipment Comments")
                {
                    ApplicationArea = All;
                    RowSpan = 2;
                }
                field(ZAM_QR_ID; Rec.ZAM_QR_ID)
                {
                    ApplicationArea = All;
                }
            }
            group("Intracom. Transactions")
            {
                Caption = 'Operaciones intracomunitarias';
                field("ZAM_Intracom. Trans. Type"; Rec."ZAM_Intracom. Trans. Type")
                {
                    ApplicationArea = All;
                    LookupPageID = ZAMIntracomTransType;
                }
                field("ZAM_Intracom. Admitted Key"; Rec."ZAM_Intracom. Admitted Key")
                {
                    ApplicationArea = All;
                    LookupPageID = ZAMIntracomAdmittedKey;
                }
                field("ZAM_Cust/Vend Address"; Rec."ZAM_Cust/Vend Address")
                {
                    ApplicationArea = All;
                }
            }
            part(Control1000000028; 90012)
            {
                SubPageLink = ZAM_Company = FIELD (ZAM_Company),
                              ZAM_Type = FIELD (ZAM_Type),
                              ZAM_Document No.=FIELD(ZAM_Document No.);
                                  SubPageView = SORTING(ZAM_Company,ZAM_Type,ZAM_Document No.,ZAM_Line No.);
            }
            part(Control1000000023; 90016)
            {
                SubPageLink = ZAM_Company = FIELD (ZAM_Company),
                              ZAM_Type = FIELD (ZAM_Type),
                              ZAM_Document No.=FIELD(ZAM_Document No.);
                                  SubPageView = SORTING(ZAM_Company,ZAM_Type,ZAM_Document No.,ZAM_Line No.);
            }
        }
    }

    actions
    {
        area(creation)
        {
            group(Acciones)
            {
                Caption = 'Acciones';
                Image = Travel;
                action(ShowRequest)
                {
                    ApplicationArea = All;
                    Caption = 'Ver envío';
                    Image = ImportLog;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        TypeRecL: Option Request,Response,QR;
                    begin
                        Rec.ShowCommunication(TypeRecL::Request);
                        CurrPage.UPDATE(TRUE);
                    end;
                }
                action(ShowResponse)
                {
                    ApplicationArea = All;
                    Caption = 'Ver respuesta';
                    Image = ImportExport;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        TypeRecL: Option Request,Response,QR;
                    begin
                        Rec.ShowCommunication(TypeRecL::Response);
                        CurrPage.UPDATE(TRUE);
                    end;
                }
                action(ShowResponseQR)
                {
                    ApplicationArea = All;
                    Caption = 'Mostrar respuesta QR';
                    Image = ImportExport;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        TypeRecL: Option Request,Response,QR;
                    begin
                        Rec.ShowCommunication(TypeRecL::QR);
                        CurrPage.UPDATE(TRUE);
                    end;
                }
                action(ChangeStatus)
                {
                    ApplicationArea = All;
                    Caption = 'Cambiar estado';
                    Image = Start;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        IF Rec.ChangeStatus() THEN
                            CurrPage.CLOSE();
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        VisibleEditableFields();
    end;

    trigger OnOpenPage()
    begin
        Rec.FILTERGROUP(100);
        Rec.SETRANGE(ZAM_Company, COMPANYNAME());
        Rec.SETFILTER(ZAM_Status, '%1|%2', Rec.ZAM_Status::Confirmed, Rec.ZAM_Status::Cancelled);
        Rec.FILTERGROUP(0);
        VisibleEditableFields();
    end;

    var
        CreditMemoTypeVisibleEnable: Boolean;
        PurchaseFieldVisible: Boolean;
        StatusColor: Text;

    local procedure VisibleEditableFields()
    begin
        CreditMemoTypeVisibleEnable := (Rec.ZAM_Type = Rec.ZAM_Type::SalesCrMemo);
        PurchaseFieldVisible := (Rec.ZAM_Type IN [Rec.ZAM_Type::PurchaseCrMemo, Rec.ZAM_Type::PurchaseInvoice]);
    end;
}

