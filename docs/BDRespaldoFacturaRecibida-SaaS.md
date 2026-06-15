# Refactorización SaaS de BD Respaldo Factura Recibida

## Equivalencias legacy → SaaS

- `fProcesarLineas`: conserva el filtro por `Pendiente|Con Errores`, recupera cada registro por `ID Factura`, adapta el BLOB original en memoria, ejecuta el XMLport de importación y solo marca `Importado` después de finalizar el XMLport sin error.
- `fLeerXML`: el procesamiento por fichero físico se sustituye por lectura/escritura de BLOB con `InStream`/`OutStream` y `XmlDocument`. La firma legacy queda como wrapper de compatibilidad y rechaza rutas de fichero porque no son válidas en SaaS.
- `fRecorrerXML`: la recursividad sobre DOM Automation se sustituye por `XmlNodeList`/`XmlNode` nativos de AL.
- `fSetClientFileName`: se conserva como compatibilidad legacy, sin provocar operaciones de fichero.

## Nota técnica sobre recorte legacy

La regla NAV `replaceData(1, 8000, substringData(1, 250))` no equivale a `CopyStr(Value, 1, 250)`. Con offsets DOM legacy, conserva el primer carácter y reemplaza desde el segundo con un máximo de 250 caracteres desde esa posición; para texto plano normal, el máximo efectivo resultante es 251 caracteres.

## Checklist de validación

- Eliminadas variables `Automation` de `Tab50010.BDRespaldoFacturaRecibida.al`.
- Eliminado uso de `File`, rutas temporales, `ServerTempFileName`, `DownloadTempFile`, `UploadFileSilent`, `Blob.EXPORT` y `Blob.IMPORT` del flujo refactorizado.
- Conservados campos originales y clave `ID Factura`.
- Conservada la importación mediante XMLport existente `50002`; el repositorio actual no incluye la definición del XMLport, por lo que su nombre real no puede confirmarse en esta rama.
