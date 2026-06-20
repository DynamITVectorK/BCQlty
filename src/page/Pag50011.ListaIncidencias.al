page 50011 "Lista Incidencias"
{
    // //***Z006 - 400 - RG- 07/11/2016 - Gestión de incidencias

    Caption = 'Lista Incidencias';
    CardPageID = "Ficha de Incidencias";
    Editable = false;
    PageType = List;
    UsageCategory = Administration;
    SourceTable = 50004;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No. incidencia"; Rec."No. incidencia")
                {
                    ApplicationArea = All;
                }
                field("No. Contador"; Rec."No. Contador")
                {
                    ApplicationArea = All;
                }
                field("Tipo incidencia"; Rec."Tipo incidencia")
                {
                    ApplicationArea = All;
                }
                field("Área incidencia"; Rec."Área incidencia")
                {
                    ApplicationArea = All;
                }
                field("Nombre cliente"; Rec."Nombre cliente")
                {
                    ApplicationArea = All;
                }
                field("No. Puesto/Pabellón"; Rec."No. Puesto/Pabellón")
                {
                    ApplicationArea = All;
                }
                field("No. contrato"; Rec."No. contrato")
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