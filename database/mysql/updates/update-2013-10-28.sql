CREATE TABLE officeCommunication (
	id int UNSIGNED AUTO_INCREMENT,
	appointment_no int(11),
	demographic_no int(10),
	note mediumtext,
	signed tinyint(1),
	create_date datetime NOT NULL,
	update_date datetime NOT NULL,
	PRIMARY KEY(id)
);
