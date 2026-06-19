page 90019 ZAMTicketBaiHistDocs
{
    CardPageID = ZAMTicketBaiHistCard;
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    PromotedActionCategories = 'Nuevo,Procesar,Informar,Comunicación';
    SourceTable = Table90001;
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
                    StyleExpr = statuscolor;
                }
                field(ZAM_Book; ZAM_Book)
                {
                }
                field(ZAM_Type; ZAM_Type)
                {
                }
                field("ZAM_Document No."; "ZAM_Document No.")
                {
                }
                field("ZAM_External Document No."; "ZAM_External Document No.")
                {
                }
                field("ZAM_Posting Date"; "ZAM_Posting Date")
                {
                }
                field("ZAM_Accounting Posting Date"; "ZAM_Accounting Posting Date")
                {
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
                field(ZAM_ThirdParty; ZAM_ThirdParty)
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

