# BC SaaS Migration Guide

## Principio general

La migración debe ser conservadora: no se rediseña la lógica de negocio salvo que el patrón legacy sea incompatible con Business Central SaaS.

## Reglas obligatorias

### 1. No eliminar funcionalidad sin decisión documentada

Antes de eliminar código activo hay que clasificarlo como:

- sustituido por API SaaS equivalente,
- bloqueado con error controlado,
- pendiente de rediseño funcional,
- obsoleto y sin uso confirmado.

### 2. Automation / COM

No es compatible con Business Central SaaS.

Ejemplos no válidos:

- `Automation`
- `CREATE(Automation)`
- `ISCLEAR`
- `Shell.Application`
- `BrowseForFolder`
- XML DOM COM
- ADO/SQL COM

Sustituciones posibles según caso:

- `XmlDocument`, `XmlNode`, `XmlNodeList`
- `HttpClient`, `HttpRequestMessage`, `HttpResponseMessage`
- `UploadIntoStream` / `DownloadFromStream`
- `Temp Blob`
- APIs externas vía OAuth2 / Entra ID
- integración documental SharePoint/OneDrive/API

### 3. Referencias numéricas

Sustituir cuando el objeto está identificado:

```al
Page.Run(Page::"Sales Order", SalesHeader);
RunObject = Page "Sales Quotes";
part(Lotes; "Lista Lotes")
```

No sustituir a ciegas referencias custom 50000/90000 si el nombre no está identificado con seguridad.

### 4. Acceso a campos

En pages usar `Rec.` de forma explícita en triggers y procedimientos cuando se accede al registro fuente.

Ejemplo:

```al
Rec.Validate(Estado, Rec.Estado::"Adj.Provisional");
Rec.CalcFields(Prórroga);
```

### 5. CurrPage

Normalizar casing y llamadas:

```al
CurrPage.Update();
CurrPage.SetSelectionFilter(MyRecord);
CurrPage.SaveRecord();
CurrPage.Close();
```

### 6. systempart / part

Evitar controles anónimos:

```al
systempart(Links; Links)
{
    ApplicationArea = All;
}
```

### 7. Promoted actions

Las propiedades legacy siguientes no deben quedar en pages modernizadas porque el analyzer objetivo las marca como obsoletas:

```al
Promoted = true;
PromotedCategory = Category4;
PromotedIsBig = true;
```

El patrón obligatorio es mover la promoción al área `Promoted` mediante `actionref`:

```al
actions
{
    area(processing)
    {
        action(MyAction)
        {
            ApplicationArea = All;
            Caption = 'My Action';
            Image = Process;
        }
    }

    area(Promoted)
    {
        group(Category_Process)
        {
            Caption = 'Process';

            actionref(MyAction_Promoted; MyAction)
            {
            }
        }
    }
}
```

## Checklist de revisión de cada page

- [ ] `Automation` / COM eliminado o documentado.
- [ ] `DotNet` eliminado o documentado.
- [ ] `PAGE.RUN` / `PAGE.RUNMODAL` revisado.
- [ ] `RunObject = Page <id>` revisado.
- [ ] `part(...; <id>)` revisado.
- [ ] `systempart(; ...)` corregido.
- [ ] `Rec.` normalizado en triggers.
- [ ] `CurrPage` normalizado.
- [ ] `Promoted`, `PromotedCategory` y `PromotedIsBig` sustituidos por `actionref`.
- [ ] `ApplicationArea` presente en controles nuevos o modificados.
- [ ] Documentación actualizada en el PR.
- [ ] Compilación AL-Go pendiente o validada.
