delimiter ;
create table if not exists tualocms_page_permission_policy(
        tualocms_page varchar(36) not null,
        policy varchar(50) not null,
        position int(11) default 0,
        active tinyint default 0,
        `value` varchar(255) default null,
        
        valid_from datetime NOT null default current_timestamp,
        valid_until datetime NOT NULL default '2099-12-31 23:59:59',
        
        PRIMARY KEY (tualocms_page,policy),
        KEY idx_tualocms_page_permission_policy (policy),
        
        CONSTRAINT fk_tualocms_page_permission_policy 
                FOREIGN KEY (policy) 
                REFERENCES tualocms_permission_policy (policy) 
                ON UPDATE CASCADE
                ON DELETE CASCADE,
        
        CONSTRAINT fk_tualocms_page_permission_policy_page 
                FOREIGN KEY (tualocms_page) 
                REFERENCES tualocms_page (tualocms_page) 
                ON UPDATE CASCADE
                ON DELETE CASCADE
);

create or replace view view_readtable_tualocms_page_permission_policy as
select

        ifnull(tualocms_page_permission_policy.active,0) as active,
        tualocms_page.tualocms_page as tualocms_page,
        tualocms_permission_policy.policy as policy,
        if( ifnull(tualocms_page_permission_policy.position,0)=0, rank() over (partition by tualocms_page.tualocms_page order by tualocms_permission_policy.policy),ifnull(tualocms_page_permission_policy.position,0)) as position,
        ifnull(tualocms_page_permission_policy.value,tualocms_permission_policy.default_value) as `value`,
        ifnull(tualocms_page_permission_policy.valid_from,current_timestamp) as valid_from,
        ifnull(tualocms_page_permission_policy.valid_until,'2099-12-31 23:59:59') as valid_until
from
        tualocms_permission_policy
        join tualocms_page
        left join tualocms_page_permission_policy
        on tualocms_page_permission_policy.tualocms_page = tualocms_page.tualocms_page
            and tualocms_page_permission_policy.policy = tualocms_permission_policy.policy
;

