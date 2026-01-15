delimiter ;

create table if not exists tualocms_domains (
    domain varchar(128) not null,
    valid_from datetime default current_timestamp,
    valid_to datetime default '2099-12-31 23:59:59',
    notes text default null,
    primary key (domain)
);

