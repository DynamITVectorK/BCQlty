page 90026 ZAMTicketBayCue2
{
    // Z0041GEN PBS 17/12/21: TicketBai.

    Caption = 'Information Immediate Supply Cue';
    PageType = ListPart;
    SourceTable = Table90000;

    layout
    {
        area(content)
        {
            cuegroup(Group)
            {
                Caption = 'Documents';
                field("On Hold Documents"; "ZAM_On Hold Documents")
                {
                }
                field("Ready Documents"; "ZAM_Ready Documents")
                {
                }
                field("Sent Documents"; "ZAM_Sent Documents")
                {
                }
                field("To Correct Documents"; "ZAM_To Correct Documents")
                {
                }
                field("Error Documents"; "ZAM_Error Documents")
                {
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
                Caption = 'Set Up Cues';
                Image = Setup;
                ToolTip = 'Set up the cues (status tiles) related to the role.';

                trigger OnAction()
                var
                    CueSetup: Codeunit "9701";
                    CueRecordRef: RecordRef;
                begin
                    CueRecordRef.GETTABLE(Rec);
                    CueSetup.OpenCustomizePageForCurrentUser(CueRecordRef.NUMBER());
                end;
            }
        }
    }
}

