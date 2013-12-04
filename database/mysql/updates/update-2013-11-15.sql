ALTER TABLE ProviderPreference ADD billingSiteDefault int(11) AFTER billingVisitLocationDefault;

update ProviderPreference set billingSiteDefault=0;
