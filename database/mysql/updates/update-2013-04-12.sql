alter table EyeformMacro add includeAdmissionDate Boolean;

update EyeformMacro set includeAdmissionDate = 1;
