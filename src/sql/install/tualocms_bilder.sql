DELIMITER ;
CREATE TABLE IF NOT EXISTS `tualocms_bilder` (
  `id` varchar(36) NOT NULL,
  `titel` varchar(255) NOT NULL,
  `typ` varchar(36) NOT NULL,
  `file_id` varchar(36) NOT NULL,
  PRIMARY KEY (`id`)
  -- CONSTRAINT `tualocms_bilder_ibfk_1` FOREIGN KEY (`typ`) REFERENCES `tualocms_bilder_typen` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ;

alter table `tualocms_bilder` drop foreign key if exists `tualocms_bilder_ibfk_1`;
alter table `tualocms_bilder` drop key if exists uidx_tualocms_bilder_typ ;
alter table `tualocms_bilder` add constraint `tualocms_bilder_typ` foreign key if not exists (`typ`) references `tualocms_bilder_typen` (`id`) on delete cascade on update cascade;


CREATE VIEW if not exists `view_readtable_tualocms_bilder` AS
select
    `tualocms_bilder`.`id` AS `id`,
    `tualocms_bilder`.`titel` AS `titel`,
    `tualocms_bilder`.`typ` AS `typ`,
    `ds_files`.`name` AS `__file_name`,
    `ds_files`.`path` AS `path`,
    `ds_files`.`size` AS `__file_size`,
    `ds_files`.`mtime` AS `mtime`,
    `ds_files`.`ctime` AS `ctime`,
    `ds_files`.`type` AS `__file_type`,
    `ds_files`.`file_id` AS `__file_id`,
    `ds_files`.`hash` AS `hash`,
    '' AS `__file_data`
from
    (
        `tualocms_bilder`
        left join `ds_files` on(
            `tualocms_bilder`.`file_id` = `ds_files`.`file_id`
        )
    );
    