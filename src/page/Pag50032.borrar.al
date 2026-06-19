page 50032 borrar
{
    PageType = List;
    UsageCategory = Administration;
    Permissions = TableData 7000002 = rimd;
    SourceTable = 7000002;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Remaining Amount"; Rec."Remaining Amount")
                {
                    ApplicationArea = All;
                }
                field("Remaining Amt. (LCY)"; Rec."Remaining Amt. (LCY)")
                {
                    ApplicationArea = All;
                }
                field("Due Date"; Rec."Due Date")
                {
                    ApplicationArea = All;
                }
                field("Payment Method Code"; Rec."Payment Method Code")
                {
                    ApplicationArea = All;
                }
                field(Accepted; Rec.Accepted)
                {
                    ApplicationArea = All;
                }
                field(Place; Rec.Place)
                {
                    ApplicationArea = All;
                }
                field("Collection Agent"; Rec."Collection Agent")
                {
                    ApplicationArea = All;
                }
                field("Bill Gr./Pmt. Order No."; Rec."Bill Gr./Pmt. Order No.")
                {
                    ApplicationArea = All;
                }
                field("Category Code"; Rec."Category Code")
                {
                    ApplicationArea = All;
                }
                field("Account No."; Rec."Account No.")
                {
                    ApplicationArea = All;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = All;
                }
                field("Cust./Vendor Bank Acc. Code"; Rec."Cust./Vendor Bank Acc. Code")
                {
                    ApplicationArea = All;
                }
                field("Pmt. Address Code"; Rec."Pmt. Address Code")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
                field("Original Amount"; Rec."Original Amount")
                {
                    ApplicationArea = All;
                }
                field("Original Amount (LCY)"; Rec."Original Amount (LCY)")
                {
                    ApplicationArea = All;
                }
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = All;
                }
                field("On Hold"; Rec."On Hold")
                {
                    ApplicationArea = All;
                }
                field(Adjusted; Rec.Adjusted)
                {
                    ApplicationArea = All;
                }
                field("Adjusted Amount"; Rec."Adjusted Amount")
                {
                    ApplicationArea = All;
                }
                field("From Journal"; Rec."From Journal")
                {
                    ApplicationArea = All;
                }
                field("Elect. Pmts Exported"; Rec."Elect. Pmts Exported")
                {
                    ApplicationArea = All;
                }
                field("Export File Name"; Rec."Export File Name")
                {
                    ApplicationArea = All;
                }
                field("Transfer Type"; Rec."Transfer Type")
                {
                    ApplicationArea = All;
                }
                field("Dimension Set ID"; Rec."Dimension Set ID")
                {
                    ApplicationArea = All;
                }
                field("Direct Debit Mandate ID"; Rec."Direct Debit Mandate ID")
                {
                    ApplicationArea = All;
                }
                field("Original Document No."; Rec."Original Document No.")
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

