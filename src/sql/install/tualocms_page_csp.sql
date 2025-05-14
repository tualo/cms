delimiter ;
create table if not exists tualocms_page_csp(
        tualocms_page varchar(36) not null,
        policy varchar(50) not null,
        position int(11) default 0,
        active tinyint default 0,
        `value` varchar(255) default null,
        
        valid_from datetime NOT null default current_timestamp,
        valid_until datetime NOT NULL default '2099-12-31 23:59:59',
        
        PRIMARY KEY (tualocms_page,policy),
        KEY idx_tualocms_page_csp (policy),
        
        CONSTRAINT fk_tualocms_page_csp 
                FOREIGN KEY (policy) 
                REFERENCES tualocms_csp (policy) 
                ON UPDATE CASCADE
                ON DELETE CASCADE,
        
        CONSTRAINT fk_tualocms_page_csp_page 
                FOREIGN KEY (tualocms_page) 
                REFERENCES tualocms_page (tualocms_page) 
                ON UPDATE CASCADE
                ON DELETE CASCADE
);

create or replace view view_readtable_tualocms_page_csp as
select

        ifnull(tualocms_page_csp.active,0) as active,
        tualocms_page.tualocms_page as tualocms_page,
        tualocms_csp.policy as policy,
        if( ifnull(tualocms_page_csp.position,0)=0, rank() over (partition by tualocms_page.tualocms_page order by tualocms_csp.policy),ifnull(tualocms_page_csp.position,0)) as position,

        ifnull(tualocms_page_csp.value,tualocms_csp.default_value) as `value`,
        ifnull(tualocms_page_csp.valid_from,current_timestamp) as valid_from,
        ifnull(tualocms_page_csp.valid_until,'2099-12-31 23:59:59') as valid_until
from
        tualocms_csp
        join tualocms_page
        left join tualocms_page_csp
        on tualocms_page_csp.tualocms_page = tualocms_page.tualocms_page
            and tualocms_page_csp.policy = tualocms_csp.policy
;

