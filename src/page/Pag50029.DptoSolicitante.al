page 50029 "Dpto. Solicitante"
{
    Caption = 'Dpto. Solicitante';
    DataCaptionFields = "Cod. Dpto", "Descripción";
    PageType = List;
    UsageCategory = Administration;
    SourceTable = 50013;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Cod. Dpto"; Rec."Cod. Dpto")
                {
                    ApplicationArea = All;
                }
                field(Descripción; Rec.Descripción)
                {
                    ApplicationArea = All;
                }
                field("Aprobador 1"; Rec."Aprobador 1")
                {
                    ApplicationArea = All;
                }
                field("Aprobador 2"; Rec."Aprobador 2")
                {
                    ApplicationArea = All;
                }
                field("Aprobador 3"; Rec."Aprobador 3")
                {
                    ApplicationArea = All;
                }
                field("Aprobador 4"; Rec."Aprobador 4")
                {
                    ApplicationArea = All;
                }
                field("Aprobador 5"; Rec."Aprobador 5")
                {
                    ApplicationArea = All;
                }
                field("Tipo Aprobador"; Rec."Tipo Aprobador")
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