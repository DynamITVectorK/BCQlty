permissionset 50007 "FacturaE Recibida"
{
    Assignable = true;
    Caption = 'FacturaE Recibida';
    Permissions = tabledata "Cabecera FacturaE Recibida" = RIMD,
                  tabledata "Linea FacturaE Recibida" = RIMD,
                  tabledata "Tasa FacturaE Recibida" = RIMD,
                  tabledata "FacturaE Import Setup" = RIMD,
                  tabledata "FacturaE Import Log" = RIMD,
                  table "Cabecera FacturaE Recibida" = X,
                  table "Linea FacturaE Recibida" = X,
                  table "Tasa FacturaE Recibida" = X,
                  table "FacturaE Import Setup" = X,
                  table "FacturaE Import Log" = X,
                  codeunit "FacturaE Recibida Mgt." = X,
                  codeunit "FacturaE XML Import" = X,
                  codeunit "FacturaE Import Orchestrator" = X,
                  page "FacturasE Recibidas" = X,
                  page "FacturaE Import Setup" = X,
                  page "FacturaE Import Log" = X;
}
