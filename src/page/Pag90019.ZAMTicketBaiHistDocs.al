page 90019 ZAMTicketBaiHistDocs
{
    CardPageID = ZAMTicketBaiHistCard;
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    UsageCategory = Administration;
    PromotedActionCategories = 'Nuevo,Procesar,Informar,Comunicación';
    SourceTable = 90001;
    SourceTableView = SORTING (ZAM_Company, ZAM_Status, ZAM_Creation Date)
                      ORDER(Descending);

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                Editable = false;
                field(ZAM_Status; ZAM_Status)
                {
                    ApplicationArea = All;
                    StyleExpr = statuscolor;
                }
                field(ZAM_Book; ZAM_Book)
                {
                    ApplicationArea = All;
                }
                field(ZAM_Type; ZAM_Type)
                {
                    ApplicationArea = All;
                }
                field("ZAM_Document No."; "ZAM_Document No.")
                {
                    ApplicationArea = All;
                }
                field("ZAM_External Document No."; "ZAM_External Document No.")
                {
                    ApplicationArea = All;
                }
                field("ZAM_Posting Date"; "ZAM_Posting Date")
                {
                    ApplicationArea = All;
                }
                field("ZAM_Accounting Posting Date"; "ZAM_Accounting Posting Date")
                {
                    ApplicationArea = All;
                }
                field("ZAM_Transaction Date"; "ZAM_Transaction Date")
                {
                    ApplicationArea = All;
                }
                field("ZAM_Version No."; "ZAM_Version No.")
                {
                    ApplicationArea = All;
                }
                field("ZAM_Company Name"; "ZAM_Company Name")
                {
                    ApplicationArea = All;
                }
                field("ZAM_Company VAT Reg No."; "ZAM_Company VAT Reg No.")
                {
                    ApplicationArea = All;
                }
                field("ZAM_Communication Type"; "ZAM_Communication Type")
                {
                    ApplicationArea = All;
                }
                field("ZAM_Tax Year"; "ZAM_Tax Year")
                {
                    ApplicationArea = All;
                }
                field("ZAM_Settlement Period"; "ZAM_Settlement Period")
                {
                    ApplicationArea = All;
                }
                field("ZAM_Company VAT Reg No. 2"; "ZAM_Company VAT Reg No. 2")
                {
                    ApplicationArea = All;
                }
                field("ZAM_Issuing Document No."; "ZAM_Issuing Document No.")
                {
                    ApplicationArea = All;
                }
                field("ZAM_Expedition Date"; "ZAM_Expedition Date")
                {
                    ApplicationArea = All;
                }
                field("ZAM_Expedition Time"; "ZAM_Expedition Time")
                {
                    ApplicationArea = All;
                }
                field("ZAM_Document Type"; "ZAM_Document Type")
                {
                    ApplicationArea = All;
                }
                field(ZAM_ThirdParty; ZAM_ThirdParty)
                {
                    ApplicationArea = All;
                }
                field("ZAM_Special Regime Key 1"; "ZAM_Special Regime Key 1")
                {
                    ApplicationArea = All;
                }
                field("ZAM_Special Regime Key 2"; "ZAM_Special Regime Key 2")
                {
                    ApplicationArea = All;
                }
                field("ZAM_Special Regime Key 3"; "ZAM_Special Regime Key 3")
                {
                    ApplicationArea = All;
                }
                field("ZAM_Total Amount"; "ZAM_Total Amount")
                {
                    ApplicationArea = All;
                }
                field("ZAM_Transaction Description"; "ZAM_Transaction Description")
                {
                    ApplicationArea = All;
                }
                field("ZAM_Cust/Vend Name"; "ZAM_Cust/Vend Name")
                {
                    ApplicationArea = All;
                }
                field("ZAM_Cust/Vend VAT Reg No."; "ZAM_Cust/Vend VAT Reg No.")
                {
                    ApplicationArea = All;
                }
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
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        StatusColor := Rec.ReturnStatusColor();
    end;

    trigger OnOpenPage()
    begin
        Rec.FILTERGROUP(100);
        Rec.SETRANGE(ZAM_Company, COMPANYNAME());
        Rec.SETFILTER(ZAM_Status, '%1|%2', Rec.ZAM_Status::Confirmed, Rec.ZAM_Status::Cancelled);
        Rec.FILTERGROUP(0);
    end;

    var
        StatusColor: Text;
}

