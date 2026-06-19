page 50031 "proceso de factura"
{
    RefreshOnActivate = true;
    SourceTable = 2000000026;
    SourceTableView = SORTING (Number)
                      WHERE (Number = CONST (1));

    layout
    {
        area(content)
        {
            field(VFactura; VFactura)
            {
                ApplicationArea = All;
            }
            field(VQR; VQR)
            {
                ApplicationArea = All;
            }
            field(VURL; VURL)
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
                Promoted = true;

                trigger OnAction()
                begin
                    C50005.RegistroFacturaAdos(VFactura, VQR, VURL);
                end;
            }
        }
    }

    var
        C50005: Codeunit 50005;
        VFactura: Code[20];
        VQR: Text[100];
        VURL: Text[250];
}

