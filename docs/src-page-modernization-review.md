# Revisión modernización `src/page`

Estado tras merge de PR #17.

## Ya mergeadas

- `Pag50001.ListaExpdtesAdjudicacionCom.al`
- `Pag50002.ListaExpdtesAdjudicacionVta.al`
- `Pag50007.HistAguaElectricidad.al`
- `Pag50008.Gestindelecturas.al`
- `Pag50068.RequeststoApproveExp.al`
- `Pag90010.ZAMTicketBaiDocs.al`

## Siguientes focos detectados

### Automation / COM incompatible con SaaS

- `Pag50003.ExpedientesadjudicacinCompr.al`
- `Pag50063.CabeceraFacturaE.al`
- `Pag50066.ListaFacturaElectrnica.al`
- `Pag50072.ListaFacturaElectrnicaRech.al`
- `Pag50074.ListaFacturaElectrnicaReg.al`

### PAGE.RUN / PAGE.RUNMODAL numéricos pendientes

- `Pag50009.FichaLecturas.al`
- `Pag50063.CabeceraFacturaE.al`
- `Pag50065.Documentospendientesaprobar.al`
- `Pag50067.HistFacturasCompraElec.al`
- `Pag50070.PostedSalesInvoicesNOTAcce.al`
- `Pag50071.PostedSalesInvoicesAccesos.al`
- `Pag50512.GestindelecturasdeAguaBO.al`

### RunObject = Page numéricos pendientes

- `Pag50003.ExpedientesadjudicacinCompr.al`
- `Pag50004.ExpedientesadjudicacinVta.al`
- `Pag50006.Contadores.al`
- `Pag50027.Codigosderetencion.al`
- `Pag50028.ListaLotes.al`
- `Pag50033.ListaLotesSubform.al`
- `Pag50066.ListaFacturaElectrnica.al`
- `Pag50067.HistFacturasCompraElec.al`
- `Pag50070.PostedSalesInvoicesNOTAcce.al`
- `Pag50071.PostedSalesInvoicesAccesos.al`
- `Pag50072.ListaFacturaElectrnicaRech.al`
- `Pag50074.ListaFacturaElectrnicaReg.al`
- `Pag50512.GestindelecturasdeAguaBO.al`
- `Pag90000.ZAMTicketBaiSetup.al`
- `Pag90014.ZAMTBRoleCenter.al`

## Criterio

No se considera una page cerrada hasta haber revisado:

- compatibilidad SaaS,
- referencias numéricas,
- acciones promoted legacy,
- uso de `Rec.`,
- `ApplicationArea`,
- `systempart`/`part` sin nombre,
- dependencias estándar obsoletas,
- automatismos COM/DotNet/File local.
