page 50029 "Dpto. Solicitante"
{
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
                field("Cod. Dpto"; "Cod. Dpto")
                {
                    ApplicationArea = All;
                }
                field(Descripción; Descripción)
                {
                    ApplicationArea = All;
                }
                field("Aprobador 1"; "Aprobador 1")
                {
                    ApplicationArea = All;
                }
                field("Aprobador 2"; "Aprobador 2")
                {
                    ApplicationArea = All;
                }
                field("Aprobador 3"; "Aprobador 3")
                {
                    ApplicationArea = All;
                }
                field("Aprobador 4"; "Aprobador 4")
                {
                    ApplicationArea = All;
                }
                field("Aprobador 5"; "Aprobador 5")
                {
                    ApplicationArea = All;
                }
                field("Tipo Aprobador"; "Tipo Aprobador")
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

