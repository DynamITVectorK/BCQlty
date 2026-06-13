page 80002 "FacturaE Import Log"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = History;
    SourceTable = "FacturaE Import Log";
    Caption = 'Log importación FacturaE';
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                }
                field("Imported At"; Rec."Imported At")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("External Id"; Rec."External Id")
                {
                    ApplicationArea = All;
                }
                field("File Name"; Rec."File Name")
                {
                    ApplicationArea = All;
                }
                field("Invoice Platform Id"; Rec."Invoice Platform Id")
                {
                    ApplicationArea = All;
                }
                field(Message; Rec.Message)
                {
                    ApplicationArea = All;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
