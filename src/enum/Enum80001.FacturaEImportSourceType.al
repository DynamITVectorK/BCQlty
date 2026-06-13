enum 80001 "FacturaE Import Source Type"
{
    Extensible = true;
    Caption = 'FacturaE Import Source Type';

    value(0; Manual)
    {
        Caption = 'Manual XML Upload';
    }
    value(1; "HTTP Endpoint")
    {
        Caption = 'HTTP Endpoint';
    }
}
