page 50029 "Dpto. Solicitante"
{
    DataCaptionFields = "Cod. Dpto", "Descripción";
    PageType = List;
    SourceTable = Table50013;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Cod. Dpto"; "Cod. Dpto")
                {
                }
                field(Descripción; Descripción)
                {
                }
                field("Aprobador 1"; "Aprobador 1")
                {
                }
                field("Aprobador 2"; "Aprobador 2")
                {
                }
                field("Aprobador 3"; "Aprobador 3")
                {
                }
                field("Aprobador 4"; "Aprobador 4")
                {
                }
                field("Aprobador 5"; "Aprobador 5")
                {
                }
                field("Tipo Aprobador"; "Tipo Aprobador")
                {
                }
            }
        }
    }

    actions
    {
    }
}

