permissionset 50007 "FacturaE Recibida"
{
    Assignable = true;
    Caption = 'FacturaE Recibida';
    Permissions = tabledata "Cabecera FacturaE Recibida" = RIMD,
                  table "Cabecera FacturaE Recibida" = X,
                  codeunit "FacturaE Recibida Mgt." = X;
}
