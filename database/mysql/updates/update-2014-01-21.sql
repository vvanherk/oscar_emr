-- Update a provider preference to be 'False' (instead of NULL)
update eform set patient_independent=0 where patient_independent is NULL;

-- Update provider practitionerNo to be an empty string if they are NULL or the string 'null'
update provider set practitionerNo='' where practitionerNo is NULL or practitionerNo='null';

-- Update casemgmt_note so that there are no NULL values for primitive type 'locked'
update casemgmt_note set locked=0 where locked is NULL;
