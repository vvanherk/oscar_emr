CREATE TABLE spireAccessionNumberMap (
	id int(10) NOT NULL auto_increment,
	uaccn varchar(20) NOT NULL,
	PRIMARY KEY (id)
);

CREATE TABLE spireCommonAccessionNumber (
	id int(10) NOT NULL auto_increment,
	caccn varchar(20) NOT NULL,
	uaccn_id int(10) NOT NULL,
	PRIMARY KEY (id)
);
