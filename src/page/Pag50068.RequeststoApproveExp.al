page 50068 "Requests to Approve Exp"
{
    Caption = 'Requests to Approve';
    Editable = false;
    PageType = List;
    UsageCategory = Administration;
    Permissions = TableData 454 = rimd;
    RefreshOnActivate = true;
    SourceTable = "Approval Entry";
    SourceTableView = SORTING("Due Date")
                      ORDER(Ascending)
                      WHERE("Document Type" = FILTER(Expediente));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                }
                field("Sender ID"; Rec."Sender ID")
                {
                    ApplicationArea = All;
                }
                field("Date-Time Sent for Approval"; Rec."Date-Time Sent for Approval")
                {
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Last Date-Time Modified"; Rec."Last Date-Time Modified")
                {
                    ApplicationArea = All;
                }
                field("Last Modified By User ID"; Rec."Last Modified By User ID")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
            part(ApprovalFactBox; 9104)
            {
                ApplicationArea = All;
                SubPageLink = "Table ID" = FIELD("Table ID"),
                              "Document Type" = FIELD("Document Type"),
                              "Document No." = FIELD("Document No.");
            }
            part(Change; 1527)
            {
                ApplicationArea = All;
                Editable = false;
                Enabled = false;
                ShowFilter = false;
                UpdatePropagation = SubPart;
                Visible = ShowChangeFactBox;
            }
            systempart(Links; Links)
            {
                ApplicationArea = All;
                Visible = false;
            }
            systempart(Notes; Notes)
            {
                ApplicationArea = All;
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
                        ShowRecord();
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
                        ApprovalCommentLine.SetRange("Table ID", Rec."Table ID");
                        ApprovalCommentLine.SetRange("Record ID to Approve", Rec."Record ID to Approve");
                        Page.Run(Page::"Approval Comments", ApprovalCommentLine);
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
                    CurrPage.SetSelectionFilter(ApprovalEntry);
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
                    CurrPage.SetSelectionFilter(ApprovalEntry);
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
                    CurrPage.SetSelectionFilter(ApprovalEntry);
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
                        Rec.SetRange(Status, Rec.Status::Open);
                        ShowAllEntries := false;
                    end;
                }
                action(AllRequests)
                {
                    ApplicationArea = All;
                    Caption = 'All Requests';
                    Image = AllLines;

                    trigger OnAction()
                    begin
                        Rec.SetRange(Status);
                        ShowAllEntries := true;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        ShowChangeFactBox := CurrPage.Change.Page.SetFilterFromApprovalEntry(Rec);
    end;

    trigger OnAfterGetRecord()
    begin
        SetDateStyle();
    end;

    trigger OnOpenPage()
    begin
        Rec.FilterGroup(2);
        Rec.SetRange("Approver ID", UserId());
        Rec.FilterGroup(0);
        Rec.SetRange(Status, Rec.Status::Open);
    end;

    var
        DateStyle: Text;
        ShowAllEntries: Boolean;
        ShowChangeFactBox: Boolean;

    local procedure SetDateStyle()
    begin
        DateStyle := '';
        if IsOverdue() then
            DateStyle := 'Attention';
    end;
}