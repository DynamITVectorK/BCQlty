enum 80003 "BD Respaldo Factura Estado Nav"
{
    Extensible = true;
    Caption = 'BD Respaldo Factura Estado Nav';

    value(0; Pendiente)
    {
        Caption = 'Pendiente';
    }
    value(1; Importado)
    {
        Caption = 'Importado';
    }
    value(2; "Con Errores")
    {
        Caption = 'Con Errores';
    }
}
