-- Change appointment table name for the site id
alter table appointment change location site int(11);

-- Fix up appointment tables 'site' entries
update appointment left join site on site_id=site set site=site_id where site is not NULL and site!='';
update appointment set site='1' where site is NULL or site='';

-- Change appointmentType table name for the site id
alter table appointmentType change location site int(11);

-- Fix up appointmentType tables 'site' entries
update appointmentType left join site on site_id=site set site=site_id where site is not NULL and site!='';
update appointmentType set site='1' where site is NULL or site='';
