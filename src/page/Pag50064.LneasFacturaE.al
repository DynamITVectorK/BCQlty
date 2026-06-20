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
    SourceTable = 50008;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("ID Factura"; Rec."ID Factura")
                {
                    ApplicationArea = All;
                    Editable = "ID FacturaEditable";
                }
                field("Cuenta NAV"; Rec."Cuenta NAV")
                {
                    ApplicationArea = All;
                    Editable = "Cuenta NAVEditable";
                }
                field("Cod Activo"; Rec."Cod Activo")
                {
                    ApplicationArea = All;
                    Editable = "Cod ActivoEditable";

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        //I00109 Mod. S2G (JSM) 22-10-14: Permitir creación de líneas de activo fijo en Factura Elec.
                        Clear(rFAPostingGroup);
                        rFAPostingGroup.SetRange("Acquisition Cost Account", Rec."Cuenta NAV");
                        if rFAPostingGroup.FindFirst() then begin
                            Clear(fFA);
                            fFA.SetTableView(rFA);
                            fFA.SetRecord(rFA);
                            fFA.LookupMode(true);
                            fFA.Editable(false);
                            if fFA.RunModal() = Action::LookupOK then begin
                                fFA.GetRecord(rFA);
                                Rec.Validate("Cod Activo", rFA."No.");
                            end;
                        end else
                            Message(StrSubstNo(Text50000, Rec."Cuenta NAV"));
                        //I00109 Mod. S2G (JSM) 22-10-14:
                    end;
                }
                field(CODIGO; Rec.CODIGO)
                {
                    ApplicationArea = All;
                    Editable = CODIGOEditable;
                }
                field(DESCRIPCION; Rec.DESCRIPCION)
                {
                    ApplicationArea = All;
                    Editable = DESCRIPCIONEditable;
                }
                field(CANTIDAD; Rec.CANTIDAD)
                {
                    ApplicationArea = All;
                    Editable = CANTIDADEditable;
                }
                field(PRECIO; Rec.PRECIO)
                {
                    ApplicationArea = All;
                    Editable = PRECIOEditable;
                }
                field(Importe; Rec.Importe)
                {
                    ApplicationArea = All;
                }
                field(DESCUENTO; Rec.DESCUENTO)
                {
                    ApplicationArea = All;
                    Editable = DESCUENTOEditable;
                }
                field(Tasas; Rec.Tasas)
                {
                    ApplicationArea = All;
                }
                field("Amount Including VAT"; Rec."Amount Including VAT")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Código IVA NAV"; Rec."Código IVA NAV")
                {
                    ApplicationArea = All;
                }
                field(Retenciones; Rec.Retenciones)
                {
                    ApplicationArea = All;
                    Editable = RetencionesEditable;
                }
                field("Código IRPF NAV"; Rec."Código IRPF NAV")
                {
                    ApplicationArea = All;
                }
                field(EXPEDIENTE; Rec.EXPEDIENTE)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Lote; Rec.Lote)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("REFERENCIA DEL EMISOR"; Rec."REFERENCIA DEL EMISOR")
                {
                    ApplicationArea = All;
                    Editable = "REFERENCIA DEL EMISOREditable";
                }
                field("REFERENCIA DEL RECEPTOR"; Rec."REFERENCIA DEL RECEPTOR")
                {
                    ApplicationArea = All;
                    Editable = REFERENCIADELRECEPTOREditable;
                }
                field("Pedido NAV"; Rec."Pedido NAV")
                {
                    ApplicationArea = All;
                    Editable = "Pedido NAVEditable";
                    Visible = false;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
                field("Dimension Set ID"; Rec."Dimension Set ID")
                {
                    ApplicationArea = All;
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
        "Cod ActivoEditable" := true;
        "Pedido NAVEditable" := true;
        "Cuenta NAVEditable" := true;
        REFERENCIADELRECEPTOREditable := true;
        "REFERENCIA DEL EMISOREditable" := true;
        EXPEDIENTEEditable := true;
        //RetencionesEditable := true;
        RetencionesEditable := false;
        TasasEditable := true;
        DESCUENTOEditable := true;
        PRECIOEditable := true;
        CANTIDADEditable := true;
        DESCRIPCIONEditable := true;
        CODIGOEditable := true;
        "ID FacturaEditable" := true;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var
        TasasYRetenciones: Record 50009;
    begin
        //>Z004      CIMUBISA-08 JLF 2018.03.23 Gestión de FacturaE
        GLSetup.FindFirst();
        Clear(TasasYRetenciones);
        TasasYRetenciones.Init();
        TasasYRetenciones."ID Factura" := Rec."ID Factura";
        TasasYRetenciones.Linea := Rec.Linea;
        TasasYRetenciones.CODIGO := Rec.CODIGO;
        TasasYRetenciones.CONCEPTO := Rec.DESCRIPCION;
        TasasYRetenciones.TASA := GLSetup."Porcentaje IVA Necesidad";
        TasasYRetenciones."Código IVA NAV" := Rec."Código IVA NAV";
        TasasYRetenciones."Código IRPF NAV" := Rec."Código IRPF NAV";
        TasasYRetenciones.Insert();
        //<Z004      CIMUBISA-08 JLF 2018.03.23 Gestión de FacturaE
    end;

    trigger OnOpenPage()
    begin
        //>Z004      CIMUBISA-08 JLF 2018.03.23 Gestión de FacturaE
        //fEditables;
        //<Z004      CIMUBISA-08 JLF 2018.03.23 Gestión de FacturaE
    end;

    var
        rCabeceraFacturaERecibida: Record 50007;
        rCabeceraContratacion: Record 50002;
        rVendor: Record "Vendor";
        rFAPostingGroup: Record "FA Posting Group";
        rFA: Record "Fixed Asset";
        Text50000: Label 'Sólo se puede seleccionar un activo fijo si la Cuenta NAV %1 está asignada como Cta. Coste en algún Grupo Contable de activo fijo.';
        fFA: Page "Fixed Asset List";
        "ID FacturaEditable": Boolean;
        CODIGOEditable: Boolean;
        DESCRIPCIONEditable: Boolean;
        CANTIDADEditable: Boolean;
        PRECIOEditable: Boolean;
        DESCUENTOEditable: Boolean;
        TasasEditable: Boolean;
        RetencionesEditable: Boolean;
        EXPEDIENTEEditable: Boolean;
        "REFERENCIA DEL EMISOREditable": Boolean;
        REFERENCIADELRECEPTOREditable: Boolean;
        "Cuenta NAVEditable": Boolean;
        "Pedido NAVEditable": Boolean;
        "Cod ActivoEditable": Boolean;
        GLSetup: Record "General Ledger Setup";

    procedure fEditables()
    begin
        "ID FacturaEditable" := false;
        //CurrForm.Linea.EDITABLE(FALSE);
        CODIGOEditable := false;
        DESCRIPCIONEditable := false;
        CANTIDADEditable := false;
        PRECIOEditable := false;
        DESCUENTOEditable := false;
        TasasEditable := false;
        RetencionesEditable := false;
        EXPEDIENTEEditable := false;
        "REFERENCIA DEL EMISOREditable" := false;
        REFERENCIADELRECEPTOREditable := false;

        "Cuenta NAVEditable" := true;
        "Pedido NAVEditable" := true;

        //I00109 Mod. S2G (JSM) 22-10-14: Permitir creación de líneas de activo fijo en Factura Elec.
        "Cod ActivoEditable" := true;
        //I00109 Mod. S2G (JSM) 22-10-14: Fin.
    end;
}