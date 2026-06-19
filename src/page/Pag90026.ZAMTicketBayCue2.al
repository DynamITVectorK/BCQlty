page 90026 ZAMTicketBayCue2
{
    // Z0041GEN PBS 17/12/21: TicketBai.

    Caption = 'Information Immediate Supply Cue';
    PageType = ListPart;
    SourceTable = 90000;

    layout
    {
        area(content)
        {
            cuegroup(Group)
            {
                Caption = 'Documents';
                field("On Hold Documents"; Rec."ZAM_On Hold Documents")
                {
                    ApplicationArea = All;
                }
                field("Ready Documents"; Rec."ZAM_Ready Documents")
                {
                    ApplicationArea = All;
                }
                field("Sent Documents"; Rec."ZAM_Sent Documents")
                {
                    ApplicationArea = All;
                }
                field("To Correct Documents"; Rec."ZAM_To Correct Documents")
                {
                    ApplicationArea = All;
                }
                field("Error Documents"; Rec."ZAM_Error Documents")
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

