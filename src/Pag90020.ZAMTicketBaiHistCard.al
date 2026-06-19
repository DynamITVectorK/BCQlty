page 90020 ZAMTicketBaiHistCard
{
    Editable = false;
    PageType = Card;
    SourceTable = Table90001;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'Gneral';
                field(ZAM_Type; ZAM_Type)
                {
                    Editable = false;
                }
                field("ZAM_Document No."; "ZAM_Document No.")
                {
                    Editable = false;
                    Importance = Promoted;
                }
                field("ZAM_External Document No."; "ZAM_External Document No.")
                {
                }
                field(ZAM_Status; ZAM_Status)
                {
                    Editable = false;
                    Importance = Promoted;
                }
                field("ZAM_Posting Date"; "ZAM_Posting Date")
                {
                }
                field("ZAM_Accounting Posting Date"; "ZAM_Accounting Posting Date")
                {
                    Editable = PurchaseFieldVisible;
                    Visible = PurchaseFieldVisible;
                }
                field("ZAM_Transaction Date"; "ZAM_Transaction Date")
                {
                }
                field("ZAM_Version No."; "ZAM_Version No.")
                {
                }
                field("ZAM_Company Name"; "ZAM_Company Name")
                {
                }
                field("ZAM_Company VAT Reg No."; "ZAM_Company VAT Reg No.")
                {
                }
                field("ZAM_Communication Type"; "ZAM_Communication Type")
                {
                }
                field("ZAM_Tax Year"; "ZAM_Tax Year")
                {
                }
                field("ZAM_Settlement Period"; "ZAM_Settlement Period")
                {
                    LookupPageID = ZAMSettlementPeriods;
                }
                field("ZAM_Company VAT Reg No. 2"; "ZAM_Company VAT Reg No. 2")
                {
                }
                field("ZAM_Issuing Document No."; "ZAM_Issuing Document No.")
                {
                }
                field("ZAM_Expedition Date"; "ZAM_Expedition Date")
                {
                }
                field("ZAM_Expedition Time"; "ZAM_Expedition Time")
                {
                }
                field("ZAM_Document Type"; "ZAM_Document Type")
                {
                }
                field("ZAM_Special Regime Key 1"; "ZAM_Special Regime Key 1")
                {
                }
                field("ZAM_Special Regime Key 2"; "ZAM_Special Regime Key 2")
                {
                }
                field("ZAM_Special Regime Key 3"; "ZAM_Special Regime Key 3")
                {
                }
                field("ZAM_Total Amount"; "ZAM_Total Amount")
                {
                }
                field("ZAM_Transaction Description"; "ZAM_Transaction Description")
                {
                }
                field("ZAM_Cust/Vend Name"; "ZAM_Cust/Vend Name")
                {
                }
                field("ZAM_Cust/Vend VAT Reg No."; "ZAM_Cust/Vend VAT Reg No.")
                {
                }
                field("ZAM_Cust/Vend Country/Reg Code"; "ZAM_Cust/Vend Country/Reg Code")
                {
                }
                field("ZAM_Credit Memo Type"; "ZAM_Credit Memo Type")
                {
                    LookupPageID = ZAMTicketBaiCreditMemoTypes;
                }
                field("ZAM_Corrected Invoice No."; "ZAM_Corrected Invoice No.")
                {
                }
                field("ZAM_Corrected Invo Post Date"; "ZAM_Corrected Invo Post Date")
                {
                }
                field("ZAM_Shipment Comments"; "ZAM_Shipment Comments")
                {
                    RowSpan = 2;
                }
                field(ZAM_QR_ID; ZAM_QR_ID)
                {
                }
            }
            group("Intracom. Transactions")
            {
                Caption = 'Operaciones intracomunitarias';
                field("ZAM_Intracom. Trans. Type"; "ZAM_Intracom. Trans. Type")
                {
                    LookupPageID = ZAMIntracomTransType;
                }
                field("ZAM_Intracom. Admitted Key"; "ZAM_Intracom. Admitted Key")
                {
                    LookupPageID = ZAMIntracomAdmittedKey;
                }
                field("ZAM_Cust/Vend Address"; "ZAM_Cust/Vend Address")
                {
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

