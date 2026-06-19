page 50018 "Lineas factura sin registrar"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    UsageCategory = Administration;
    SourceTable = "Sales Line";
    SourceTableView = WHERE (Document Type=FILTER(Invoice));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Posting Date";"Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Document No.";"Document No.")
                {
                    ApplicationArea = All;
                }
                field("Sell-to Customer No.";"Sell-to Customer No.")
                {
                    ApplicationArea = All;
                }
                field(Type;Type)
                {
                    ApplicationArea = All;
                }
                field("No.";"No.")
                {
                    ApplicationArea = All;
                }
                field(Description;Description)
                {
                    ApplicationArea = All;
                }
                field(Quantity;Quantity)
                {
                    ApplicationArea = All;
                }
                field("Unit Price";"Unit Price")
                {
                    ApplicationArea = All;
                }
                field("Unit Cost (LCY)";"Unit Cost (LCY)")
                {
                }
                field("VAT %";"VAT %")
                {
                    ApplicationArea = All;
                }
                field("Line Discount %";"Line Discount %")
                {
                    ApplicationArea = All;
                }
                field("Line Discount Amount";"Line Discount Amount")
                {
                    ApplicationArea = All;
                }
                field(Amount;Amount)
                {
                    ApplicationArea = All;
                }
                field("Amount Including VAT";"Amount Including VAT")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 1 Code";"Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 2 Code";"Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
                field("Customer Price Group";"Customer Price Group")
                {
                    ApplicationArea = All;
                }
                field("Gen. Bus. Posting Group";"Gen. Bus. Posting Group")
                {
                    ApplicationArea = All;
                }
                field("Gen. Prod. Posting Group";"Gen. Prod. Posting Group")
                {
                    ApplicationArea = All;
                }
                field("VAT Base Amount";"VAT Base Amount")
                {
                    ApplicationArea = All;
                }
                field("Unit Cost";"Unit Cost")
                {
                    ApplicationArea = All;
                }
                field("Line Amount";"Line Amount")
                {
                    ApplicationArea = All;
                }
                field("VAT Difference";"VAT Difference")
                {
                    ApplicationArea = All;
                }
                field("VAT Identifier";"VAT Identifier")
                {
                    ApplicationArea = All;
                }
                field("No. contador";"No. contador")
                {
                    ApplicationArea = All;
                }
                field(Coeficiente;Coeficiente)
                {
                    ApplicationArea = All;
                }
                field(Tarifa;Tarifa)
                {
                    ApplicationArea = All;
                }
                field(Condensador;Condensador)
                {
                    ApplicationArea = All;
                }
                field("Fecha inicio servicio";"Fecha inicio servicio")
                {
                    ApplicationArea = All;
                }
                field("Fecha fin servicio";"Fecha fin servicio")
                {
                    ApplicationArea = All;
                }
                field("Nombre Cliente";"Nombre Cliente")
                {
                    ApplicationArea = All;
                }
                field("Fecha lectura";"Fecha lectura")
                {
                    ApplicationArea = All;
                }
                field("Lectura anterior";"Lectura anterior")
                {
                    ApplicationArea = All;
                }
                field("Lectura actual";"Lectura actual")
                {
                    ApplicationArea = All;
                }
                field("Lecturas facturadas";"Lecturas facturadas")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

