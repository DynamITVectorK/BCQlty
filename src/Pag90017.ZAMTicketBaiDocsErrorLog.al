page 90017 ZAMTicketBaiDocsErrorLog
{
    PageType = List;
    SourceTable = Table90006;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("ZAM_Shipment Date"; "ZAM_Shipment Date")
                {
                }
                field("ZAM_Shipment Time"; "ZAM_Shipment Time")
                {
                }
                field(ZAM_Description; ZAM_Description)
                {
                }
                field("ZAM_Error No."; "ZAM_Error No.")
                {
                }
                field("ZAM_Error Type"; "ZAM_Error Type")
                {
                }
            }
        }
    }

    actions
    {
    }
}

