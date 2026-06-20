page 50072 "Lista Factura Electrónica Rech"
{
    // ZAM0040 IAG 130521

    Caption = 'Lista Facturacion Electrónica Rechazada';
    CardPageID = "Cabecera FacturaE";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    UsageCategory = Administration;
    SourceTable = 50007;
    SourceTableView = SORTING("Fecha Importación", "Hora Importación")
                      ORDER(Descending)
                      WHERE(Rechazada = FILTER(Yes));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(ID_PLATAFORMA; Rec.ID_PLATAFORMA)
                {
                    ApplicationArea = All;
                }
                field(NUM; Rec.NUM)
                {
                    ApplicationArea = All;
                }
                field(SERIE; Rec.SERIE)
                {
                    ApplicationArea = All;
                }
                field(FECHA_ENTRADA; Rec.FECHA_ENTRADA)
                {
                    ApplicationArea = All;
                }
                field("Approval Status"; Rec."Approval Status")
                {
                    ApplicationArea = All;
                }
                field(FECHA_DEVENGO; Rec.FECHA_DEVENGO)
                {
                    ApplicationArea = All;
                }
                field(EMISOR_CIF; Rec.EMISOR_CIF)
                {
                    ApplicationArea = All;
                }
                field(EMISOR_NOMBRE; Rec.EMISOR_NOMBRE)
                {
                    ApplicationArea = All;
                }
                field(EMISOR_DIRECCION; Rec.EMISOR_DIRECCION)
                {
                    ApplicationArea = All;
                }
                field(EMISOR_CIUDAD; Rec.EMISOR_CIUDAD)
                {
                    ApplicationArea = All;
                }
                field(EMISOR_PROVINCIA; Rec.EMISOR_PROVINCIA)
                {
                    ApplicationArea = All;
                }
                field(EMISOR_CP; Rec.EMISOR_CP)
                {
                    ApplicationArea = All;
                }
                field(EMISOR_TELEFONO; Rec.EMISOR_TELEFONO)
                {
                    ApplicationArea = All;
                }
                field(EMISOR_EMAIL; Rec.EMISOR_EMAIL)
                {
                    ApplicationArea = All;
                }
                field(RECEPTOR_CIF; Rec.RECEPTOR_CIF)
                {
                    ApplicationArea = All;
                }
                field(FORMA_PAGO; Rec.FORMA_PAGO)
                {
                    ApplicationArea = All;
                }
                field(FECHA_PAGO; Rec.FECHA_PAGO)
                {
                    ApplicationArea = All;
                }
                field(CCC_PAGO; Rec.CCC_PAGO)
                {
                    ApplicationArea = All;
                }
                field(NOTAS; Rec.NOTAS)
                {
                    ApplicationArea = All;
                }
                field(CONTACTO_NOMBRE; Rec.CONTACTO_NOMBRE)
                {
                    ApplicationArea = All;
                }
                field(CONTACTO_TELEFONO; Rec.CONTACTO_TELEFONO)
                {
                    ApplicationArea = All;
                }
                field(CONTACTO_EMAIL; Rec.CONTACTO_EMAIL)
                {
                    ApplicationArea = All;
                }
                field(TOTAL_BASES; Rec.TOTAL_BASES)
                {
                    ApplicationArea = All;
                }
                field(TOTAL_TASAS; Rec.TOTAL_TASAS)
                {
                    ApplicationArea = All;
                }
                field(TOTAL_PAGAR; Rec.TOTAL_PAGAR)
                {
                    ApplicationArea = All;
                }
                field("Documento Registrado"; Rec."Documento Registrado")
                {
                    ApplicationArea = All;
                }
                field("Abono Registrado"; Rec."Abono Registrado")
                {
                    ApplicationArea = All;
                }
                field("Documento en Curso"; Rec."Documento en Curso")
                {
                    ApplicationArea = All;
                }
                field("Fecha Importación"; Rec."Fecha Importación")
                {
                    ApplicationArea = All;
                }
                field("Hora Importación"; Rec."Hora Importación")
                {
                    ApplicationArea = All;
                }
                field(EXPEDIENTE; Rec.EXPEDIENTE)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(DatosRespaldo)
            {
                ApplicationArea = All;
                Caption = 'Datos Respaldo';
                Image = TestDatabase;

                trigger OnAction()
                begin
                    fTraerDatosRespaldoPaso1();
                end;
            }
            action(ImportarFacturaE)
            {
                ApplicationArea = All;
                Caption = 'Importar FacturaE';
                Image = Import;
                RunObject = XMLport 50001;
                Visible = false;
            }
        }
        area(Promoted)
        {
            group(Category_Process)
            {
                Caption = 'Process';

                actionref(DatosRespaldo_Promoted; DatosRespaldo)
                {
                }
                actionref(ImportarFacturaE_Promoted; ImportarFacturaE)
                {
                }
            }
        }
    }

    var
        vText50001: Label '¿Desea rechazar esta factura?';
        vText50002: Label 'Proceso cancelado por el usuario.';
        vText50004: Label '¿ Desea enviar un correo de rechazo ?';
        SaaSUnsupportedFacturaERejectErr: Label 'El rechazo de FacturaE mediante Automation/COM SOAP legacy no es compatible con Business Central SaaS. Debe sustituirse por HttpClient y XmlDocument conservando el contrato funcional original.';

    procedure fRechazarFacturaE(pCabeceraFacturaERecibida: Record 50007)
    begin
        Error(SaaSUnsupportedFacturaERejectErr);
    end;
}