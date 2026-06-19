page 50068 "Requests to Approve Exp"
{
    Caption = 'Requests to Approve';
    Editable = false;
    PageType = List;
    Permissions = TableData 454 = rimd;
    RefreshOnActivate = true;
    SourceTable = Table454;
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
                }
                field("Sender ID";"Sender ID")
                {
                }
                field("Date-Time Sent for Approval";"Date-Time Sent for Approval")
                {
                }
                field(Amount;Amount)
                {
                }
                field(Status;Status)
                {
                }
                field("Last Date-Time Modified";"Last Date-Time Modified")
                {
                }
                field("Last Modified By User ID";"Last Modified By User ID")
                {
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
                    Caption = 'Comments';
                    Image = ViewComments;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Scope = Repeater;

                    trigger OnAction()
                    var
                        ApprovalCommentLine: Record "455";
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
                Caption = 'Approve';
                Image = Approve;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Scope = Repeater;

                trigger OnAction()
                var
                    ApprovalEntry: Record "454";
                    ApprovalsMgmt: Codeunit "1535";
                begin
                    CurrPage.SETSELECTIONFILTER(ApprovalEntry);
                    ApprovalsMgmt.ApproveApprovalRequests(ApprovalEntry);
                end;
            }
            action(Reject)
            {
                Caption = 'Reject';
                Image = Reject;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Scope = Repeater;

                trigger OnAction()
                var
                    ApprovalEntry: Record "454";
                    ApprovalsMgmt: Codeunit "1535";
                begin
                    CurrPage.SETSELECTIONFILTER(ApprovalEntry);
                    ApprovalsMgmt.RejectApprovalRequests(ApprovalEntry);
                end;
            }
            action(Delegate)
            {
                Caption = 'Delegate';
                Image = Delegate;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Scope = Repeater;

                trigger OnAction()
                var
                    ApprovalEntry: Record "454";
                    ApprovalsMgmt: Codeunit "1535";
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

