delimiter ;


create table if not exists `tualocms_page_headers`(
        tualocms_page varchar(36) not null,
        header_key varchar(100) not null,
        position int(11) default 0,
        active tinyint default 0,
        `value` varchar(255) default null,
        
        valid_from datetime NOT null default current_timestamp,
        valid_until datetime NOT NULL default '2099-12-31 23:59:59',
        
        PRIMARY KEY (tualocms_page,header_key),
        KEY idx_tualocms_page_headers (header_key),
        
        CONSTRAINT fk_tualocms_page_headers
                FOREIGN KEY (header_key) 
                REFERENCES tualocms_additional_headers (header_key) 
                ON UPDATE CASCADE
                ON DELETE CASCADE,
        
        CONSTRAINT fk_tualocms_page_headers_page 
                FOREIGN KEY (tualocms_page) 
                REFERENCES tualocms_page (tualocms_page) 
                ON UPDATE CASCADE
                ON DELETE CASCADE
);

create or replace view view_readtable_tualocms_page_headers as
select

        ifnull(tualocms_page_headers.active,0) as active,
        tualocms_page.tualocms_page as tualocms_page,
        tualocms_additional_headers.header_key as header_key,
        if( ifnull(tualocms_page_headers.position,0)=0, rank() over (partition by tualocms_page.tualocms_page order by tualocms_additional_headers.header_key),ifnull(tualocms_page_headers.position,0)) as position,

        ifnull(tualocms_page_headers.value,tualocms_additional_headers.header_value) as `value`,
        ifnull(tualocms_page_headers.valid_from,current_timestamp) as valid_from,
        ifnull(tualocms_page_headers.valid_until,'2099-12-31 23:59:59') as valid_until
from
        tualocms_additional_headers
        join tualocms_page
        left join tualocms_page_headers
        on tualocms_page_headers.tualocms_page = tualocms_page.tualocms_page
            and tualocms_page_headers.header_key = tualocms_additional_headers.header_key
            
;
