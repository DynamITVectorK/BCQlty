# Final pending pages plan

Pendientes reales:

- `Pag50009.FichaLecturas.al`
- `Pag50063.CabeceraFacturaE.al`
- `Pag50077.BORRARJRB.al`
- `Pag50098.ELIMINARAVG.al`

Criterio obligatorio:

- No sustituir la page por una versión reducida.
- No eliminar campos.
- No eliminar lógica.
- No cambiar comportamiento funcional.
- Modernizar solo sintaxis/metadata incompatible: `Caption`, `Permissions` con nombre de tabla, `SourceTableView`, `actionref`, `Rec.`, casing AL, bloques mal indentados.

Riesgo detectado:

- `Pag50077` y `Pag50098` tienen bloques `field(Area; Rec.Area)` mal indentados que pueden romper compilación.
- `Pag50063` tiene lógica extensa de FacturaE/Alfresco/aprobación y requiere revisión controlada.
- `Pag50009` tiene lógica extensa de lecturas, incidencias y navegación entre contadores.

Pendiente: modernización con revisión completa por objeto y compilación AL-Go.
