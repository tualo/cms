delimiter //
create or replace view view_load_tualocms_page_permission_policy as
select 

    tualocms_page,
    group_concat(
        concat( policy,'=',ifnull(`value`,''))

        order by position
        separator ','
    ) permission
from view_readtable_tualocms_page_permission_policy 
where active = 1
and (
        now() between valid_from and valid_until
)
group by tualocms_page
//