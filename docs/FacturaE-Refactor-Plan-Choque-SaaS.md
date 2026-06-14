# Plan de choque para refactorización SaaS de FacturaE

## 1. Contexto

El objeto `src/table/Tab50007.CabeceraFacturaERecibida.al` procede de NAV 2016 y actualmente no puede considerarse una refactorización válida para Business Central SaaS.

El repositorio está configurado como app Cloud (`target = Cloud`), pero el objeto contiene patrones no compatibles con SaaS:

- `Automation`.
- ADO/SQL directo contra base externa.
- XML DOM COM.
- rutas locales y `TEMPORARYPATH`.
- referencias a `\\tsclient`.
- SOAP antiguo mediante Automation.
- lógica de negocio pesada dentro de una tabla.
- referencias numéricas a objetos estándar.

## 2. Decisión de urgencia

La refactorización no debe hacerse como una conversión mecánica C/AL -> AL. La estrategia correcta es separar responsabilidades manteniendo una fachada de compatibilidad para no romper llamadas existentes.

## 3. Cambio aplicado en esta rama

Se ha ampliado el rango de objetos en `app.json` de:

```json
"from": 80000,
"to": 99999
```

a:

```json
"from": 50000,
"to": 99999
```

Motivo: el objeto heredado usa IDs 50000 y, en una migración desde NAV, conservar IDs puede ser necesario para mantener compatibilidad con datos, llamadas y objetos relacionados.

## 4. Arquitectura objetivo

La tabla `Cabecera FacturaE Recibida` debe quedar como tabla de datos y fachada ligera.

Responsabilidades propuestas:

| Responsabilidad | Objeto destino |
|---|---|
| Datos de cabecera | `table 50007 "Cabecera FacturaE Recibida"` |
| Líneas | `table 50008 "Linea FacturaE Recibida"` |
| Tasas/retenciones | `table 50009 "Tasa FacturaE Recibida"` |
| Lógica funcional | `codeunit 50007 "FacturaE Recibida Mgt."` |
| Importación | `codeunit 50110 "FacturaE Import Orchestrator"` |
| Parser XML | `codeunit 50112 "FacturaE XML Import"` |
| Documentos/Alfresco/API documental | `codeunit 50113 "FacturaE Document Mgt."` |
| Creación de compras | `codeunit 50114 "FacturaE Purchase Mgt."` |

## 5. Funcionalidad a conservar

La refactorización debe conservar:

- Alta y mantenimiento de cabecera FacturaE recibida.
- Relación con líneas e impuestos.
- Validación de proveedor por CIF, con y sin prefijo de país.
- Identificación de factura/abono por signo del total.
- Creación de documento de compra.
- Creación de líneas de compra.
- Asignación de IVA.
- Tratamiento de retenciones.
- Descuentos.
- Comentarios desde notas.
- Control de importes y tolerancia.
- Estado de rechazo.
- Motivo y descripción de rechazo.
- Apertura/enlace de documentos PDF/XML/adjuntos.
- Propagación de expediente/lote.
- Propagación de dimensiones.
- Wrappers `f...` para compatibilidad mientras existan objetos antiguos que los llamen.

## 6. Bloques que no pueden migrarse literalmente a SaaS

### 6.1. SQL externo / ADO

Debe sustituirse por:

- API HTTP externa.
- carga manual mediante stream.
- cola/interfaz externa que entregue XML a BC.

Business Central SaaS no debe abrir conexiones ADO directas ni ejecutar SQL contra sistemas externos.

### 6.2. SOAP Automation

Debe sustituirse por:

- `HttpClient`.
- XML construido con `XmlDocument` / texto controlado.
- gestión explícita de respuesta y errores.

### 6.3. Ficheros locales

Debe sustituirse por:

- `Temp Blob`.
- `InStream` / `OutStream`.
- `UploadIntoStream`.
- `DownloadFromStream` solo cuando aplique.

### 6.4. Alfresco

Debe decidirse con el cliente:

- mantener Alfresco mediante API HTTP;
- sustituir por enlaces externos;
- migrar a Document Attachment / SharePoint / repositorio documental SaaS.

La tabla no debe contener dependencias rígidas a Alfresco.

## 7. Plan por fases

### Fase 1 - Estabilización SaaS

- Ajustar rango de objetos.
- Crear inventario funcional.
- Crear codeunits destino.
- Mantener wrappers de compatibilidad.
- Eliminar dependencias directas no SaaS de la tabla.

### Fase 2 - Importación

- Extraer `fTraerBackup()` y `fTraerDatosRespaldo()`.
- Sustituir ADO/SQL por API HTTP o carga manual.
- Guardar XML original en BC mediante Blob/stream.
- Registrar trazabilidad.

### Fase 3 - Documentos

- Extraer Alfresco/documentos.
- Sustituir Automation SOAP por `HttpClient`.
- Dejar eventos para implementación específica del cliente.

### Fase 4 - Compras

- Extraer `fRegistrar()` y `fCrearModificar()`.
- Crear factura/abono de compra con codeunit dedicada.
- Mantener importes, IVA, retenciones, descuentos, comentarios y dimensiones.

### Fase 5 - Rechazo/aprobación/dimensiones

- Extraer rechazo.
- Usar enum para estado.
- Mantener validaciones.
- Centralizar propagación de dimensiones.

### Fase 6 - Limpieza final

- Eliminar código muerto.
- Eliminar comentarios NAV obsoletos no útiles.
- Actualizar documentación.
- Compilar contra símbolos reales.

## 8. Riesgo principal

No se puede garantizar una refactorización completamente compilable sin conocer todos los objetos custom relacionados del cliente: tablas 50001, 50002, 50003, 50008, 50009, 50010, 50011, páginas 50028/50066, extensiones de compras y campos custom en `Record Link`.

Por tanto, esta rama debe tratarse como refactorización técnica inicial y base de trabajo. Para cerrar producción se requiere compilar contra el entorno real del cliente o traer al repo todos los objetos dependientes.

## 9. Entregable defendible al cliente

Esta rama permite explicar al cliente que:

1. el objeto heredado no era SaaS-compatible;
2. se ha iniciado la separación real de responsabilidades;
3. se conserva el rango NAV 50000 para minimizar impacto;
4. la migración literal de SQL/Automation/SOAP no es viable en SaaS;
5. se requiere confirmar endpoint/API o repositorio documental definitivo para completar la sustitución técnica.
