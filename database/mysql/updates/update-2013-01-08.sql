ALTER TABLE radetail ADD COLUMN provider_group_billing_no varchar(4) AFTER billing_no;

UPDATE radetail as rad, provider as p SET rad.provider_group_billing_no = ExtractValue(p.comments, '/xml_p_billinggroup_no') where rad.providerohip_no = p.ohip_no;
