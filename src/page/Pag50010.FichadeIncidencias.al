page 50010 "Ficha de Incidencias"
{
    PageType = Card;
    UsageCategory = Administration;
    SourceTable = 50004;

    layout
    {
        area(content)
        {
            group(Contador)
            {
                field("No. incidencia"; Rec."No. incidencia")
                {
                    ApplicationArea = All;
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("Área incidencia"; Rec."Área incidencia")
                {
                    ApplicationArea = All;
                }
                field("No. Contador"; Rec."No. Contador")
                {
                    ApplicationArea = All;
                }
                field("No. Puesto/Pabellón"; Rec."No. Puesto/Pabellón")
                {
                    ApplicationArea = All;
                }
                field("Tipo incidencia"; Rec."Tipo incidencia")
                {
                    ApplicationArea = All;
                }
                field(Tarifa; Rec.Tarifa)
                {
                    ApplicationArea = All;
                }
                field("Nombre cliente"; Rec."Nombre cliente")
                {
                    ApplicationArea = All;
                }
                field("No. contrato"; Rec."No. contrato")
                {
                    ApplicationArea = All;
                }
                field("Potencia contratada"; Rec."Potencia contratada")
                {
                    ApplicationArea = All;
                }
            }
            group(Incidencia)
            {
                field("Lec. fin  averiado no TT"; Rec."Lec. fin  averiado no TT")
                {
                    ApplicationArea = All;
                }
                field("Lec. fin  averiado HP  TT"; Rec."Lec. fin  averiado HP  TT")
                {
                    ApplicationArea = All;
                }
                field("Lec. fin  averiado HLL  TT"; Rec."Lec. fin  averiado HLL  TT")
                {
                    ApplicationArea = All;
                }
                field("Lec. fin  averiado HV TT"; Rec."Lec. fin  averiado HV TT")
                {
                    ApplicationArea = All;
                }
                field("Lec. Inicio  averiado no TT"; Rec."Lec. Inicio  averiado no TT")
                {
                    ApplicationArea = All;
                    Caption = 'Lectura Inicio contador Nuevo (Tarifa no TT)';
                }
                field("Lec. Inicio  averiado HP  TT"; Rec."Lec. Inicio  averiado HP  TT")
                {
                    ApplicationArea = All;
                    Caption = 'Lectura Inicio contador Nuevo (Hora Punta-TT)';
                }
                field("Lec. Inicio  averiado HLL  TT"; Rec."Lec. Inicio  averiado HLL  TT")
                {
                    ApplicationArea = All;
                    Caption = 'Lectura Inicio contador Nuevo (Hora Llana-TT)';
                }
                field("Lec. Inicio  averiado HV TT"; Rec."Lec. Inicio  averiado HV TT")
                {
                    ApplicationArea = All;
                    Caption = 'Lectura Inicio contador Nuevo (Hora Valle-TT)';
                }
            }
            group(Comentario)
            {
                Caption = 'Comentarios';
                //The GridLayout property is only supported on controls of type Grid
                //GridLayout = Columns;
                field(Comentarios; Rec.Comentarios)
                {
                    ApplicationArea = All;
                    AutoFormatType = 1;
                    MultiLine = true;
                }
            }
        }
    }

    actions
    {
    }
}

