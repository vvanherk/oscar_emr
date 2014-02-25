-- Optimize measurements and casemgmt_note table by adding index to appointment number
ALTER TABLE measurements ADD INDEX (appointmentNo);
ALTER TABLE casemgmt_note ADD INDEX (appointmentNo);
