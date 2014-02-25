-- Ported from Opthalmology build
-- Fix eyeform consultation report, add site on print preview page
ALTER TABLE EyeformConsultationReport ADD COLUMN siteId INTEGER(11);
ALTER TABLE EyeformConsultationReport ADD CONSTRAINT eyeformconsreport_fk_siteid FOREIGN KEY (siteId) REFERENCES site(id);
