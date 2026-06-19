page 50013 "Lineas de venta"
{
    DelayedInsert = false;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    UsageCategory = Administration;
    SourceTable = "Sales Line";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document Type"; "Document Type")
                {
                    ApplicationArea = All;
                }
                field("Sell-to Customer No."; "Sell-to Customer No.")
                {
                    ApplicationArea = All;
                }
                field("Document No."; "Document No.")
                {
                    ApplicationArea = All;
                }
                field("Line No."; "Line No.")
                {
                    ApplicationArea = All;
                }
                field(Type; Type)
                {
                    ApplicationArea = All;
                }
                field("No."; "No.")
                {
                    ApplicationArea = All;
                }
                field("Location Code"; "Location Code")
                {
                    ApplicationArea = All;
                }
                field("Posting Group"; "Posting Group")
                {
                    ApplicationArea = All;
                }
                field("Shipment Date"; "Shipment Date")
                {
                    ApplicationArea = All;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                }
                field("Description 2"; "Description 2")
                {
                    ApplicationArea = All;
                }
                field("Unit of Measure"; "Unit of Measure")
                {
                    ApplicationArea = All;
                }
                field(Quantity; Quantity)
                {
                    ApplicationArea = All;
                }
                field("Outstanding Quantity"; "Outstanding Quantity")
                {
                    ApplicationArea = All;
                }
                field("Qty. to Invoice"; "Qty. to Invoice")
                {
                    ApplicationArea = All;
                }
                field("Qty. to Ship"; "Qty. to Ship")
                {
                    ApplicationArea = All;
                }
                field("Unit Price"; "Unit Price")
                {
                    ApplicationArea = All;
                }
                field("Unit Cost (LCY)"; "Unit Cost (LCY)")
                {
                }
                field("VAT %"; "VAT %")
                {
                    ApplicationArea = All;
                }
                field("Line Discount %"; "Line Discount %")
                {
                    ApplicationArea = All;
                }
                field("Line Discount Amount"; "Line Discount Amount")
                {
                    ApplicationArea = All;
                }
                field(Amount; Amount)
                {
                    ApplicationArea = All;
                }
                field("Amount Including VAT"; "Amount Including VAT")
                {
                    ApplicationArea = All;
                }
                field("Allow Invoice Disc."; "Allow Invoice Disc.")
                {
                    ApplicationArea = All;
                }
                field("Gross Weight"; "Gross Weight")
                {
                    ApplicationArea = All;
                }
                field("Net Weight"; "Net Weight")
                {
                    ApplicationArea = All;
                }
                field("Units per Parcel"; "Units per Parcel")
                {
                    ApplicationArea = All;
                }
                field("Unit Volume"; "Unit Volume")
                {
                    ApplicationArea = All;
                }
                field("Appl.-to Item Entry"; "Appl.-to Item Entry")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 1 Code"; "Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 2 Code"; "Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
                field("Customer Price Group"; "Customer Price Group")
                {
                    ApplicationArea = All;
                }
                field("Job No."; "Job No.")
                {
                    ApplicationArea = All;
                }
                field("Work Type Code"; "Work Type Code")
                {
                    ApplicationArea = All;
                }
                field("Recalculate Invoice Disc."; "Recalculate Invoice Disc.")
                {
                    ApplicationArea = All;
                }
                field("Outstanding Amount"; "Outstanding Amount")
                {
                    ApplicationArea = All;
                }
                field("Qty. Shipped Not Invoiced"; "Qty. Shipped Not Invoiced")
                {
                    ApplicationArea = All;
                }
                field("Shipped Not Invoiced"; "Shipped Not Invoiced")
                {
                    ApplicationArea = All;
                }
                field("Quantity Shipped"; "Quantity Shipped")
                {
                    ApplicationArea = All;
                }
                field("Quantity Invoiced"; "Quantity Invoiced")
                {
                    ApplicationArea = All;
                }
                field("Shipment No."; "Shipment No.")
                {
                    ApplicationArea = All;
                }
                field("Shipment Line No."; "Shipment Line No.")
                {
                    ApplicationArea = All;
                }
                field("Profit %"; "Profit %")
                {
                    ApplicationArea = All;
                }
                field("Bill-to Customer No."; "Bill-to Customer No.")
                {
                    ApplicationArea = All;
                }
                field("Inv. Discount Amount"; "Inv. Discount Amount")
                {
                    ApplicationArea = All;
                }
                field("Purchase Order No."; "Purchase Order No.")
                {
                    ApplicationArea = All;
                }
                field("Purch. Order Line No."; "Purch. Order Line No.")
                {
                    ApplicationArea = All;
                }
                field("Drop Shipment"; "Drop Shipment")
                {
                    ApplicationArea = All;
                }
                field("Gen. Bus. Posting Group"; "Gen. Bus. Posting Group")
                {
                    ApplicationArea = All;
                }
                field("Gen. Prod. Posting Group"; "Gen. Prod. Posting Group")
                {
                    ApplicationArea = All;
                }
                field("VAT Calculation Type"; "VAT Calculation Type")
                {
                    ApplicationArea = All;
                }
                field("Transaction Type"; "Transaction Type")
                {
                    ApplicationArea = All;
                }
                field("Transport Method"; "Transport Method")
                {
                    ApplicationArea = All;
                }
                field("Attached to Line No."; "Attached to Line No.")
                {
                    ApplicationArea = All;
                }
                field("Exit Point"; "Exit Point")
                {
                    ApplicationArea = All;
                }
                field(Area;Area)
        {
            ApplicationArea = All;
        }
                field("Transaction Specification";"Transaction Specification")
                {
                    ApplicationArea = All;
                }
                field("Tax Category";"Tax Category")
                {
                    ApplicationArea = All;
                }
                field("Tax Area Code";"Tax Area Code")
                {
                    ApplicationArea = All;
                }
                field("Tax Liable";"Tax Liable")
                {
                    ApplicationArea = All;
                }
                field("Tax Group Code";"Tax Group Code")
                {
                    ApplicationArea = All;
                }
                field("VAT Clause Code";"VAT Clause Code")
                {
                    ApplicationArea = All;
                }
                field("VAT Bus. Posting Group";"VAT Bus. Posting Group")
                {
                    ApplicationArea = All;
                }
                field("VAT Prod. Posting Group";"VAT Prod. Posting Group")
                {
                    ApplicationArea = All;
                }
                field("Currency Code";"Currency Code")
                {
                    ApplicationArea = All;
                }
                field("Outstanding Amount (LCY)";"Outstanding Amount (LCY)")
                {
                }
                field("Shipped Not Invoiced (LCY)";"Shipped Not Invoiced (LCY)")
                {
                }
                field("Reserved Quantity";"Reserved Quantity")
                {
                    ApplicationArea = All;
                }
                field("Blanket Order No.";"Blanket Order No.")
                {
                    ApplicationArea = All;
                }
                field("Blanket Order Line No.";"Blanket Order Line No.")
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
                field("System-Created Entry";"System-Created Entry")
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
                field("Inv. Disc. Amount to Invoice";"Inv. Disc. Amount to Invoice")
                {
                    ApplicationArea = All;
                }
                field("VAT Identifier";"VAT Identifier")
                {
                    ApplicationArea = All;
                }
                field("Posting Date";"Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Variant Code";"Variant Code")
                {
                    ApplicationArea = All;
                }
                field("Bin Code";"Bin Code")
                {
                    ApplicationArea = All;
                }
                field("Qty. per Unit of Measure";"Qty. per Unit of Measure")
                {
                    ApplicationArea = All;
                }
                field(Planned;Planned)
                {
                    ApplicationArea = All;
                }
                field("Unit of Measure Code";"Unit of Measure Code")
                {
                    ApplicationArea = All;
                }
                field("Quantity (Base)";"Quantity (Base)")
                {
                }
                field("Qty. Invoiced (Base)";"Qty. Invoiced (Base)")
                {
                }
                field("Item Category Code";"Item Category Code")
                {
                    ApplicationArea = All;
                }
                field(Coeficiente;Coeficiente)
                {
                    ApplicationArea = All;
                }
                field("No. contador";"No. contador")
                {
                    ApplicationArea = All;
                }
                field("Atrasos facturados";"Atrasos facturados")
                {
                    ApplicationArea = All;
                }
                field(EsNota;EsNota)
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
                field("Cantidad mensual";"Cantidad mensual")
                {
                    ApplicationArea = All;
                }
                field(HastaTramo;HastaTramo)
                {
                    ApplicationArea = All;
                }
                field("Requiere calculo de atrasos";"Requiere calculo de atrasos")
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

