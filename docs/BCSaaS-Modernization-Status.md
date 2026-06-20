# BC SaaS Modernization Status

## Alcance actual

Modernización conservadora de objetos legacy AL/NAV para compatibilidad con Business Central SaaS, empezando por `src/page`.

El criterio general es conservar la lógica de negocio original y realizar únicamente los cambios necesarios para:

- compilar en entorno SaaS,
- eliminar dependencias no compatibles,
- sustituir referencias numéricas por nombres cuando el objeto está identificado,
- mejorar trazabilidad y mantenibilidad sin rediseñar procesos.

## Regla vigente desde PR #37

No se tratan ni modernizan objetos del rango `90000–90999`. Las siguientes tandas quedan limitadas a objetos fuera de ese rango, salvo instrucción expresa en contrario.

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

### PR #22 / rama `pages-bc-saas-round-6`

Pages incluidas:

- `Pag50033.ListaLotesSubform.al`

Patrones abordados:

- Mismo patrón de navegación que `Pag50028`, aplicado al subform.
- Conservación de la restricción funcional de no borrar lote `0`.
- Sustitución de referencias numéricas a pages estándar y a `Lista Factura Electrónica`.
- Eliminación de duplicidades de `Lote = FIELD(Lote)` en `RunPageLink`.
- Normalización de `Rec.`, `CalcFields` y llamada a `fEditarProrroga`.

### PR #23 / rama `pages-bc-saas-round-7`

Pages incluidas:

- `Pag50512.GestindelecturasdeAguaBO.al`

Patrones abordados:

- Sustitución de `PAGE.RUN(42, ...)` por `Page.Run(Page::"Sales Order", ...)`.
- Sustitución de `RunObject = Page 50006` por `Page Contadores`.
- Sustitución de `RunObject = Page 50007` por `Page "Hist. Agua /Electricidad"`.
- Sustitución de `Page 50009` por `Page "Ficha Lecturas"`.
- Normalización de `systempart`, `Rec.`, `CurrPage` implícito y casing AL moderno.
- Conservación del flujo funcional de creación y apertura de nueva lectura.

### PR #24

Pages incluidas:

- `Pag50512.GestindelecturasdeAguaBO.al`

Patrones abordados:

- Sustitución de propiedades obsoletas `Promoted`, `PromotedCategory` y `PromotedIsBig` por `area(Promoted)` con `actionref`.
- Actualización de `docs/BCSaaS-Migration-Guide.md` para dejar este patrón como obligatorio.

### PR #25 / rama `modernize-pages-promoted-01`

Pages incluidas:

- `Pag50006.Contadores.al`
- `Pag50027.Codigosderetencion.al`

Patrones abordados:

- Sustitución de `Promoted`, `PromotedCategory` y `PromotedIsBig` por `area(Promoted)` con `actionref`.
- Conservación del `TODO SaaS` de `Pag50027` sobre `RunObject = Page 50002`, sin sustituir referencia custom no identificada.

### PR #26 / rama `modernize-pages-promoted-02`

Pages incluidas:

- `Pag50031.procesodefactura.al`

Patrones abordados:

- Sustitución de `Promoted = true` por `area(Promoted)` con `actionref`.
- Normalización de `SourceTableView` conservando la tabla virtual original.
- Conservación de la llamada funcional `RegistroFacturaAdos`.

### PR #27 / rama `p27-modernize-pages`

Pages incluidas:

- `Pag90000.ZAMTicketBaiSetup.al`

Patrones abordados:

- Eliminación de `PromotedActionCategories`.
- Sustitución de `Promoted`, `PromotedCategory` y `PromotedIsBig` por `area(Promoted)` con `actionref`.
- Sustitución de `RunObject = Page 427` por `Page "Payment Methods"`.
- Sustitución de `RunObject = Page 4` por `Page "Payment Terms"`.
- Normalización de `systempart`, `Clear`, `Modify`, `Reset`, `Get`, `Init` e `Insert`.
- Conservación de las acciones de importación y borrado de certificados TicketBAI.

### PR #28 / rama `p28-pages-batch`

Pages incluidas:

- `Pag50007.HistAguaElectricidad.al`
- `Pag50008.Gestindelecturas.al`
- `Pag90019.ZAMTicketBaiHistDocs.al`

Patrones abordados:

- Eliminación de `PromotedActionCategories`.
- Sustitución de `Promoted`, `PromotedCategory` y `PromotedIsBig` por `area(Promoted)` con `actionref`.
- Normalización de `CurrPage.Update`, `FilterGroup`, `SetRange`, `SetFilter`, `CompanyName` y casing AL.
- Conservación de la lógica de lecturas, modificación/borrado de lecturas, navegación a contador/contrato/factura/incidencia y comunicaciones TicketBAI.

### PR #37 / rama `p37-pages-500-batch`

Pages incluidas:

- `Pag50000.LecturasDORLET.al`
- `Pag50005.Listadecontadores.al`
- `Pag50021.WSInformacincliente.al`
- `Pag50023.WSHistoricodefacturas.al`

Patrones abordados:

- No se modifican objetos del rango `90000–90999`.
- Sustitución de `systempart` anónimo por controles con nombre y `ApplicationArea` en `Pag50005`.
- Normalización de acción anónima de importación en `Pag50000` mediante grupo con nombre.
- Normalización de casing AL (`Report.Run`, `CalcFields`, `Clear`, `Get`, `CalcDate`, `Format`, `WorkDate`, `SetFilter`, `SetRange`).
- Corrección de expresiones de campos calculados/variables de page para conservar compilación y comportamiento.

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
