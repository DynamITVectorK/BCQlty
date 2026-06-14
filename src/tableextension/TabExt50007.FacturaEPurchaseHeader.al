tableextension 50007 "FacturaE Purchase Header" extends "Purchase Header"
{
    fields
    {
        field(50007; "ID Plataforma FacturaE"; Text[50]) { Caption = 'ID Plataforma FacturaE'; DataClassification = CustomerContent; }
        field(50008; "Numero FacturaE"; Text[20]) { Caption = 'Numero FacturaE'; DataClassification = CustomerContent; }
        field(50009; "Fecha recepcion documento"; Date) { Caption = 'Fecha recepcion documento'; DataClassification = CustomerContent; }
        field(50010; "Aprobador 1"; Code[50]) { Caption = 'Aprobador 1'; DataClassification = CustomerContent; TableRelation = User."User Name"; }
        field(50011; "Aprobador 2"; Code[50]) { Caption = 'Aprobador 2'; DataClassification = CustomerContent; TableRelation = User."User Name"; }
        field(50012; "Aprobador 3"; Code[50]) { Caption = 'Aprobador 3'; DataClassification = CustomerContent; TableRelation = User."User Name"; }
        field(50013; "Aprobador 4"; Code[50]) { Caption = 'Aprobador 4'; DataClassification = CustomerContent; TableRelation = User."User Name"; }
        field(50014; "No. expediente adjudicacion"; Text[20]) { Caption = 'No. expediente adjudicacion'; DataClassification = CustomerContent; }
        field(50015; Lote; Text[30]) { Caption = 'Lote'; DataClassification = CustomerContent; }
    }
}
