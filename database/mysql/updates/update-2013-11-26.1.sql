-- Fix site FK in consultationRequests table
update consultationRequests left join site on site_name=site.name set site_name=site.site_id where site_name != '';
update consultationRequests set site_name=1 where site_name is NULL or site_name = '';
alter table consultationRequests change site_name site_no int(11);
