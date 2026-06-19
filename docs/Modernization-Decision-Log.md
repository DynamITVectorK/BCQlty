# Modernization Decision Log

## DEC-001 — Modernización conservadora

La migración desde NAV/AL legacy a Business Central SaaS debe conservar la lógica funcional original.

No se aplican refactors de diseño amplios salvo que sean necesarios para compatibilidad SaaS o compilación.

## DEC-002 — Referencias numéricas

Las referencias numéricas a objetos estándar se sustituyen por nombres cuando el objeto está identificado.

Las referencias custom 50000/90000 solo se sustituyen si el nombre del objeto está confirmado en el repositorio.

## DEC-003 — Automation/COM

Automation y COM no son compatibles con Business Central SaaS.

Si existe equivalente SaaS claro, se sustituye. Si no existe equivalente directo, se bloquea la acción con error controlado y se documenta la decisión funcional pendiente.

Caso aplicado:

- `Pag50003.ExpedientesadjudicacinCompr.al`
  - `Shell.Application.BrowseForFolder` se sustituye por error controlado.
  - Pendiente definir alternativa funcional para `Bases expediente`.

## DEC-004 — Documentación obligatoria por PR

Cada PR de modernización debe actualizar la documentación aplicable:

- estado de modernización,
- guía de migración si aparece un patrón nuevo,
- decision log si se toma una decisión funcional/técnica relevante,
- checklist de pendientes.

## DEC-005 — PRs pequeños

Se priorizan PRs pequeños y revisables frente a cambios masivos.

Motivo:

- facilita revisión funcional,
- reduce riesgo de regresión,
- permite aislar errores de compilación,
- permite validar progresivamente con AL-Go.
