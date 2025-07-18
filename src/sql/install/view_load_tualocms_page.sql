DELIMITER ;

CREATE VIEW if not exists  `view_load_tualocms_page_slug` AS

select 
    '' tualocms_page_id,
    '' tualocms_page,
    '' path,
    '' pug_file,
    '' page,
    1 show_in_sitemap
from
    `tualocms_page`
where false
;


CREATE OR REPLACE VIEW `view_load_tualocms_page_intern` AS
select
    `tualocms_page`.`tualocms_page` AS `tualocms_page_id`,
    `tualocms_page`.`tualocms_page` AS `tualocms_page`,
    `tualocms_page`.`path` AS `path`,
    `tualocms_page`.`pug_file` AS `pug_file`,
    `tualocms_page`.`show_in_sitemap`,
    json_object(
        'id',
        `tualocms_page`.`tualocms_page`,
        'path',
        `tualocms_page`.`path`,
        'title',
        `tualocms_page`.`title`,
        'content',
        `tualocms_page`.`content`,
        'template',
        `tualocms_page`.`pug_file`,
        'params', json_object(
            'title',
            `tualocms_page`.`title`,
            'path',
            `tualocms_page`.`path`
        ),
        'sections',
        ifnull(
            json_arrayagg(
                json_object(
                    'id',
                    `tualocms_section`.`tualocms_section`,
                    'title',
                    `tualocms_section`.`title`,
                    'content',
                    `tualocms_section`.`content`,
                    'template',
                    `tualocms_section`.`pug_file`,
                    'anchor',
                    `tualocms_section`.`anchor`,
                    'attributes',
                    ifnull(
                        `view_load_tualocms_page_section_attributes`.`js`,
                        json_array()
                    ),
                    'attributes_short',
                    ifnull(
                        `view_load_tualocms_page_section_attributes`.`js_shortnames`,
                        json_array()
                    )
                )
                order by
                    `tualocms_section_tualocms_page`.`position` ASC
            ),
            json_array()
        ),
        'meta_description_en',
        `tualocms_page`.`meta_description_en`,
        'meta_description_de',
        `tualocms_page`.`meta_description_de`,
        'meta_keys_en',
        `tualocms_page`.`meta_keys_en`,
        'meta_keys_de',
        `tualocms_page`.`meta_keys_de`,

        'meta_title_en',
        `tualocms_page`.`meta_title_en`,
        'meta_title_de',
        `tualocms_page`.`meta_title_de`
        
    ) AS `page`
from
    (
        (
            (
                `tualocms_page`
                left join `tualocms_section_tualocms_page` on(
                    `tualocms_section_tualocms_page`.`tualocms_page` = `tualocms_page`.`tualocms_page`
                    and current_timestamp() between `tualocms_page`.`valid_from`
                    and `tualocms_page`.`valid_until`
                    and current_timestamp() between `tualocms_section_tualocms_page`.`valid_from`
                    and `tualocms_section_tualocms_page`.`valid_until`
                )
            )
            left join `tualocms_section` on(
                `tualocms_section`.`tualocms_section` = `tualocms_section_tualocms_page`.`tualocms_section`
                and current_timestamp() between `tualocms_section`.`valid_from`
                and `tualocms_section`.`valid_until`
            )
        )
        left join `view_load_tualocms_page_section_attributes` on(
            `view_load_tualocms_page_section_attributes`.`tualocms_section` = `tualocms_section`.`tualocms_section`
        )
    )
group by
    `tualocms_page`.`tualocms_page`
;

CREATE or REPLACE    VIEW `view_load_tualocms_page` AS
select 
     tualocms_page_id,
     tualocms_page,
     path,
     pug_file,
     page,
     show_in_sitemap
from view_load_tualocms_page_intern
union   
    
    select 
    tualocms_page_id,
     tualocms_page,
     path,
     pug_file,
     page,
     show_in_sitemap
from 
    view_load_tualocms_page_slug
;