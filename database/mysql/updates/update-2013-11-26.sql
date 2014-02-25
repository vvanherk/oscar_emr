ALTER TABLE EyeformMacro ADD COLUMN billingRefProv BOOLEAN;
UPDATE EyeformMacro SET billingRefProv=1;
