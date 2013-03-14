alter table billing_defaults 
change location_no location_id int(10),
drop sli_only_if_required
;
