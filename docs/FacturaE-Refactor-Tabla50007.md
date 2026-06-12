# Refactorización de la tabla 50007 "Cabecera FacturaE Recibida"

## 1. Objetivo del documento

Este documento explica, en lenguaje funcional y técnico sencillo, cómo se ha refactorizado la antigua tabla **50007 "Cabecera FacturaE Recibida"** procedente de NAV 2016 para convertirla en una solución compatible con **Microsoft Dynamics 365 Business Central SaaS**.

La tabla original concentraba demasiadas responsabilidades en un único objeto: almacenamiento de datos, conexión directa a SQL Server, importación de XML, lectura de ficheros locales, integración con Alfresco, aprobación/rechazo, creación de facturas de compra, actualización de dimensiones y manipulación de textos. En Business Central SaaS ese diseño no es mantenible ni válido, porque no se permite ejecutar `Automation`, acceder directamente a SQL Server ni trabajar con rutas temporales locales del cliente/servidor.

La solución refactorizada separa responsabilidades en objetos AL especializados:

| Responsabilidad | Objeto nuevo/refactorizado |
|---|---|
| Datos de cabecera FacturaE | `table 50007 "Cabecera FacturaE Recibida"` |
| Líneas de factura recibida | `table 50008 "Linea FacturaE Recibida"` |
| Tasas/impuestos importados | `table 50009 "Tasa FacturaE Recibida"` |
| Lógica funcional de FacturaE | `codeunit 50007 "FacturaE Recibida Mgt."` |
| Orquestación de importación | `codeunit 50110 "FacturaE Import Orchestrator"` |
| Parser XML FacturaE | `codeunit 50112 "FacturaE XML Import"` |
| Configuración de origen de importación | `table 50110 "FacturaE Import Setup"` |
| Histórico/log de importaciones | `table 50111 "FacturaE Import Log"` |
| Pantalla de trabajo | `page 50066 "FacturasE Recibidas"` |
| Pantallas de configuración/log | `page 50110`, `page 50111` |
| Campos FacturaE en compras | extensiones de `Purchase Header`, `Purch. Inv. Header`, `Purch. Cr. Memo Hdr.` |

---

## 2. Principios de arquitectura aplicados

### 2.1. Separación de responsabilidades

La tabla 50007 ya no contiene procesos largos ni integraciones técnicas. Ahora conserva:

- campos de datos con sus nombres legacy conservados;
- claves;
- validaciones simples;
- métodos públicos de compatibilidad;
- delegación a codeunits especializados.

La lógica de negocio se mueve a `FacturaE Recibida Mgt.` y la importación queda dividida entre:

- `FacturaE Import Orchestrator`: decide de dónde vienen los datos y registra trazabilidad;
- `FacturaE XML Import`: interpreta el XML y crea datos internos.

### 2.2. Compatibilidad SaaS

Se han eliminado patrones heredados de NAV 2016 no permitidos en SaaS:

- `Automation` / ADO;
- conexión directa a SQL Server;
- `CREATE(alConnection)` / `CREATE(alCommand)`;
- `TEMPORARYPATH` y ficheros locales;
- referencias numéricas opacas como `Record "38"`, `Codeunit "419"`, etc.;
- lógica dependiente de cliente Windows.

En su lugar se usan patrones SaaS:

- `UploadIntoStream` para carga manual de XML;
- `HttpClient` para entrada desde API externa;
- `JsonObject`/`JsonArray` para respuestas de integración;
- `XmlDocument` para leer FacturaE;
- `Temp Blob`, `InStream` y `OutStream` para contenido binario/texto;
- tablas de configuración y log en Business Central;
- eventos de integración para adaptar procesos específicos del cliente.

### 2.3. Mantenimiento de fachada compatible

Aunque internamente se ha cambiado la arquitectura, se conservan nombres equivalentes para los procesos principales:

- `TraerBackup()`;
- `TraerDatosRespaldo()`;
- `TraerDatosRespaldoPaso1()`;
- `ImportarXmlFacturaE()`;
- wrappers `f...` para reducir impacto en llamadas antiguas;
- referencias a campos legacy como `ID_PLATAFORMA`, `NUM`, `EMISOR_CIF` y `TOTAL_PAGAR`.

Así, otros objetos que antes llamaban a la tabla o a sus campos pueden migrarse gradualmente sin romper el upgrade.

---

## 3. Refactorización de campos y estructura de datos

### 3.1. Campos de cabecera

La tabla 50007 se mantiene como cabecera de factura recibida y **debe conservar los nombres físicos antiguos de los campos**. Esta decisión es crítica para el upgrade técnico: en Business Central/NAV, cambiar el nombre de un campo existente con el mismo ID puede provocar problemas en procesos de sincronización, referencias de objetos, scripts de upgrade, datos históricos, extensiones dependientes y herramientas que todavía apunten al nombre legacy.

Por tanto, la refactorización no debe renombrar campos como `ID_PLATAFORMA`, `NUM`, `SERIE`, `EMISOR_CIF` o `TOTAL_PAGAR`. Lo correcto es mejorar captions, documentación, clasificación de datos y mover lógica a codeunits, pero manteniendo el contrato físico de la tabla.

| Field ID | Nombre físico que debe conservarse | Caption funcional recomendado |
|---|---|---|
| 1 | `ID_PLATAFORMA` | ID Plataforma |
| 2 | `NUM` | Número |
| 3 | `SERIE` | Serie |
| 4 | `FECHA_ENTRADA` | Fecha Entrada |
| 5 | `FECHA_DEVENGO` | Fecha Devengo |
| 6 | `EMISOR_CIF` | CIF Emisor |
| 7 | `EMISOR_NOMBRE` | Nombre Emisor |
| 8 | `EMISOR_DIRECCION` | Dirección Emisor |
| 9 | `EMISOR_CIUDAD` | Ciudad Emisor |
| 10 | `EMISOR_PROVINCIA` | Provincia Emisor |
| 11 | `EMISOR_CP` | Cód. Postal Emisor |
| 12 | `EMISOR_TELEFONO` | Teléfono Emisor |
| 13 | `EMISOR_EMAIL` | Email Emisor |
| 14 | `RECEPTOR_CIF` | CIF Receptor |
| 22 | `FORMA_PAGO` | Forma Pago |
| 23 | `FECHA_PAGO` | Fecha Pago |
| 24 | `CCC_PAGO` | IBAN Pago |
| 25 | `NOTAS` | Notas |
| 26 | `CONTACTO_NOMBRE` | Nombre Contacto |
| 27 | `CONTACTO_TELEFONO` | Teléfono Contacto |
| 28 | `CONTACTO_EMAIL` | Email Contacto |
| 29 | `TOTAL_BASES` | Total Bases |
| 30 | `TOTAL_TASAS` | Total Tasas |
| 31 | `TOTAL_PAGAR` | Total Pagar |

Las referencias en codeunits, páginas, FlowFields, filtros y extensiones deben usar esos nombres legacy. Por ejemplo, la nueva lógica no debe referenciar `"ID Plataforma"` ni `"Numero"`; debe referenciar `ID_PLATAFORMA` y `NUM`. Del mismo modo, importación XML, registro de compras y validaciones de proveedor deben escribir sobre `EMISOR_CIF`, `EMISOR_NOMBRE`, `TOTAL_PAGAR`, etc.

Además, se añade `DataClassification` a los campos para cumplir requisitos de Business Central SaaS, pero sin cambiar el nombre físico del campo.

### 3.2. XML original

El antiguo proceso SQL leía el campo `XML_DATA` desde una base externa. En la nueva solución, el XML queda guardado dentro de Business Central en:

- `XML Original` (`Blob`);
- `Nombre Fichero XML` (`Text[250]`).

Esto permite consultar, auditar y reprocesar información sin depender de ficheros temporales ni de una base SQL externa.

### 3.3. Líneas e impuestos

La tabla antigua asumía la existencia de objetos custom NAV 50008/50009. En la solución refactorizada se definen explícitamente:

- `table 50008 "Linea FacturaE Recibida"`;
- `table 50009 "Tasa FacturaE Recibida"`.

Con ello, la cabecera 50007 tiene un modelo de datos completo para importar líneas de FacturaE y tasas/impuestos, y no depende de objetos implícitos del entorno antiguo.

---

## 4. Refactorización de triggers de tabla

### 4.1. `OnInsert`

**Antes:** la tabla rellenaba fecha, hora y usuario de importación directamente.

**Ahora:** se mantiene el mismo comportamiento, pero usando funciones AL actuales:

- `Today()`;
- `Time()`;
- `UserId()` con `CopyStr` para respetar longitud de campo.

### 4.2. `OnDelete`

**Antes:** el trigger borraba directamente líneas y tasas con variables globales `Record "50008"` y `Record "50009"`.

**Ahora:** el trigger delega en `FacturaE Recibida Mgt.` y este borra datos relacionados en las tablas `Linea FacturaE Recibida` y `Tasa FacturaE Recibida`.

Beneficio para el cliente:

- borrado centralizado;
- posibilidad de añadir eventos o reglas futuras;
- menos lógica técnica dentro de la tabla.

---

## 5. Refactorización de procesos de importación

Los cuatro procesos señalados por el cliente son el núcleo de la refactorización.

### 5.1. `TraerBackup()`

#### Comportamiento antiguo

`fTraerBackup()` abría una conexión ADO contra SQL Server, leía registros pendientes de la tabla externa `INVOICE`, tomaba el campo `XML_DATA`, importaba el XML y después ejecutaba un `UPDATE` para marcar el registro como procesado.

#### Problema

Ese diseño no es válido en Business Central SaaS porque:

- no se puede usar `Automation`;
- no se debe conectar BC directamente a SQL Server externo;
- no se deben ejecutar sentencias SQL desde AL contra sistemas externos.

#### Diseño nuevo

`TraerBackup()` se mantiene como entrada pública, pero delega en `ImportBackupData()` del codeunit de gestión. Este, a su vez, invoca al orquestador `FacturaE Import Orchestrator`.

El orquestador decide el origen según la configuración:

- **Manual**: el usuario selecciona un XML FacturaE;
- **HTTP Endpoint**: BC llama a una API externa que devuelve facturas pendientes en JSON.

Con este diseño, el antiguo concepto de “backup SQL” pasa a ser “origen de importación configurado”.

### 5.2. `TraerDatosRespaldo()`

#### Comportamiento antiguo

Hacía un proceso similar a `TraerBackup()`, pero con más normalización previa en SQL:

- actualizaba estados nulos;
- actualizaba CIF comprador nulo;
- leía XML pendiente;
- guardaba XML en tabla auxiliar;
- marcaba procesado en SQL.

#### Diseño nuevo

`TraerDatosRespaldo()` devuelve un booleano indicando si se importaron datos. Internamente usa el mismo orquestador.

La normalización ya no se hace con `UPDATE` SQL. Ahora debe resolverse de dos formas:

1. en la API externa que entrega los datos a BC;
2. o en el parser/importador AL, aplicando valores por defecto y validaciones.

En el código actual, el parser AL ya rellena cabecera, líneas y tasas desde el XML y guarda el XML original en BC.

### 5.3. `TraerDatosRespaldoPaso1()`

#### Comportamiento antiguo

Era una capa de confirmación de usuario:

- preguntaba si se deseaba importar;
- llamaba a `fTraerDatosRespaldo()`;
- mostraba mensaje final.

#### Diseño nuevo

Se conserva el mismo patrón funcional, pero delegado al orquestador:

- confirma si se desean importar facturas recibidas;
- ejecuta el origen configurado;
- muestra resultado de importación.

Beneficio:

- el usuario conserva un flujo parecido;
- el origen puede evolucionar sin cambiar la tabla 50007.

### 5.4. `ImportarXmlFacturaE()`

#### Comportamiento antiguo

La importación XML estaba mezclada con procesos SQL, ficheros temporales y codeunits heredados.

#### Diseño nuevo

Se divide en dos entradas:

1. `ImportarXmlFacturaE()` sin parámetros: abre selector de fichero XML.
2. `ImportarXmlFacturaE(InStream, FileName)`: permite importar desde una API, test, cola o conector externo.

Ambas rutas terminan en `FacturaE XML Import`, que:

- lee el XML con `XmlDocument`;
- crea/actualiza cabecera usando los campos legacy (`ID_PLATAFORMA`, `NUM`, `EMISOR_CIF`, `TOTAL_PAGAR`, etc.);
- guarda XML original;
- importa líneas;
- importa tasas.

---

## 6. Nuevo orquestador de importación

`codeunit 50110 "FacturaE Import Orchestrator"` es el nuevo punto central para importar facturas recibidas.

### 6.1. Modo manual

El usuario selecciona un fichero `.xml`. El sistema:

1. recibe el fichero con `UploadIntoStream`;
2. lo envía al importador XML;
3. registra el resultado en el log.

### 6.2. Modo HTTP Endpoint

La configuración permite indicar una URL de facturas pendientes. El sistema:

1. llama a la URL con `HttpClient`;
2. espera un JSON con array `invoices` o `value`;
3. cada elemento debe incluir, como mínimo:
   - `id`;
   - `fileName`;
   - `xml`;
4. importa cada XML;
5. registra cada importación;
6. opcionalmente llama a una URL de marcado como procesado.

Este patrón sustituye al antiguo `SELECT ... FROM INVOICE` + `UPDATE INVOICE SET STATE = ...`.

### 6.3. Marcado como procesado

En NAV se hacía con SQL `UPDATE`. En SaaS, el marcado se realiza mediante una URL configurable `Mark Processed URL`. El sistema envía un `POST` con:

```json
{
  "id": "identificador externo",
  "invoicePlatformId": "identificador en Business Central"
}
```

Esto es más seguro y compatible con SaaS porque BC no toca directamente la base de datos externa.

---

## 7. Configuración y log

### 7.1. Configuración de importación

Se añade `FacturaE Import Setup` con:

- origen manual o HTTP;
- URL de facturas pendientes;
- URL de marcado como procesado;
- activo/inactivo;
- última ejecución;
- número importado;
- último error.

### 7.2. Log de importación

Se añade `FacturaE Import Log` con:

- identificador externo;
- fichero;
- factura creada/importada;
- estado;
- mensaje;
- fecha/hora;
- usuario.

Esto proporciona trazabilidad al cliente y facilita soporte.

---

## 8. Refactorización de Alfresco/documentos

La tabla antigua contenía muchas funciones específicas de Alfresco:

- obtener ticket;
- construir URL;
- abrir documento;
- copiar adjuntos;
- firmar documentos;
- descargar/subir ficheros.

En la refactorización se conserva el comportamiento funcional básico de apertura:

- `AbrirDocumentoAlfresco()`;
- `AbrirContenedorAlfresco()`;
- `VerFacturaE()`.

Estas funciones ya no usan Automation ni rutas locales. El sistema trabaja con URL o rutas almacenadas y usa `Hyperlink` para abrir el recurso. Las integraciones avanzadas con repositorios documentales deben implementarse mediante API HTTP o conectores externos, no con dependencias de cliente Windows.

---

## 9. Refactorización de aprobación y rechazo

### 9.1. `ApproveEInvoice()`

Antes la aprobación estaba ligada a variables globales y lógica de usuario/aprobador dentro de la tabla.

Ahora:

- valida que la factura no esté rechazada;
- cambia el estado a `Approved`;
- modifica el registro;
- publica eventos antes/después para personalizaciones.

### 9.2. `RechazarFacturaEPaso1()` y `RechazarFacturaE()`

Antes el rechazo combinaba confirmaciones, comunicación externa, validaciones de documentos y mensajes.

Ahora:

- `RechazarFacturaEPaso1()` se encarga de la confirmación;
- `RechazarFacturaE()` valida que no exista documento en curso ni registrado;
- marca `Rechazada = true`;
- cambia estado a `Rejected`;
- permite extensibilidad mediante eventos.

---

## 10. Refactorización de creación/registro de factura de compra

### 10.1. `Registrar()` / `fRegistrar()`

La función antigua tenía mucha lógica en la tabla: cabecera de compra, líneas, impuestos, comentarios, contratación, tolerancias, aprobaciones, registro, etc.

Ahora se ha separado así:

- la tabla mantiene el método público `Registrar()`;
- el codeunit de gestión crea la cabecera de compra;
- se generan líneas desde `Linea FacturaE Recibida`;
- se exige `Cuenta NAV` en cada línea para evitar facturas contables incompletas;
- si el parámetro indica registrar, se invoca `Purch.-Post (Yes/No)`.

Campos FacturaE añadidos a compras:

- `ID Plataforma FacturaE`;
- `Numero FacturaE`.

Estos campos permiten enlazar:

- factura recibida;
- factura de compra en curso;
- factura registrada;
- abono registrado.

---

## 11. Refactorización de dimensiones

Las funciones de dimensiones se mantienen conceptualmente:

- `ValidateShortcutDimCode()`;
- `CreateDim()`;
- `ShowDocDim()`;
- `PurchLinesExist()`;
- `UpdateAllLineDim()`.

La diferencia es que ahora se trabaja contra la tabla refactorizada `Linea FacturaE Recibida`, y la propagación de dimensiones queda centralizada en el codeunit de gestión.

Beneficio:

- se mantiene el comportamiento esperado por negocio;
- se reduce el acoplamiento de la tabla;
- se usa `DimensionManagement` con nombres modernos.

---

## 12. Refactorización de descripción de líneas

La tabla antigua leía descripciones desde XML usando Automation y recorridos DOM personalizados.

Ahora la descripción de cada línea se importa directamente desde:

```xml
Items / InvoiceLine / ItemDescription
```

y se guarda en `Linea FacturaE Recibida.Description`.

La lógica de partir texto largo se mantiene con `CortarLineas()` y `fCortarLineas()` para compatibilidad, pero el parser XML ya evita depender de DOM Automation.

---

## 13. Pantallas añadidas

### 13.1. `FacturasE Recibidas`

Página operativa para usuarios:

- ver facturas importadas;
- importar pendientes;
- importar XML manual;
- abrir configuración;
- abrir log;
- aprobar;
- rechazar;
- crear factura de compra;
- ver documento.

### 13.2. `FacturaE Import Setup`

Página para configurar el origen de importación.

### 13.3. `FacturaE Import Log`

Página para consultar trazabilidad de importaciones.

---

## 14. Mapa resumido de funciones antiguas

| Función antigua | Estado en refactor | Nuevo responsable |
|---|---|---|
| `fTraerBackup()` | Conservada como wrapper | `FacturaE Import Orchestrator` |
| `fTraerDatosRespaldo()` | Conservada como wrapper | `FacturaE Import Orchestrator` |
| `fTraerDatosRespaldoPaso1()` | Conservada como wrapper con confirmación | `FacturaE Import Orchestrator` |
| `fComprobarFacturaE()` | Modernizada | `FacturaE Recibida Mgt.` |
| `fAbrirDocumentoAlfresco()` | Simplificada SaaS-safe | `FacturaE Recibida Mgt.` |
| `fAbrirContenedorAlfresco()` | Simplificada SaaS-safe | `FacturaE Recibida Mgt.` |
| `ApproveEInvoice()` | Modernizada con enum/eventos | `FacturaE Recibida Mgt.` |
| `fRegistrar()` | Separada de tabla y genera compras | `FacturaE Recibida Mgt.` |
| `fCrearModificar()` | Absorbida por creación de líneas de compra | `FacturaE Recibida Mgt.` |
| `fRechazarFacturaEPaso1()` | Conservada con confirmación | `FacturaE Recibida Mgt.` |
| `fRechazarFacturaE()` | Modernizada | `FacturaE Recibida Mgt.` |
| `fVerFacturaE()` | Modernizada | `FacturaE Recibida Mgt.` |
| `fSiguienteEstadoFacturaE()` | Modernizada | `FacturaE Recibida Mgt.` |
| `fVolverARecibidaFacturaE()` | Modernizada | `FacturaE Recibida Mgt.` |
| `fPasarDescripciones()` | Sustituida por parser XML | `FacturaE XML Import` |
| `fLeerXMLDescripcion()` | Sustituida por `XmlDocument` | `FacturaE XML Import` |
| `fRecorrerXMLDescripcion()` | Sustituida por `XmlDocument` | `FacturaE XML Import` |
| `fCortarLineas()` | Conservada | tabla 50007 |
| `CreateDim()` | Conservada y modernizada | tabla 50007 + management |
| `ShowDocDim()` | Conservada y modernizada | tabla 50007 + management |
| `PurchLinesExist()` | Conservada | `FacturaE Recibida Mgt.` |
| `UpdateAllLineDim()` | Delegada | `FacturaE Recibida Mgt.` |

---

## 15. Beneficios para el cliente

1. **Compatible con Business Central SaaS**: no hay SQL directo, Automation ni rutas locales.
2. **Upgrade más seguro**: se conservan los nombres físicos legacy de campos y referencias para no romper sincronización ni objetos dependientes.
3. **Trazabilidad**: cada importación puede quedar registrada en log.
4. **Flexibilidad**: se puede importar manualmente o desde API.
5. **Menos riesgo**: la tabla deja de concentrar toda la lógica crítica.
6. **Mantenible**: cada responsabilidad está en un objeto específico.
7. **Extensible**: se pueden añadir integraciones mediante eventos o endpoint HTTP.
8. **Auditable**: se guarda el XML original en Business Central.
9. **Operativo para usuarios**: hay páginas para importar, configurar y revisar logs.

---

## 16. Consideraciones pendientes para implantación

Para cerrar el proyecto en un entorno real del cliente, habría que validar:

1. formato exacto de los XML FacturaE recibidos;
2. endpoint real si el cliente quiere importación automática;
3. autenticación del endpoint externo;
4. mapeo contable por línea (`Cuenta NAV`);
5. reglas de IVA/impuestos específicas;
6. circuito real de aprobaciones;
7. repositorio documental definitivo para PDF/XML adjuntos;
8. compilación contra símbolos reales de la versión Business Central objetivo.

La arquitectura ya deja preparados los puntos adecuados para esas adaptaciones sin volver al patrón monolítico de NAV 2016.
