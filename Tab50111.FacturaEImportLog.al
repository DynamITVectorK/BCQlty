table 50111 "FacturaE Import Log"
{
    Caption = 'FacturaE Import Log';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            DataClassification = SystemMetadata;
            AutoIncrement = true;
        }
        field(2; "External Id"; Text[100])
        {
            Caption = 'External Id';
            DataClassification = CustomerContent;
        }
        field(3; "File Name"; Text[250])
        {
            Caption = 'File Name';
            DataClassification = CustomerContent;
        }
        field(4; Status; Enum "FacturaE Import Status")
        {
            Caption = 'Status';
            DataClassification = CustomerContent;
        }
        field(5; Message; Text[250])
        {
            Caption = 'Message';
            DataClassification = CustomerContent;
        }
        field(6; "Invoice Platform Id"; Text[50])
        {
            Caption = 'Invoice Platform Id';
            DataClassification = CustomerContent;
        }
        field(7; "Imported At"; DateTime)
        {
            Caption = 'Imported At';
            DataClassification = SystemMetadata;
        }
        field(8; "User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = EndUserIdentifiableInformation;
        }
    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
        key(ExternalId; "External Id")
        {
        }
    }
}
