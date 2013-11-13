-- Change appointment table name for the site id
alter table appointment change location site int(11);

-- Fix up appointment tables 'site' entries
update appointment left join site on site_id=site set site=site_id where site is not NULL and site!='';
update appointment set site='1' where site is NULL or site='';
