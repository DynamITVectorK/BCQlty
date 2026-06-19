page 50018 "Lineas factura sin registrar"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = Table37;
    SourceTableView = WHERE (Document Type=FILTER(Invoice));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Posting Date";"Posting Date")
                {
                }
                field("Document No.";"Document No.")
                {
                }
                field("Sell-to Customer No.";"Sell-to Customer No.")
                {
                }
                field(Type;Type)
                {
                }
                field("No.";"No.")
                {
                }
                field(Description;Description)
                {
                }
                field(Quantity;Quantity)
                {
                }
                field("Unit Price";"Unit Price")
                {
                }
                field("Unit Cost (LCY)";"Unit Cost (LCY)")
                {
                }
                field("VAT %";"VAT %")
                {
                }
                field("Line Discount %";"Line Discount %")
                {
                }
                field("Line Discount Amount";"Line Discount Amount")
                {
                }
                field(Amount;Amount)
                {
                }
                field("Amount Including VAT";"Amount Including VAT")
                {
                }
                field("Shortcut Dimension 1 Code";"Shortcut Dimension 1 Code")
                {
                }
                field("Shortcut Dimension 2 Code";"Shortcut Dimension 2 Code")
                {
                }
                field("Customer Price Group";"Customer Price Group")
                {
                }
                field("Gen. Bus. Posting Group";"Gen. Bus. Posting Group")
                {
                }
                field("Gen. Prod. Posting Group";"Gen. Prod. Posting Group")
                {
                }
                field("VAT Base Amount";"VAT Base Amount")
                {
                }
                field("Unit Cost";"Unit Cost")
                {
                }
                field("Line Amount";"Line Amount")
                {
                }
                field("VAT Difference";"VAT Difference")
                {
                }
                field("VAT Identifier";"VAT Identifier")
                {
                }
                field("No. contador";"No. contador")
                {
                }
                field(Coeficiente;Coeficiente)
                {
                }
                field(Tarifa;Tarifa)
                {
                }
                field(Condensador;Condensador)
                {
                }
                field("Fecha inicio servicio";"Fecha inicio servicio")
                {
                }
                field("Fecha fin servicio";"Fecha fin servicio")
                {
                }
                field("Nombre Cliente";"Nombre Cliente")
                {
                }
                field("Fecha lectura";"Fecha lectura")
                {
                }
                field("Lectura anterior";"Lectura anterior")
                {
                }
                field("Lectura actual";"Lectura actual")
                {
                }
                field("Lecturas facturadas";"Lecturas facturadas")
                {
                }
            }
        }
    }

    actions
    {
    }
}

