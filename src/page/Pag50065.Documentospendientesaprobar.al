page 50065 "Documentos pendientes aprobar"
{
    Editable = false;
    PageType = List;
    SourceTable = Table454;
    SourceTableView = SORTING (Approver ID, Status)
                      ORDER(Ascending)
                      WHERE (Status = FILTER (Open));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document Type"; "Document Type")
                {
                }
                field("Document No."; "Document No.")
                {
                }
                field("Sender ID"; "Sender ID")
                {
                }
                field("Approver ID"; "Approver ID")
                {
                }
                field(Status; Status)
                {
                }
                field("Date-Time Sent for Approval"; "Date-Time Sent for Approval")
                {
                }
                field("Approval Code"; "Approval Code")
                {
                }
                field("Due Date"; "Due Date")
                {
                }
                field(Amount; Amount)
                {
                }
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
                        ApprovalCommentLine.SETRANGE("Table ID", "Table ID");
                        ApprovalCommentLine.SETRANGE("Record ID to Approve", "Record ID to Approve");
                        PAGE.RUN(PAGE::"Approval Comments", ApprovalCommentLine);
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
                Visible = false;

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
                Visible = false;

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
                Visible = false;

                trigger OnAction()
                var
                    ApprovalEntry: Record "454";
                    ApprovalsMgmt: Codeunit "1535";
                begin
                    CurrPage.SETSELECTIONFILTER(ApprovalEntry);
                    ApprovalsMgmt.DelegateApprovalRequests(ApprovalEntry);
                end;
            }
        }
    }
}

