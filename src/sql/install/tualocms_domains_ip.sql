delimiter ;

create table if not exists tualocms_domain_ip (
    domain varchar(128) not null,
    ip varchar(255) not null,
    constraint fk_tualocms_domain_ip foreign key (domain) references tualocms_domains(domain) on delete cascade on update cascade,
    primary key (domain,ip)
);
