delimiter ;
CREATE VIEW IF NOT EXISTS `view_session_oauth_check` AS


with ses as (
    select 
        o.id,
        o.client,
        o.username,
        o.create_time,
        o.lastcontact,
        o.validuntil,
        o.singleuse,
        o.name,
        o.device,
        p.path
    from 
        SESSIONDB.oauth o
        left join SESSIONDB.oauth_path p
            on p.id = o.id
    where (
        o.client=database() or o.client = '*'
    ) 
    
)
select * from ses;


create table if not exists tualocms_domains (
    domain varchar(128) not null,
    valid_from datetime default current_timestamp,
    valid_to datetime default '2099-12-31 23:59:59',
    notes text default null,
    primary key (domain)
);


create table if not exists tualocms_domain_ip (
    domain varchar(128) not null,
    ip varchar(255) not null,
    constraint fk_tualocms_domain_ip foreign key (domain) references tualocms_domains(domain) on delete cascade on update cascade,
    primary key (domain,ip)
);


create table if not exists tualocms_domain_ip_certs (
    domain varchar(128) not null,
    ip varchar(255) not null,

    certificate_valid_from datetime default null,
    certificate_valid_to datetime default null,
    certificate_checked_on datetime default null,

    constraint fk_tualocms_domain_ip_certs foreign key (domain,ip) references tualocms_domain_ip(domain,ip) on delete cascade on update cascade,
    primary key (domain,ip)
);