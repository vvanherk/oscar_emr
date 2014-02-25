ALTER TABLE allergies ADD INDEX (demographic_no);
ALTER TABLE MyGroupAccessRestriction ADD INDEX (providerNo);
ALTER TABLE casemgmt_note_link ADD INDEX (note_id);
ALTER TABLE officeCommunication ADD INDEX (appointment_no);
ALTER TABLE tickler_link ADD INDEX (tickler_no);
ALTER TABLE professionalSpecialists ADD INDEX (referralNo);
ALTER TABLE property ADD INDEX (provider_no);
ALTER TABLE provider_default_program ADD INDEX (provider_no);
