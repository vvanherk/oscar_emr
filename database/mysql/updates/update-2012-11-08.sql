create table billing_defaults (
        id  int(10) NOT NULL auto_increment primary key,
        provider_no int(6) NOT NULL,
        visit_type_no varchar(10),
        location_no varchar(4),
        sli_code varchar(4),
        billing_form varchar(10),
        priority int(5),
        sli_only_if_required varchar(1)
);
