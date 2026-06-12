page 80001 "FacturaE Import Setup"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "FacturaE Import Setup";
    Caption = 'Configuración importación FacturaE';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field(Enabled; Rec.Enabled)
                {
                    ApplicationArea = All;
                }
                field("Source Type"; Rec."Source Type")
                {
                    ApplicationArea = All;
                }
                field("Pending Invoices URL"; Rec."Pending Invoices URL")
                {
                    ApplicationArea = All;
                }
                field("Mark Processed URL"; Rec."Mark Processed URL")
                {
                    ApplicationArea = All;
                    ToolTip = 'URL opcional para marcar una factura externa como procesada. Use %1 como marcador del identificador externo.';
                }
                field("Last Run DateTime"; Rec."Last Run DateTime")
                {
                    ApplicationArea = All;
                }
                field("Last Imported Count"; Rec."Last Imported Count")
                {
                    ApplicationArea = All;
                }
                field("Last Error"; Rec."Last Error")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.GetOrCreate();
    end;
}
