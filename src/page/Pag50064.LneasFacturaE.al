page 50064 "Líneas FacturaE"
{
    // I00109 Mod. S2G (JSM) 22-10-14: Permitir creación de líneas de activo fijo en Factura Elec.
    // I00279 Mod. S2G (MGL) 08-11-16: Recodificar formularios para que entren en licencia
    // 
    // Mod   Nr  Task        Dev Date       Comments
    // ====================================================================================================================================
    // Z004      CIMUBISA-08 IPP 2018.01.26 Gestión de FacturaE
    //   Show fields
    //     50010Purchase Need No.Code
    //     50011Purchase Need Line No.
    //     50012Shortcut Dimension 1 Code
    //     50013Shortcut Dimension 2 Code
    //     50014Dimension Set ID

    AutoSplitKey = true;
    ModifyAllowed = true;
    PageType = ListPart;
    SourceTable = Table50008;

    layout
    {
        area(content)
        {
            repeater()
            {
                field("ID Factura"; "ID Factura")
                {
                    Editable = "ID FacturaEditable";
                }
                field("Cuenta NAV"; "Cuenta NAV")
                {
                    Editable = "Cuenta NAVEditable";
                }
                field("Cod Activo"; "Cod Activo")
                {
                    Editable = "Cod ActivoEditable";

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        //I00109 Mod. S2G (JSM) 22-10-14: Permitir creación de líneas de activo fijo en Factura Elec.
                        CLEAR(rFAPostingGroup);
                        rFAPostingGroup.SETRANGE("Acquisition Cost Account", "Cuenta NAV");
                        IF rFAPostingGroup.FINDFIRST THEN BEGIN
                            CLEAR(fFA);
                            fFA.SETTABLEVIEW(rFA);
                            fFA.SETRECORD(rFA);
                            fFA.LOOKUPMODE(TRUE);
                            fFA.EDITABLE(FALSE);
                            IF fFA.RUNMODAL = ACTION::LookupOK THEN BEGIN
                                fFA.GETRECORD(rFA);
                                VALIDATE("Cod Activo", rFA."No.");
                            END;
                        END
                        ELSE
                            MESSAGE(STRSUBSTNO(Text50000, "Cuenta NAV"));
                        //I00109 Mod. S2G (JSM) 22-10-14:
                    end;
                }
                field(CODIGO; CODIGO)
                {
                    Editable = CODIGOEditable;
                }
                field(DESCRIPCION; DESCRIPCION)
                {
                    Editable = DESCRIPCIONEditable;
                }
                field(CANTIDAD; CANTIDAD)
                {
                    Editable = CANTIDADEditable;
                }
                field(PRECIO; PRECIO)
                {
                    Editable = PRECIOEditable;
                }
                field(Importe; Importe)
                {
                }
                field(DESCUENTO; DESCUENTO)
                {
                    Editable = DESCUENTOEditable;
                }
                field(Tasas; Tasas)
                {
                }
                field("Amount Including VAT"; "Amount Including VAT")
                {
                    Editable = true;
                }
                field("Código IVA NAV"; "Código IVA NAV")
                {
                }
                field(Retenciones; Retenciones)
                {
                    Editable = RetencionesEditable;
                }
                field("Código IRPF NAV"; "Código IRPF NAV")
                {
                }
                field(EXPEDIENTE; EXPEDIENTE)
                {
                    Editable = false;
                }
                field(Lote; Lote)
                {
                    Editable = false;
                }
                field("REFERENCIA DEL EMISOR"; "REFERENCIA DEL EMISOR")
                {
                    Editable = "REFERENCIA DEL EMISOREditable";
                }
                field("REFERENCIA DEL RECEPTOR"; "REFERENCIA DEL RECEPTOR")
                {
                    Editable = REFERENCIADELRECEPTOREditable;
                }
                field("Pedido NAV"; "Pedido NAV")
                {
                    Editable = "Pedido NAVEditable";
                    Visible = false;
                }
                field("Shortcut Dimension 1 Code"; "Shortcut Dimension 1 Code")
                {
                }
                field("Shortcut Dimension 2 Code"; "Shortcut Dimension 2 Code")
                {
                }
                field("Dimension Set ID"; "Dimension Set ID")
                {
                    Visible = false;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnInit()
    begin
        "Cod ActivoEditable" := TRUE;
        "Pedido NAVEditable" := TRUE;
        "Cuenta NAVEditable" := TRUE;
        REFERENCIADELRECEPTOREditable := TRUE;
        "REFERENCIA DEL EMISOREditable" := TRUE;
        EXPEDIENTEEditable := TRUE;
        //RetencionesEditable := TRUE;
        RetencionesEditable := FALSE;
        TasasEditable := TRUE;
        DESCUENTOEditable := TRUE;
        PRECIOEditable := TRUE;
        CANTIDADEditable := TRUE;
        DESCRIPCIONEditable := TRUE;
        CODIGOEditable := TRUE;
        "ID FacturaEditable" := TRUE;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var
        TasasYRetenciones: Record "50009";
    begin
        //>Z004      CIMUBISA-08 JLF 2018.03.23 Gestión de FacturaE
        GLSetup.FINDFIRST;
        CLEAR(TasasYRetenciones);
        TasasYRetenciones.INIT;
        TasasYRetenciones."ID Factura" := "ID Factura";
        TasasYRetenciones.Linea := Linea;
        TasasYRetenciones.CODIGO := CODIGO;
        TasasYRetenciones.CONCEPTO := DESCRIPCION;
        TasasYRetenciones.TASA := GLSetup."Porcentaje IVA Necesidad";
        TasasYRetenciones."Código IVA NAV" := "Código IVA NAV";
        TasasYRetenciones."Código IRPF NAV" := "Código IRPF NAV";
        TasasYRetenciones.INSERT;
        //<Z004      CIMUBISA-08 JLF 2018.03.23 Gestión de FacturaE
    end;

    trigger OnOpenPage()
    begin
        //>Z004      CIMUBISA-08 JLF 2018.03.23 Gestión de FacturaE
        //fEditables;
        //<Z004      CIMUBISA-08 JLF 2018.03.23 Gestión de FacturaE
    end;

    var
        rCabeceraFacturaERecibida: Record "50007";
        rCabeceraContratacion: Record "50002";
        rVendor: Record "23";
        rFAPostingGroup: Record "5606";
        rFA: Record "5600";
        Text50000: Label 'Sólo se puede seleccionar un activo fijo si la Cuenta NAV %1 está asignada como Cta. Coste en algún Grupo Contable de activo fijo.';
        fFA: Page "5601";
        [InDataSet]
        "ID FacturaEditable": Boolean;
        [InDataSet]
        CODIGOEditable: Boolean;
        [InDataSet]
        DESCRIPCIONEditable: Boolean;
        [InDataSet]
        CANTIDADEditable: Boolean;
        [InDataSet]
        PRECIOEditable: Boolean;
        [InDataSet]
        DESCUENTOEditable: Boolean;
        [InDataSet]
        TasasEditable: Boolean;
        [InDataSet]
        RetencionesEditable: Boolean;
        [InDataSet]
        EXPEDIENTEEditable: Boolean;
        [InDataSet]
        "REFERENCIA DEL EMISOREditable": Boolean;
        [InDataSet]
        REFERENCIADELRECEPTOREditable: Boolean;
        [InDataSet]
        "Cuenta NAVEditable": Boolean;
        [InDataSet]
        "Pedido NAVEditable": Boolean;
        [InDataSet]
        "Cod ActivoEditable": Boolean;
        GLSetup: Record "98";

    [Scope('Internal')]
    procedure fEditables()
    begin
        "ID FacturaEditable" := FALSE;
        //CurrForm.Linea.EDITABLE(FALSE);
        CODIGOEditable := FALSE;
        DESCRIPCIONEditable := FALSE;
        CANTIDADEditable := FALSE;
        PRECIOEditable := FALSE;
        DESCUENTOEditable := FALSE;
        TasasEditable := FALSE;
        RetencionesEditable := FALSE;
        EXPEDIENTEEditable := FALSE;
        "REFERENCIA DEL EMISOREditable" := FALSE;
        REFERENCIADELRECEPTOREditable := FALSE;

        "Cuenta NAVEditable" := TRUE;
        "Pedido NAVEditable" := TRUE;

        //I00109 Mod. S2G (JSM) 22-10-14: Permitir creación de líneas de activo fijo en Factura Elec.
        "Cod ActivoEditable" := TRUE;
        //I00109 Mod. S2G (JSM) 22-10-14: Fin.
    end;
}

