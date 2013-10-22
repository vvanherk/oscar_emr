create table Eyeform_temp (id INT(11));

insert into Eyeform_temp(id) select id from Eyeform where appointment_no=0 order by id desc limit 1;

delete from Eyeform where appointment_no=0 and id != (
	select id from Eyeform_temp
);

drop table Eyeform_temp;
