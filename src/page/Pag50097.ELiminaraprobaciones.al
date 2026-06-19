page 50097 "ELiminar aprobaciones"
{
    PageType = List;
    UsageCategory = Administration;
    Permissions = TableData 454 = rimd;
    SourceTable = "Approval Entry";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Table ID"; "Table ID")
                {
                    ApplicationArea = All;
                }
                field("Document Type"; "Document Type")
                {
                    ApplicationArea = All;
                }
                field("Document No."; "Document No.")
                {
                    ApplicationArea = All;
                }
                field("Sequence No."; "Sequence No.")
                {
                    ApplicationArea = All;
                }
                field("Approval Code"; "Approval Code")
                {
                    ApplicationArea = All;
                }
                field("Sender ID"; "Sender ID")
                {
                    ApplicationArea = All;
                }
                field("Salespers./Purch. Code"; "Salespers./Purch. Code")
                {
                    ApplicationArea = All;
                }
                field("Approver ID"; "Approver ID")
                {
                    ApplicationArea = All;
                }
                field(Status; Status)
                {
                    ApplicationArea = All;
                }
                field("Date-Time Sent for Approval"; "Date-Time Sent for Approval")
                {
                    ApplicationArea = All;
                }
                field("Last Date-Time Modified"; "Last Date-Time Modified")
                {
                    ApplicationArea = All;
                }
                field("Last Modified By User ID"; "Last Modified By User ID")
                {
                    ApplicationArea = All;
                }
                field(Comment; Comment)
                {
                    ApplicationArea = All;
                }
                field("Due Date"; "Due Date")
                {
                    ApplicationArea = All;
                }
                field(Amount; Amount)
                {
                    ApplicationArea = All;
                }
                field("Amount (LCY)"; "Amount (LCY)")
                {
                }
                field("Currency Code"; "Currency Code")
                {
                    ApplicationArea = All;
                }
                field("Approval Type"; "Approval Type")
                {
                    ApplicationArea = All;
                }
                field("Limit Type"; "Limit Type")
                {
                    ApplicationArea = All;
                }
                field("Available Credit Limit (LCY)"; "Available Credit Limit (LCY)")
                {
                }
                field("Pending Approvals"; "Pending Approvals")
                {
                    ApplicationArea = All;
                }
                field("Record ID to Approve"; "Record ID to Approve")
                {
                    ApplicationArea = All;
                }
                field("Delegation Date Formula"; "Delegation Date Formula")
                {
                    ApplicationArea = All;
                }
                field("Number of Approved Requests"; "Number of Approved Requests")
                {
                    ApplicationArea = All;
                }
                field("Number of Rejected Requests"; "Number of Rejected Requests")
                {
                    ApplicationArea = All;
                }
                field("Entry No."; "Entry No.")
                {
                    ApplicationArea = All;
                }
                field("Workflow Step Instance ID"; "Workflow Step Instance ID")
                {
                    ApplicationArea = All;
                }
                field("Related to Change"; "Related to Change")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

