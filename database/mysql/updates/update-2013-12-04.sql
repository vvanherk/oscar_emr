-- Fix up scheduledate tables 'reason' entries
-- TODO: Can 'reason' be anything other than site id?
update scheduledate left join site on site.name=reason set reason=site_id where reason = site.name;
update scheduledate set reason=1 where reason is NULL or reason = '';

alter table scheduledate change reason siteId int(11);
