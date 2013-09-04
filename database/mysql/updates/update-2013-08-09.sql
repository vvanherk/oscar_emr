update eform set form_html = REPLACE(form_html, 'oscarDB=address', 'oscarDB=family_doc_address') where fid = 1;
update eform set form_html = REPLACE(form_html, 'referral_Last_name', 'family_doc_Last_name')  where fid = 1;
update eform set form_html = REPLACE(form_html, 'referral_first_name', 'family_doc_first_name')  where fid = 1;
