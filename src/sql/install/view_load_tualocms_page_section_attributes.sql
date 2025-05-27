delimiter ;
CREATE or replace view view_load_tualocms_page_section_attributes as
select
        tualocms_section,
        ifnull(
                JSON_ARRAYAGG(
                        JSON_OBJECT(
                                'id',
                                tualocms_attribute.tualocms_attribute,
                                'name',
                                tualocms_attribute.name
                        )
                ),
                json_array()
        ) js,
        ifnull(
                JSON_ARRAYAGG(
                        tualocms_attribute.name
                ),
                json_array()
        ) js_shortnames
from
        tualocms_section_tualocms_attributes
        join tualocms_attribute on tualocms_attribute.tualocms_attribute = tualocms_section_tualocms_attributes.tualocms_attribute
group by
        tualocms_section
;
