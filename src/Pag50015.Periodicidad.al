page 50015 Periodicidad
{
    // //***Z009 - 400 - RG- 24/11/2016 - Facturación automática

    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = Table370;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(xlRowID; xlRowID)
                {
                    Caption = 'xlRowID';
                }
            }
        }
    }

    actions
    {
    }
}

