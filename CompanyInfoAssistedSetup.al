codeunit 50100 "LAB CompanyInfoAssistedSetup"
{

  [EventSubscriber(ObjectType::Table, 1808, 'OnRegisterAssistedSetup', '', false, false)]
  local procedure "AggregatedAssistedSetup.OnRegisterAssistedSetup"(var TempAggregatedAssistedSetup : Record 1808 temporary);
  var
    CompanyInformation : Record 79;
  begin
    TempAggregatedAssistedSetup.AddExtensionAssistedSetup(PAGE::"LAB Company Info Wizard",
                                                          'Setup Company Information',
                                                          true,
                                                          CompanyInformation.RecordId(),
                                                          GetCompanyInformationSetupStatus(TempAggregatedAssistedSetup),
                                                          '');
  end;

local procedure GetCompanyInformationSetupStatus(AggregatedAssistedSetup : Record "Aggregated Assisted Setup") : Integer;
var
  CompanyInformation : Record "Company Information";
begin
  with AggregatedAssistedSetup do begin
    if CompanyInformation.Get then
      if (CompanyInformation.Name = '') or (CompanyInformation."E-Mail" = '') then
        Status := Status::"Not Completed"
      else
        Status := Status::Completed
    else
      Status := Status::"Not Completed";
    exit(Status);
  end;
end;
}
