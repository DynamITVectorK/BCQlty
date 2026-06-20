page 50069 "Registros ADOS"
{
    Caption = 'Registros ADOS';
    PageType = List;
    UsageCategory = Administration;
    SourceTable = 50014;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(NumReg; Rec.NumReg)
                {
                    ApplicationArea = All;
                }
                field(CodigoAdos; Rec.CodigoAdos)
                {
                    ApplicationArea = All;
                }
                field(RazonSocial; Rec.RazonSocial)
                {
                    ApplicationArea = All;
                }
                field(CIF; Rec.CIF)
                {
                    ApplicationArea = All;
                }
                field(Direccion; Rec.Direccion)
                {
                    ApplicationArea = All;
                }
                field(Poblacion; Rec.Poblacion)
                {
                    ApplicationArea = All;
                }
                field(CodigoPostal; Rec.CodigoPostal)
                {
                    ApplicationArea = All;
                }
                field(Dim1; Rec.Dim1)
                {
                    ApplicationArea = All;
                }
                field(Fecha; Rec.Fecha)
                {
                    ApplicationArea = All;
                }
                field(Origen; Rec.Origen)
                {
                    ApplicationArea = All;
                }
                field(Sector; Rec.Sector)
                {
                    ApplicationArea = All;
                }
                field(Producto; Rec.Producto)
                {
                    ApplicationArea = All;
                }
                field(Categoria; Rec.Categoria)
                {
                    ApplicationArea = All;
                }
                field(Importe; Rec.Importe)
                {
                    ApplicationArea = All;
                }
                field(ImporteSinIVA; Rec.ImporteSinIVA)
                {
                    ApplicationArea = All;
                }
                field(Ope; Rec.Ope)
                {
                    ApplicationArea = All;
                }
                field(UdRecauda; Rec.UdRecauda)
                {
                    ApplicationArea = All;
                }
                field(Remesa; Rec.Remesa)
                {
                    ApplicationArea = All;
                }
                field(MedPago; Rec.MedPago)
                {
                    ApplicationArea = All;
                }
                field(Tique; Rec.Tique)
                {
                    ApplicationArea = All;
                }
                field(Cantidad; Rec.Cantidad)
                {
                    ApplicationArea = All;
                }
                field(FechaIni; Rec.FechaIni)
                {
                    ApplicationArea = All;
                }
                field(FechaFin; Rec.FechaFin)
                {
                    ApplicationArea = All;
                }
                field(Tratado; Rec.Tratado)
                {
                    ApplicationArea = All;
                }
                field(FechaTratado; Rec.FechaTratado)
                {
                    ApplicationArea = All;
                }
                field(NumPreFactura; Rec.NumPreFactura)
                {
                    ApplicationArea = All;
                }
                field(NumFactura; Rec.NumFactura)
                {
                    ApplicationArea = All;
                }
                field(NumFacturaADOS; Rec.NumFacturaADOS)
                {
                    ApplicationArea = All;
                }
                field(NumFacturaADOSanul; Rec.NumFacturaADOSanul)
                {
                    ApplicationArea = All;
                }
                field(CodigoClienteNAV; Rec.CodigoClienteNAV)
                {
                    ApplicationArea = All;
                }
                field(Caducado; Rec.Caducado)
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