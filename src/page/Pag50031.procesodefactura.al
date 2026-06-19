page 50031 "proceso de factura"
{
    RefreshOnActivate = true;
    SourceTable = 2000000026;
    SourceTableView = SORTING(Number)
                      WHERE(Number = CONST(1));

    layout
    {
        area(content)
        {
            field(VFactura; Rec.VFactura)
            {
                ApplicationArea = All;
            }
            field(VQR; Rec.VQR)
            {
                ApplicationArea = All;
            }
            field(VURL; Rec.VURL)
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Procesar)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin
                    C50005.RegistroFacturaAdos(VFactura, VQR, VURL);
                end;
            }
        }
        area(Promoted)
        {
            group(Category_Process)
            {
                Caption = 'Process';

                actionref(Procesar_Promoted; Procesar)
                {
                }
            }
        }
    }

    var
        C50005: Codeunit 50005;
        VFactura: Code[20];
        VQR: Text[100];
        VURL: Text[250];
}