-- Add default site
insert into site (phone, fax, address, city, province, postal) select clinic_phone, clinic_fax, clinic_address, clinic_city, clinic_province, clinic_postal from clinic limit 1;

update site set name='Default', short_name='Default', bg_color='green', status=1;

-- Add providers to site
insert into providersite (provider_no) select provider_no from provider;
update providersite set site_id=1;

-- Fix any previous site entries in the billing_on_cheader1 table
update billing_on_cheader1 set clinic = (select site_id from site where site.name = billing_on_cheader1.clinic) where clinic is not null;

-- Change the billing_on_cheader1 table to use site_id (int(11)) for storing the site
alter table billing_on_cheader1 modify clinic int(11);

-- Update all bills that do not have a clinic set to use the default clinic
update billing_on_cheader1 set clinic = 1 where clinic is null;
