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
                field("No. incidencia"; "No. incidencia")
                {
                    ApplicationArea = All;
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("Área incidencia"; "Área incidencia")
                {
                    ApplicationArea = All;
                }
                field("No. Contador"; "No. Contador")
                {
                    ApplicationArea = All;
                }
                field("No. Puesto/Pabellón"; "No. Puesto/Pabellón")
                {
                    ApplicationArea = All;
                }
                field("Tipo incidencia"; "Tipo incidencia")
                {
                    ApplicationArea = All;
                }
                field(Tarifa; Tarifa)
                {
                    ApplicationArea = All;
                }
                field("Nombre cliente"; "Nombre cliente")
                {
                    ApplicationArea = All;
                }
                field("No. contrato"; "No. contrato")
                {
                    ApplicationArea = All;
                }
                field("Potencia contratada"; "Potencia contratada")
                {
                    ApplicationArea = All;
                }
            }
            group(Incidencia)
            {
                field("Lec. fin  averiado no TT"; "Lec. fin  averiado no TT")
                {
                    ApplicationArea = All;
                }
                field("Lec. fin  averiado HP  TT"; "Lec. fin  averiado HP  TT")
                {
                    ApplicationArea = All;
                }
                field("Lec. fin  averiado HLL  TT"; "Lec. fin  averiado HLL  TT")
                {
                    ApplicationArea = All;
                }
                field("Lec. fin  averiado HV TT"; "Lec. fin  averiado HV TT")
                {
                    ApplicationArea = All;
                }
                field("Lec. Inicio  averiado no TT"; "Lec. Inicio  averiado no TT")
                {
                    ApplicationArea = All;
                    Caption = 'Lectura Inicio contador Nuevo (Tarifa no TT)';
                }
                field("Lec. Inicio  averiado HP  TT"; "Lec. Inicio  averiado HP  TT")
                {
                    ApplicationArea = All;
                    Caption = 'Lectura Inicio contador Nuevo (Hora Punta-TT)';
                }
                field("Lec. Inicio  averiado HLL  TT"; "Lec. Inicio  averiado HLL  TT")
                {
                    ApplicationArea = All;
                    Caption = 'Lectura Inicio contador Nuevo (Hora Llana-TT)';
                }
                field("Lec. Inicio  averiado HV TT"; "Lec. Inicio  averiado HV TT")
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
                field(Comentarios; Comentarios)
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

