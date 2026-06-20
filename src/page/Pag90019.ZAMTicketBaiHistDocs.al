page 90019 ZAMTicketBaiHistDocs
{
    CardPageID = ZAMTicketBaiHistCard;
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    UsageCategory = Administration;
    SourceTable = 90001;
    SourceTableView = SORTING(ZAM_Company, ZAM_Status, "ZAM_Creation Date")
                      ORDER(Descending);

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                Editable = false;
                field(ZAM_Status; Rec.ZAM_Status)
                {
                    ApplicationArea = All;
                    StyleExpr = StatusColor;
                }
                field(ZAM_Book; Rec.ZAM_Book)
                {
                    ApplicationArea = All;
                }
                field(ZAM_Type; Rec.ZAM_Type)
                {
                    ApplicationArea = All;
                }
                field("ZAM_Document No."; Rec."ZAM_Document No.")
                {
                    ApplicationArea = All;
                }
                field("ZAM_External Document No."; Rec."ZAM_External Document No.")
                {
                    ApplicationArea = All;
                }
                field("ZAM_Posting Date"; Rec."ZAM_Posting Date")
                {
                    ApplicationArea = All;
                }
                field("ZAM_Accounting Posting Date"; Rec."ZAM_Accounting Posting Date")
                {
                    ApplicationArea = All;
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
                field(ZAM_ThirdParty; Rec.ZAM_ThirdParty)
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

                    trigger OnAction()
                    begin
                        Rec.ShowCommunication(TypeRecL::Request);
                        CurrPage.Update(true);
                    end;
                }
                action(ShowResponse)
                {
                    ApplicationArea = All;
                    Caption = 'Ver respuesta';
                    Image = ImportExport;

                    trigger OnAction()
                    begin
                        Rec.ShowCommunication(TypeRecL::Response);
                        CurrPage.Update(true);
                    end;
                }
                action(ShowResponseQR)
                {
                    ApplicationArea = All;
                    Caption = 'Mostrar respuesta QR';
                    Image = ImportExport;

                    trigger OnAction()
                    begin
                        Rec.ShowCommunication(TypeRecL::QR);
                        CurrPage.Update(true);
                    end;
                }
            }
        }
        area(Promoted)
        {
            group(Category_Communication)
            {
                Caption = 'Comunicación';

                actionref(ShowRequest_Promoted; ShowRequest)
                {
                }
                actionref(ShowResponse_Promoted; ShowResponse)
                {
                }
                actionref(ShowResponseQR_Promoted; ShowResponseQR)
                {
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
        Rec.FilterGroup(100);
        Rec.SetRange(ZAM_Company, CompanyName());
        Rec.SetFilter(ZAM_Status, '%1|%2', Rec.ZAM_Status::Confirmed, Rec.ZAM_Status::Cancelled);
        Rec.FilterGroup(0);
    end;

    var
        TypeRecL: Option Request,Response,QR;
        StatusColor: Text;
}