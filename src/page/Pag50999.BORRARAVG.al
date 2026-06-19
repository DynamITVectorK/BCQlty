page 50999 "BORRAR_AVG"
{
    PageType = List;
    UsageCategory = Administration;
    Permissions = TableData 21 = rimd;
    SourceTable = "Cust. Ledger Entry";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No."; "Entry No.")
                {
                    ApplicationArea = All;
                }
                field("Customer No."; "Customer No.")
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; "Posting Date")
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
                field(Description; Description)
                {
                    ApplicationArea = All;
                }
                field("Currency Code"; "Currency Code")
                {
                    ApplicationArea = All;
                }
                field(Amount; Amount)
                {
                    ApplicationArea = All;
                }
                field("Remaining Amount"; "Remaining Amount")
                {
                    ApplicationArea = All;
                }
                field("Original Amt. (LCY)"; "Original Amt. (LCY)")
                {
                }
                field("Remaining Amt. (LCY)"; "Remaining Amt. (LCY)")
                {
                }
                field("Amount (LCY)"; "Amount (LCY)")
                {
                }
                field("Sales (LCY)"; "Sales (LCY)")
                {
                }
                field("Profit (LCY)"; "Profit (LCY)")
                {
                }
                field("Inv. Discount (LCY)"; "Inv. Discount (LCY)")
                {
                }
                field("Sell-to Customer No."; "Sell-to Customer No.")
                {
                    ApplicationArea = All;
                }
                field("Customer Posting Group"; "Customer Posting Group")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; "Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 2 Code"; "Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
                field("Salesperson Code"; "Salesperson Code")
                {
                    ApplicationArea = All;
                }
                field("User ID"; "User ID")
                {
                    ApplicationArea = All;
                }
                field("Source Code"; "Source Code")
                {
                    ApplicationArea = All;
                }
                field("On Hold"; "On Hold")
                {
                    ApplicationArea = All;
                }
                field("Applies-to Doc. Type"; "Applies-to Doc. Type")
                {
                    ApplicationArea = All;
                }
                field("Applies-to Doc. No."; "Applies-to Doc. No.")
                {
                    ApplicationArea = All;
                }
                field(Open; Open)
                {
                    ApplicationArea = All;
                }
                field("Due Date"; "Due Date")
                {
                    ApplicationArea = All;
                }
                field("Pmt. Discount Date"; "Pmt. Discount Date")
                {
                    ApplicationArea = All;
                }
                field("Original Pmt. Disc. Possible"; "Original Pmt. Disc. Possible")
                {
                    ApplicationArea = All;
                }
                field("Pmt. Disc. Given (LCY)"; "Pmt. Disc. Given (LCY)")
                {
                }
                field(Positive; Positive)
                {
                    ApplicationArea = All;
                }
                field("Closed by Entry No."; "Closed by Entry No.")
                {
                    ApplicationArea = All;
                }
                field("Closed at Date"; "Closed at Date")
                {
                    ApplicationArea = All;
                }
                field("Closed by Amount"; "Closed by Amount")
                {
                    ApplicationArea = All;
                }
                field("Applies-to ID"; "Applies-to ID")
                {
                    ApplicationArea = All;
                }
                field("Journal Batch Name"; "Journal Batch Name")
                {
                    ApplicationArea = All;
                }
                field("Reason Code"; "Reason Code")
                {
                    ApplicationArea = All;
                }
                field("Bal. Account Type"; "Bal. Account Type")
                {
                    ApplicationArea = All;
                }
                field("Bal. Account No."; "Bal. Account No.")
                {
                    ApplicationArea = All;
                }
                field("Transaction No."; "Transaction No.")
                {
                    ApplicationArea = All;
                }
                field("Closed by Amount (LCY)"; "Closed by Amount (LCY)")
                {
                }
                field("Debit Amount"; "Debit Amount")
                {
                    ApplicationArea = All;
                }
                field("Credit Amount"; "Credit Amount")
                {
                    ApplicationArea = All;
                }
                field("Debit Amount (LCY)"; "Debit Amount (LCY)")
                {
                }
                field("Credit Amount (LCY)"; "Credit Amount (LCY)")
                {
                }
                field("Document Date"; "Document Date")
                {
                    ApplicationArea = All;
                }
                field("External Document No."; "External Document No.")
                {
                    ApplicationArea = All;
                }
                field("Calculate Interest"; "Calculate Interest")
                {
                    ApplicationArea = All;
                }
                field("Closing Interest Calculated"; "Closing Interest Calculated")
                {
                    ApplicationArea = All;
                }
                field("No. Series"; "No. Series")
                {
                    ApplicationArea = All;
                }
                field("Closed by Currency Code"; "Closed by Currency Code")
                {
                    ApplicationArea = All;
                }
                field("Closed by Currency Amount"; "Closed by Currency Amount")
                {
                    ApplicationArea = All;
                }
                field("Adjusted Currency Factor"; "Adjusted Currency Factor")
                {
                    ApplicationArea = All;
                }
                field("Original Currency Factor"; "Original Currency Factor")
                {
                    ApplicationArea = All;
                }
                field("Original Amount"; "Original Amount")
                {
                    ApplicationArea = All;
                }
                field("Date Filter"; "Date Filter")
                {
                    ApplicationArea = All;
                }
                field("Remaining Pmt. Disc. Possible"; "Remaining Pmt. Disc. Possible")
                {
                    ApplicationArea = All;
                }
                field("Pmt. Disc. Tolerance Date"; "Pmt. Disc. Tolerance Date")
                {
                    ApplicationArea = All;
                }
                field("Max. Payment Tolerance"; "Max. Payment Tolerance")
                {
                    ApplicationArea = All;
                }
                field("Last Issued Reminder Level"; "Last Issued Reminder Level")
                {
                    ApplicationArea = All;
                }
                field("Accepted Payment Tolerance"; "Accepted Payment Tolerance")
                {
                    ApplicationArea = All;
                }
                field("Accepted Pmt. Disc. Tolerance"; "Accepted Pmt. Disc. Tolerance")
                {
                    ApplicationArea = All;
                }
                field("Pmt. Tolerance (LCY)"; "Pmt. Tolerance (LCY)")
                {
                }
                field("Amount to Apply"; "Amount to Apply")
                {
                    ApplicationArea = All;
                }
                field("IC Partner Code"; "IC Partner Code")
                {
                    ApplicationArea = All;
                }
                field("Applying Entry"; "Applying Entry")
                {
                    ApplicationArea = All;
                }
                field(Reversed; Reversed)
                {
                    ApplicationArea = All;
                }
                field("Reversed by Entry No."; "Reversed by Entry No.")
                {
                    ApplicationArea = All;
                }
                field("Reversed Entry No."; "Reversed Entry No.")
                {
                    ApplicationArea = All;
                }
                field(Prepayment; Prepayment)
                {
                    ApplicationArea = All;
                }
                field("Payment Terms Code"; "Payment Terms Code")
                {
                    ApplicationArea = All;
                }
                field("Payment Method Code"; "Payment Method Code")
                {
                    ApplicationArea = All;
                }
                field("Applies-to Ext. Doc. No."; "Applies-to Ext. Doc. No.")
                {
                    ApplicationArea = All;
                }
                field("Recipient Bank Account"; "Recipient Bank Account")
                {
                    ApplicationArea = All;
                }
                field("Message to Recipient"; "Message to Recipient")
                {
                    ApplicationArea = All;
                }
                field("Exported to Payment File"; "Exported to Payment File")
                {
                    ApplicationArea = All;
                }
                field("Dimension Set ID"; "Dimension Set ID")
                {
                    ApplicationArea = All;
                }
                field("Direct Debit Mandate ID"; "Direct Debit Mandate ID")
                {
                    ApplicationArea = All;
                }
                field("External Document Nr"; "External Document Nr")
                {
                    ApplicationArea = All;
                }
                field(ClienteBloqueado; ClienteBloqueado)
                {
                    ApplicationArea = All;
                }
                field(ContraseñaWeb; ContraseñaWeb)
                {
                    ApplicationArea = All;
                }
                field("Bill No."; "Bill No.")
                {
                    ApplicationArea = All;
                }
                field("Document Situation"; "Document Situation")
                {
                    ApplicationArea = All;
                }
                field("Applies-to Bill No."; "Applies-to Bill No.")
                {
                    ApplicationArea = All;
                }
                field("Document Status"; "Document Status")
                {
                    ApplicationArea = All;
                }
                field("Remaining Amount (LCY) stats."; "Remaining Amount (LCY) stats.")
                {
                }
                field("Amount (LCY) stats."; "Amount (LCY) stats.")
                {
                }
            }
        }
    }

    actions
    {
    }
}

