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


