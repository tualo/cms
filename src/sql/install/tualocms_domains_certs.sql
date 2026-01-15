delimiter ;

create table if not exists tualocms_domain_ip_certs (
    domain varchar(128) not null,
    ip varchar(255) not null,
    fingerprint varchar(255) not null,

    certificate_valid_from datetime default null,
    certificate_valid_to datetime default null,
    certificate_checked_on datetime default null,

    constraint fk_tualocms_domain_ip_certs foreign key (domain,ip) references tualocms_domain_ip(domain,ip) on delete cascade on update cascade,
    primary key (domain,ip)
);