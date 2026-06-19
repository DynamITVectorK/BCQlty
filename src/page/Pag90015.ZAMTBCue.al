page 90015 ZAMTBCue
{
    // Z0041GEN PBS 17/12/21: TicketBai.

    Caption = 'Ticket Bai Cue';
    PageType = List;
    UsageCategory = Administration;
    SourceTable = 90000;

    layout
    {
        area(content)
        {
            cuegroup(Group)
            {
                Caption = 'Documents';
                field("On Hold Documents"; "ZAM_On Hold Documents")
                {
                    ApplicationArea = All;
                }
                field("Ready Documents"; "ZAM_Ready Documents")
                {
                    ApplicationArea = All;
                }
                field("Sent Documents"; "ZAM_Sent Documents")
                {
                    ApplicationArea = All;
                }
                field("To Correct Documents"; "ZAM_To Correct Documents")
                {
                    ApplicationArea = All;
                }
                field("Error Documents"; "ZAM_Error Documents")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Set Up Cues")
            {
                ApplicationArea = All;
                Caption = 'Set Up Cues';
                Image = Setup;
                ToolTip = 'Set up the cues (status tiles) related to the role.';

                trigger OnAction()
                var
                    CueSetup: Codeunit "Cues And KPIs";
                    CueRecordRef: RecordRef;
                begin
                    CueRecordRef.GETTABLE(Rec);
                    CueSetup.OpenCustomizePageForCurrentUser(CueRecordRef.NUMBER());
                end;
            }
        }
    }
}

