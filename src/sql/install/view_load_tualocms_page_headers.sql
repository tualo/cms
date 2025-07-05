delimiter //
create or replace view view_load_tualocms_page_headers as
select 

    tualocms_page,
    header_key,
    value header_value

from view_readtable_tualocms_page_headers 
where active = 1
and (
        now() between valid_from and valid_until
)
//