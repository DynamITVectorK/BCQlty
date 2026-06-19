page 50015 Periodicidad
{
    // //***Z009 - 400 - RG- 24/11/2016 - Facturación automática

    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    UsageCategory = Administration;
    SourceTable = "Excel Buffer";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(xlRowID; Rec.xlRowID)
                {
                    ApplicationArea = All;
                    Caption = 'xlRowID';
                }
            }
        }
    }

    actions
    {
    }
}

