# BC SaaS Modernization Status

## Alcance actual

Modernización conservadora de objetos legacy AL/NAV para compatibilidad con Business Central SaaS, empezando por `src/page`.

El criterio general es conservar la lógica de negocio original y realizar únicamente los cambios necesarios para:

- compilar en entorno SaaS,
- eliminar dependencias no compatibles,
- sustituir referencias numéricas por nombres cuando el objeto está identificado,
- mejorar trazabilidad y mantenibilidad sin rediseñar procesos.

## Estado por PR

### PR #17

Pages modernizadas:

- `Pag50001.ListaExpdtesAdjudicacionCom.al`
- `Pag50002.ListaExpdtesAdjudicacionVta.al`
- `Pag50007.HistAguaElectricidad.al`
- `Pag50008.Gestindelecturas.al`
- `Pag50068.RequeststoApproveExp.al`
- `Pag90010.ZAMTicketBaiDocs.al`

Patrones abordados:

- `Rec.` en triggers y procedimientos.
- `PAGE.RUN` estándar por `Page.Run(Page::...)`.
- `systempart` con nombres explícitos.
- Primer uso de `actionref` en acciones promovidas.

### PR #18

Pages modernizadas:

- `Pag50065.Documentospendientesaprobar.al`
- `Pag50067.HistFacturasCompraElec.al`
- `Pag50070.PostedSalesInvoicesNOTAcce.al`
- `Pag50071.PostedSalesInvoicesAccesos.al`

Patrones abordados:

- `PAGE.RUN` y `PAGE.RUNMODAL` numéricos sustituidos por nombres estándar.
- `RunObject = Page <id>` sustituido por nombres estándar donde estaba identificado.
- Normalización de `CurrPage.SetSelectionFilter`.
- Normalización de factboxes y `systempart`.
- Conservación de flujos FacturaE/PDF y CRM legacy.

### PR #19

Pages modernizadas:

- `Pag50003.ExpedientesadjudicacinCompr.al`
- `Pag50004.ExpedientesadjudicacinVta.al`

Patrones abordados:

- Eliminación de Automation/COM en `Pag50003`.
- Sustitución de selección de carpeta local por error controlado SaaS.
- Sustitución de `part(...; 50028)` por `part(...; "Lista Lotes")`.
- Sustitución de `RunObject = Page <id>` por nombres cuando están identificados.
- Conservación del circuito de aprobaciones y creación de lotes.

### PR #20 / rama `modernize-pages-bc-saas-4`

Pages incluidas:

- `Pag50006.Contadores.al`
- `Pag50027.Codigosderetencion.al`

Documentación añadida:

- `docs/BCSaaS-Modernization-Status.md`
- `docs/BCSaaS-Migration-Guide.md`
- `docs/Modernization-Decision-Log.md`
- `docs/CHANGELOG.md`

Patrones abordados:

- `systempart(; ...)` sustituido por controles con nombre y `ApplicationArea`.
- `RunObject = Page 50007` sustituido por `Page "Hist. Agua /Electricidad"`.
- `CurrPage.EDITABLE` normalizado a `CurrPage.Editable`.
- `RunObject = Page 50002` en `Pag50027` queda documentado como pendiente porque el `RunPageLink` usa `Field2`/`Field13` y no coincide con la page custom 50002 identificada en el repo.

### PR #21 / rama `pages-bc-saas-round-5`

Pages incluidas:

- `Pag50028.ListaLotes.al`

Patrones abordados:

- Sustitución de navegación estándar de compras por nombres de página: ofertas, pedidos, facturas, abonos y archivados.
- Sustitución de `RunObject = Page 50066` por `Page "Lista Factura Electrónica"`.
- Eliminación de duplicidades de `Lote = FIELD(Lote)` en `RunPageLink`.
- Normalización de `Rec.`, `CalcFields` y llamada a `fEditarProrroga`.

## Riesgos abiertos

### Selección de carpetas locales

El patrón `Shell.Application.BrowseForFolder` no es compatible con Business Central SaaS ni con cliente web. No debe migrarse mediante equivalente técnico inexistente.

Opciones funcionales válidas:

- informar URL manualmente,
- integrar SharePoint/OneDrive,
- usar una tabla de documentos vinculados,
- usar `UploadIntoStream` para carga de ficheros cuando aplique,
- exponer una integración documental externa mediante API.

### FacturaE legacy

Las pages `Pag50063`, `Pag50066`, `Pag50072` y `Pag50074` siguen siendo foco de revisión por uso de Automation/COM y flujos documentales legacy.

### Referencias numéricas custom

No se sustituyen referencias numéricas custom si el nombre de objeto no está identificado con seguridad o si existe riesgo de romper compilación.

Casos abiertos:

- `Pag50027.Codigosderetencion.al` mantiene `RunObject = Page 50002` con `TODO SaaS` hasta confirmar el objeto real, porque el link usa campos genéricos.
- `Pag50009.FichaLecturas.al` requiere modificación controlada por tamaño y criticidad funcional.

## Validación pendiente

- Compilación AL-Go tras cada PR.
- Revisión de nombres estándar contra la versión objetivo de Business Central.
- Prueba funcional de navegación entre pages.
- Validación de procesos críticos: lecturas, expedientes, FacturaE, TicketBAI, aprobaciones.
