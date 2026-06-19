page 50027 "Codigos de retencion"
{
    // Mod. S2G (JOA) 20-12-11: CO.02 Registro de retenciones.

    Caption = 'Códigos de retención';
    PageType = List;
    SourceTable = Table50012;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Cod. Retencion"; "Cod. Retencion")
                {
                }
                field("Tipo tercero"; "Tipo tercero")
                {
                }
                field("Tipo Retencion"; "Tipo Retencion")
                {
                }
                field(Descripcion; Descripcion)
                {
                }
                field("% Retencion"; "% Retencion")
                {
                }
                field("% retencion libre"; "% retencion libre")
                {
                }
                field("Cuenta contable"; "Cuenta contable")
                {
                }
            }
        }
        area(factboxes)
        {
            systempart(; Links)
            {
                Visible = false;
            }
            systempart(; Notes)
            {
                Visible = false;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(History)
            {
                Caption = 'History';
                Image = History;
                action(LedgerEntries)
                {
                    Caption = 'Ledger E&ntries';
                    Image = CustomerLedger;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page 50002;
                    RunPageLink = Field2 = FIELD (Cod. Retencion),
                                  Field13=FIELD(Tipo tercero);
                    RunPageView = SORTING(Field2);
                    ShortCutKey = 'Ctrl+F7';
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        CurrPage.EDITABLE(CurrPage.LOOKUPMODE = FALSE);
    end;
}

