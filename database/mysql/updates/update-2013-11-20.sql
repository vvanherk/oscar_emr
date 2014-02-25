ALTER TABLE site ADD clinicNo int(11);

update site set clinicNo=1234 where clinicNo is NULL;
