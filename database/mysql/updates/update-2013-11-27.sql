alter table EyeformConsultationReport add clinicNo int(11) after patientWillBook;
update EyeformConsultationReport set siteId = 1 where siteId is NULL or siteId = '';
update EyeformConsultationReport ecr left join site on ecr.siteId=site.site_id set ecr.clinicNo=site.clinicNo;
