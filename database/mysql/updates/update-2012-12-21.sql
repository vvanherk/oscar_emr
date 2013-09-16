CREATE TABLE IF NOT EXISTS spireAccessionNumberMap (
	id int(10) NOT NULL auto_increment,
	uaccn varchar(20) NOT NULL,
	PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS spireCommonAccessionNumber (
	id int(10) NOT NULL auto_increment,
	caccn varchar(20) NOT NULL,
	lab_no int(10),
	map_id int(10),
	order_index int(4),
	PRIMARY KEY (id)
);
