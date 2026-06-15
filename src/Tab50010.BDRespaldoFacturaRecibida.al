table 50010 "BD Respaldo Factura Recibida"
{
    // I00298 Mod. S2G (JMG) 04-01-17: Ampliar el número de caracteres reemplazados.

    fields
    {
        field(1; "ID Factura"; Text[30])
        {
        }
        field(2; Estado; Text[30])
        {
        }
        field(3; "Datos XML Original"; BLOB)
        {
        }
        field(4; "Estado Navision"; Option)
        {
            OptionMembers = Pendiente,Importado,"Con Errores";
        }
        field(5; "Datos XML Adaptado"; BLOB)
        {
        }
    }

    keys
    {
        key(Key1; "ID Factura")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        RespaldoFacturaRecMgt: Codeunit "BD Respaldo Factura Rec. Mgt.";
        vClientFileName: Text;

    internal procedure fProcesarLineas()
    begin
        RespaldoFacturaRecMgt.fProcesarLineas();
    end;

    internal procedure fLeerXML(pDirectorio: Text[250]; pRaiz: Text[250]; pElemento: Text[250])
    begin
        RespaldoFacturaRecMgt.fLeerXML(pDirectorio, pRaiz, pElemento);
    end;

    internal procedure fRecorrerXML(pElemento: Text[250]; pXMLNodeList: XmlNodeList; pElementomodificar: Text[30])
    begin
        RespaldoFacturaRecMgt.fRecorrerXML(pElemento, pXMLNodeList, pElementomodificar);
    end;

    internal procedure fSetClientFileName(pClientFileName: Text)
    begin
        //***BGS 02/05/19: Inicio
        vClientFileName := pClientFileName;
        RespaldoFacturaRecMgt.fSetClientFileName(pClientFileName);
        //***BGS 02/05/19: Fin
    end;
}
