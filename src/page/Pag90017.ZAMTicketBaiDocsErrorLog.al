page 90017 ZAMTicketBaiDocsErrorLog
{
    PageType = List;
    UsageCategory = Administration;
    SourceTable = 90006;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("ZAM_Shipment Date"; Rec."ZAM_Shipment Date")
                {
                    ApplicationArea = All;
                }
                field("ZAM_Shipment Time"; Rec."ZAM_Shipment Time")
                {
                    ApplicationArea = All;
                }
                field(ZAM_Description; Rec.ZAM_Description)
                {
                    ApplicationArea = All;
                }
                field("ZAM_Error No."; Rec."ZAM_Error No.")
                {
                    ApplicationArea = All;
                }
                field("ZAM_Error Type"; Rec."ZAM_Error Type")
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

