-- Fix site FK in OSCAR
update appointment left join site on location=site.name set location=site.site_id where location != '';
update appointment set location=1 where location is NULL or location = '';
alter table appointment modify location int(11);

-- Eugh...how do we fix rschedule table?
-- update rschedule left join site on location=site.name set location=site.site_id where location != '';
-- update appointment set location=1 where location is NULL or location = '';
-- alter table appointment modify location int(11);

-- Is the 'reason' column anything other than a site name?
update scheduledate left join site on reason=site.name set reason=site.site_id where reason != '';
-- update scheduledate set reason=1 where reason is NULL or reason = '';
-- alter table scheduledate modify reason int(11);

-- Query query = entityManager.createNativeQuery("update rschedule set avail_hour = replace(avail_hour, :oldname, :newname) ");
-- query.setParameter("oldname", ">"+old.getName()+"<");
-- query.setParameter("newname", ">"+s.getName()+"<");
-- query.executeUpdate();

-- query = entityManager.createNativeQuery("update scheduledate set reason = :newname where reason = :oldname");
-- query.setParameter("oldname", old.getName());
-- query.setParameter("newname", s.getName());
-- query.executeUpdate();
