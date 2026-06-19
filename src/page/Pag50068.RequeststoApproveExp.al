page 50068 "Requests to Approve Exp"
{
    Caption = 'Requests to Approve';
    Editable = false;
    PageType = List;
    UsageCategory = Administration;
    Permissions = TableData 454 = rimd;
    RefreshOnActivate = true;
    SourceTable = "Approval Entry";
    SourceTableView = SORTING (Due Date)
                      ORDER(Ascending)
                      WHERE (Document Type=FILTER(Expediente));

    layout
    {
        area(content)
        {
            repeater()
            {
                field("Document No.";"Document No.")
                {
                    ApplicationArea = All;
                }
                field("Sender ID";"Sender ID")
                {
                    ApplicationArea = All;
                }
                field("Date-Time Sent for Approval";"Date-Time Sent for Approval")
                {
                    ApplicationArea = All;
                }
                field(Amount;Amount)
                {
                    ApplicationArea = All;
                }
                field(Status;Status)
                {
                    ApplicationArea = All;
                }
                field("Last Date-Time Modified";"Last Date-Time Modified")
                {
                    ApplicationArea = All;
                }
                field("Last Modified By User ID";"Last Modified By User ID")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
            part(;9104)
            {
                SubPageLink = Table ID=FIELD(Table ID),
                              Document Type=FIELD(Document Type),
                              Document No.=FIELD(Document No.);
            }
            part(Change;1527)
            {
                Editable = false;
                Enabled = false;
                ShowFilter = false;
                UpdatePropagation = SubPart;
                Visible = ShowChangeFactBox;
            }
            systempart(;Links)
            {
                Visible = false;
            }
            systempart(;Notes)
            {
                Visible = false;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Show)
            {
                Caption = 'Show';
                Image = View;
                action("Record")
                {
                    ApplicationArea = All;
                    Caption = 'Open Record';
                    Image = Document;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Scope = Repeater;

                    trigger OnAction()
                    begin
                        ShowRecord;
                    end;
                }
                action(Comments)
                {
                    ApplicationArea = All;
                    Caption = 'Comments';
                    Image = ViewComments;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Scope = Repeater;

                    trigger OnAction()
                    var
                        ApprovalCommentLine: Record "Approval Comment Line";
                    begin
                        ApprovalCommentLine.SETRANGE("Table ID","Table ID");
                        ApprovalCommentLine.SETRANGE("Record ID to Approve","Record ID to Approve");
                        PAGE.RUN(PAGE::"Approval Comments",ApprovalCommentLine);
                    end;
                }
            }
        }
        area(processing)
        {
            action(Approve)
            {
                ApplicationArea = All;
                Caption = 'Approve';
                Image = Approve;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Scope = Repeater;

                trigger OnAction()
                var
                    ApprovalEntry: Record "Approval Entry";
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin
                    CurrPage.SETSELECTIONFILTER(ApprovalEntry);
                    ApprovalsMgmt.ApproveApprovalRequests(ApprovalEntry);
                end;
            }
            action(Reject)
            {
                ApplicationArea = All;
                Caption = 'Reject';
                Image = Reject;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Scope = Repeater;

                trigger OnAction()
                var
                    ApprovalEntry: Record "Approval Entry";
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin
                    CurrPage.SETSELECTIONFILTER(ApprovalEntry);
                    ApprovalsMgmt.RejectApprovalRequests(ApprovalEntry);
                end;
            }
            action(Delegate)
            {
                ApplicationArea = All;
                Caption = 'Delegate';
                Image = Delegate;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Scope = Repeater;

                trigger OnAction()
                var
                    ApprovalEntry: Record "Approval Entry";
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin
                    CurrPage.SETSELECTIONFILTER(ApprovalEntry);
                    ApprovalsMgmt.DelegateApprovalRequests(ApprovalEntry);
                end;
            }
            group(View)
            {
                Caption = 'View';
                action(OpenRequests)
                {
                    ApplicationArea = All;
                    Caption = 'Open Requests';
                    Image = Approvals;

                    trigger OnAction()
                    begin
                        SETRANGE(Status,Status::Open);
                        ShowAllEntries := FALSE;
                    end;
                }
                action(AllRequests)
                {
                    ApplicationArea = All;
                    Caption = 'All Requests';
                    Image = AllLines;

                    trigger OnAction()
                    begin
                        SETRANGE(Status);
                        ShowAllEntries := TRUE;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        ShowChangeFactBox := CurrPage.Change.PAGE.SetFilterFromApprovalEntry(Rec);
    end;

    trigger OnAfterGetRecord()
    begin
        SetDateStyle;
    end;

    trigger OnOpenPage()
    begin
        //MESSAGE('PONER PAGE NO EDITABLE TRAS PRUEBAS');
        FILTERGROUP(2);
        SETRANGE("Approver ID",USERID);
        FILTERGROUP(0);
        SETRANGE(Status,Status::Open);
    end;

    var
        DateStyle: Text;
        ShowAllEntries: Boolean;
        ShowChangeFactBox: Boolean;

    local procedure SetDateStyle()
    begin
        DateStyle := '';
        IF IsOverdue THEN
          DateStyle := 'Attention';
    end;
}

