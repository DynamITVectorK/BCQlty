page 50027 "Codigos de retencion"
{
    // Mod. S2G (JOA) 20-12-11: CO.02 Registro de retenciones.

    Caption = 'Códigos de retención';
    PageType = List;
    UsageCategory = Administration;
    SourceTable = 50012;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Cod. Retencion"; Rec."Cod. Retencion")
                {
                    ApplicationArea = All;
                }
                field("Tipo tercero"; Rec."Tipo tercero")
                {
                    ApplicationArea = All;
                }
                field("Tipo Retencion"; Rec."Tipo Retencion")
                {
                    ApplicationArea = All;
                }
                field(Descripcion; Rec.Descripcion)
                {
                    ApplicationArea = All;
                }
                field("% Retencion"; Rec."% Retencion")
                {
                    ApplicationArea = All;
                }
                field("% retencion libre"; Rec."% retencion libre")
                {
                    ApplicationArea = All;
                }
                field("Cuenta contable"; Rec."Cuenta contable")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
            systempart(Links; Links)
            {
                ApplicationArea = All;
                Visible = false;
            }
            systempart(Notes; Notes)
            {
                ApplicationArea = All;
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
                    ApplicationArea = All;
                    Caption = 'Ledger E&ntries';
                    Image = CustomerLedger;
                    Promoted = true;
                    PromotedCategory = Process;
                    // TODO SaaS: revisar Page 50002 antes de sustituir por nombre; el RunPageLink usa campos genéricos Field2/Field13 y no coincide con la page custom identificada en el repo.
                    RunObject = Page 50002;
                    RunPageLink = Field2 = FIELD("Cod. Retencion"),
                                  Field13 = FIELD("Tipo tercero");
                    RunPageView = SORTING(Field2);
                    ShortCutKey = 'Ctrl+F7';
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        CurrPage.Editable(CurrPage.LookupMode = false);
    end;
}