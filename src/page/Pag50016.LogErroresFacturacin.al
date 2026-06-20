page 50016 "Log Errores Facturación"
{
    // //***Z009 - 400 - RG- 24/11/2016 - Facturación automática

    Caption = 'Log Errores Facturación';
    Editable = false;
    InsertAllowed = false;
    PageType = List;
    UsageCategory = Administration;
    SourceTable = 50005;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Num; Rec.Num)
                {
                    ApplicationArea = All;
                }
                field(Fecha; Rec.Fecha)
                {
                    ApplicationArea = All;
                }
                field("Registro Asociado"; Rec."Registro Asociado")
                {
                    ApplicationArea = All;
                }
                field(Motivo; Rec.Motivo)
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