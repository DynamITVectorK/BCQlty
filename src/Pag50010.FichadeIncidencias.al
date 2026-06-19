page 50010 "Ficha de Incidencias"
{
    PageType = Card;
    SourceTable = Table50004;

    layout
    {
        area(content)
        {
            group(Contador)
            {
                field("No. incidencia"; "No. incidencia")
                {
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("Área incidencia"; "Área incidencia")
                {
                }
                field("No. Contador"; "No. Contador")
                {
                }
                field("No. Puesto/Pabellón"; "No. Puesto/Pabellón")
                {
                }
                field("Tipo incidencia"; "Tipo incidencia")
                {
                }
                field(Tarifa; Tarifa)
                {
                }
                field("Nombre cliente"; "Nombre cliente")
                {
                }
                field("No. contrato"; "No. contrato")
                {
                }
                field("Potencia contratada"; "Potencia contratada")
                {
                }
            }
            group(Incidencia)
            {
                field("Lec. fin  averiado no TT"; "Lec. fin  averiado no TT")
                {
                }
                field("Lec. fin  averiado HP  TT"; "Lec. fin  averiado HP  TT")
                {
                }
                field("Lec. fin  averiado HLL  TT"; "Lec. fin  averiado HLL  TT")
                {
                }
                field("Lec. fin  averiado HV TT"; "Lec. fin  averiado HV TT")
                {
                }
                field("Lec. Inicio  averiado no TT"; "Lec. Inicio  averiado no TT")
                {
                    Caption = 'Lectura Inicio contador Nuevo (Tarifa no TT)';
                }
                field("Lec. Inicio  averiado HP  TT"; "Lec. Inicio  averiado HP  TT")
                {
                    Caption = 'Lectura Inicio contador Nuevo (Hora Punta-TT)';
                }
                field("Lec. Inicio  averiado HLL  TT"; "Lec. Inicio  averiado HLL  TT")
                {
                    Caption = 'Lectura Inicio contador Nuevo (Hora Llana-TT)';
                }
                field("Lec. Inicio  averiado HV TT"; "Lec. Inicio  averiado HV TT")
                {
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

