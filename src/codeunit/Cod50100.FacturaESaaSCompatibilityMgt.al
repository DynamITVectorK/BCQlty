codeunit 50100 "FacturaE SaaS Compatibility Mgt."
{
    Access = Internal;

    procedure RemoveRepositoryPathCodes(SourcePath: Text): Text
    var
        ResultPath: Text;
    begin
        ResultPath := SourcePath;
        ResultPath := RemoveToken(ResultPath, 'app:');
        ResultPath := RemoveToken(ResultPath, 'cm:');
        ResultPath := RemoveToken(ResultPath, 'cm_');
        exit(ResultPath);
    end;

    procedure RemoveRepositoryContainerPrefix(SourcePath: Text): Text
    var
        ResultPath: Text;
    begin
        ResultPath := RemoveRepositoryPathCodes(SourcePath);
        while StrPos(ResultPath, '/company_home') <> 0 do
            ResultPath := DelStr(ResultPath, StrPos(ResultPath, '/company_home'), StrLen('/company_home'));
        exit(ResultPath);
    end;

    procedure SameVAT(ExpectedVAT: Text; ActualVAT: Text): Boolean
    begin
        exit(NormalizeVAT(ExpectedVAT) = NormalizeVAT(ActualVAT));
    end;

    procedure NormalizeVAT(VatRegistrationNo: Text): Text
    var
        CountryPrefix: Text[2];
        ResultVAT: Text;
    begin
        ResultVAT := UpperCase(DelChr(VatRegistrationNo, '=', ' .-'));
        if StrLen(ResultVAT) <= 2 then
            exit(ResultVAT);

        CountryPrefix := CopyStr(ResultVAT, 1, 2);
        case CountryPrefix of
            'ES', 'FR', 'PT', 'DE', 'IT', 'NL', 'BE', 'IE', 'LU', 'AT':
                exit(CopyStr(ResultVAT, 3));
        end;

        exit(ResultVAT);
    end;

    procedure CutTextAtWordBoundary(SourceText: Text; MaxLength: Integer): Text
    var
        Candidate: Text;
        LastSpacePosition: Integer;
        Position: Integer;
    begin
        if MaxLength <= 0 then
            exit('');

        if StrLen(SourceText) <= MaxLength then
            exit(SourceText);

        Candidate := CopyStr(SourceText, 1, MaxLength);
        Position := StrPos(Candidate, ' ');
        while Position <> 0 do begin
            LastSpacePosition += Position;
            Candidate := CopyStr(Candidate, Position + 1);
            Position := StrPos(Candidate, ' ');
        end;

        if LastSpacePosition > 0 then
            exit(CopyStr(SourceText, 1, LastSpacePosition - 1));

        exit(CopyStr(SourceText, 1, MaxLength));
    end;

    local procedure RemoveToken(SourceText: Text; Token: Text): Text
    var
        ResultText: Text;
    begin
        ResultText := SourceText;
        while StrPos(ResultText, Token) <> 0 do
            ResultText := DelStr(ResultText, StrPos(ResultText, Token), StrLen(Token));
        exit(ResultText);
    end;
}
