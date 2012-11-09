create table billing_defaults (
        id  int(10) NOT NULL auto_increment primary key,
        provider_no int(10) NOT NULL,
        visit_type_no int(10),
        location_no int(10),
        sli_code varchar(4),
        priority int(5),
        sli_only_if_required varchar(1)
);
