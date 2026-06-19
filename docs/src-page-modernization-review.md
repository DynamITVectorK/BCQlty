# Revisión modernización `src/page`

Estado actualizado tras merge de PR #17, PR #18 y PR #19.

## Pages revisadas / modernizadas

### PR #17

- `Pag50001.ListaExpdtesAdjudicacionCom.al`
- `Pag50002.ListaExpdtesAdjudicacionVta.al`
- `Pag50007.HistAguaElectricidad.al`
- `Pag50008.Gestindelecturas.al`
- `Pag50068.RequeststoApproveExp.al`
- `Pag90010.ZAMTicketBaiDocs.al`

### PR #18

- `Pag50065.Documentospendientesaprobar.al`
- `Pag50067.HistFacturasCompraElec.al`
- `Pag50070.PostedSalesInvoicesNOTAcce.al`
- `Pag50071.PostedSalesInvoicesAccesos.al`

### PR #19

- `Pag50003.ExpedientesadjudicacinCompr.al`
- `Pag50004.ExpedientesadjudicacinVta.al`

## Pendientes relevantes detectados

### Automation / COM incompatible con SaaS

- `Pag50063.CabeceraFacturaE.al`
- `Pag50066.ListaFacturaElectrnica.al`
- `Pag50072.ListaFacturaElectrnicaRech.al`
- `Pag50074.ListaFacturaElectrnicaReg.al`

> `Pag50003.ExpedientesadjudicacinCompr.al` ya no mantiene Automation/COM. La acción de selección de carpeta local queda sustituida por un error controlado SaaS porque `Shell.Application.BrowseForFolder` no tiene equivalente directo en cliente web/SaaS.

### PAGE.RUN / PAGE.RUNMODAL numéricos pendientes

- `Pag50009.FichaLecturas.al`
- `Pag50063.CabeceraFacturaE.al`
- `Pag50512.GestindelecturasdeAguaBO.al`

### RunObject = Page numéricos pendientes

- `Pag50006.Contadores.al`
- `Pag50027.Codigosderetencion.al`
- `Pag50028.ListaLotes.al`
- `Pag50033.ListaLotesSubform.al`
- `Pag50066.ListaFacturaElectrnica.al`
- `Pag50072.ListaFacturaElectrnicaRech.al`
- `Pag50074.ListaFacturaElectrnicaReg.al`
- `Pag50512.GestindelecturasdeAguaBO.al`
- `Pag90000.ZAMTicketBaiSetup.al`
- `Pag90014.ZAMTBRoleCenter.al`

## Criterio de cierre por page

No se considera una page cerrada hasta haber revisado:

- compatibilidad SaaS,
- referencias numéricas,
- acciones promoted legacy,
- uso de `Rec.`,
- `ApplicationArea`,
- `systempart`/`part` sin nombre,
- dependencias estándar obsoletas,
- automatismos COM/DotNet/File local,
- documentación actualizada en el PR correspondiente.
