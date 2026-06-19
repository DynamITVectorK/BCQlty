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
                field("ZAM_Shipment Date"; "ZAM_Shipment Date")
                {
                    ApplicationArea = All;
                }
                field("ZAM_Shipment Time"; "ZAM_Shipment Time")
                {
                    ApplicationArea = All;
                }
                field(ZAM_Description; ZAM_Description)
                {
                    ApplicationArea = All;
                }
                field("ZAM_Error No."; "ZAM_Error No.")
                {
                    ApplicationArea = All;
                }
                field("ZAM_Error Type"; "ZAM_Error Type")
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

