table 50110 "FacturaE Import Setup"
{
    Caption = 'FacturaE Import Setup';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
            DataClassification = SystemMetadata;
        }
        field(2; "Source Type"; Enum "FacturaE Import Source Type")
        {
            Caption = 'Source Type';
            DataClassification = CustomerContent;
        }
        field(3; "Pending Invoices URL"; Text[2048])
        {
            Caption = 'Pending Invoices URL';
            DataClassification = CustomerContent;
            ExtendedDatatype = URL;
        }
        field(4; "Mark Processed URL"; Text[2048])
        {
            Caption = 'Mark Processed URL';
            DataClassification = CustomerContent;
            ExtendedDatatype = URL;
        }
        field(5; Enabled; Boolean)
        {
            Caption = 'Enabled';
            DataClassification = CustomerContent;
        }
        field(6; "Last Run DateTime"; DateTime)
        {
            Caption = 'Last Run DateTime';
            DataClassification = SystemMetadata;
            Editable = false;
        }
        field(7; "Last Imported Count"; Integer)
        {
            Caption = 'Last Imported Count';
            DataClassification = SystemMetadata;
            Editable = false;
        }
        field(8; "Last Error"; Text[250])
        {
            Caption = 'Last Error';
            DataClassification = SystemMetadata;
            Editable = false;
        }
    }

    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }

    procedure GetOrCreate()
    begin
        if Get('') then
            exit;

        Init();
        "Primary Key" := '';
        "Source Type" := "Source Type"::Manual;
        Enabled := true;
        Insert(true);
    end;
}
