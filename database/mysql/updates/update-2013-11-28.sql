-- Change name of 'clinic' to 'site', to make the name less confusing (it is storing site_id, not clinic_no)
alter table billing_on_cheader1 change clinic site int(11);

-- Fix up billing_on_ext tables 'clinicNo' entries
update billing_on_ext set key_val='siteNo' where key_val='clinicNo';
update billing_on_ext set value='1' where key_val='siteNo' and (value is NULL or value='null');
