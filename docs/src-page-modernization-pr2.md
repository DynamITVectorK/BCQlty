# Segunda tanda de modernización `src/page`

Rama: `modernize-pages-bc-saas-2`

## Pages modificadas

- `src/page/Pag50065.Documentospendientesaprobar.al`
- `src/page/Pag50067.HistFacturasCompraElec.al`
- `src/page/Pag50070.PostedSalesInvoicesNOTAcce.al`
- `src/page/Pag50071.PostedSalesInvoicesAccesos.al`

## Criterio aplicado

Modernización conservadora orientada a Business Central SaaS:

- Sustitución de llamadas `PAGE.RUN` / `PAGE.RUNMODAL` numéricas por `Page.Run(Page::...)` cuando la página estándar está identificada.
- Sustitución de `RunObject = Page <id>` por nombres de páginas estándar cuando están identificadas.
- Normalización de `CurrPage.SETSELECTIONFILTER` a `CurrPage.SetSelectionFilter`.
- Normalización de `Rec.` en accesos a campos desde triggers.
- Normalización de `systempart` y `part` sin nombre.
- Conservación de lógica de negocio legacy, especialmente exportación PDF y circuitos CRM/FacturaE.

## Pendiente de validación

- Compilación AL-Go.
- Revisión de nombres estándar en versión objetivo de BC.
- Continuar con pages restantes con `Automation` y referencias numéricas custom.
