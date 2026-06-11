permissionset 50007 "FacturaE Recibida"
{
    Assignable = true;
    Caption = 'FacturaE Recibida';
    Permissions = tabledata "Cabecera FacturaE Recibida" = RIMD,
                  tabledata "Linea FacturaE Recibida" = RIMD,
                  tabledata "Tasa FacturaE Recibida" = RIMD,
                  table "Cabecera FacturaE Recibida" = X,
                  table "Linea FacturaE Recibida" = X,
                  table "Tasa FacturaE Recibida" = X,
                  codeunit "FacturaE Recibida Mgt." = X,
                  codeunit "FacturaE XML Import" = X,
                  page "FacturasE Recibidas" = X;
}
