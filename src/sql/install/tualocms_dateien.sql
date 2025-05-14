DELIMITER ;
CREATE TABLE IF NOT EXISTS `tualocms_dateien` (
  `id` varchar(36) NOT NULL,
  `titel` varchar(255) NOT NULL,
  `typ` varchar(36) NOT NULL,
  `file_id` varchar(36) NOT NULL,
  PRIMARY KEY (`id`)
    -- ,
  -- UNIQUE KEY `uidx_tualocms_dateien_typ` (`typ`),
  -- CONSTRAINT `tualocms_dateien_ibfk_1` FOREIGN KEY (`typ`) REFERENCES `tualocms_dateien_typen` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ;

alter table `tualocms_dateien` drop foreign key if exists `tualocms_dateien_ibfk_1`;
alter table `tualocms_dateien` drop key if exists uidx_tualocms_dateien_typ ;
alter table `tualocms_dateien` add constraint   `tualocms_dateien_typ` foreign key if not exists  (`typ`) references `tualocms_dateien_typen` (`id`) on delete cascade on update cascade;





CREATE VIEW if not exists `view_readtable_tualocms_dateien` AS
select
    `tualocms_dateien`.`id` AS `id`,
    `tualocms_dateien`.`titel` AS `titel`,
    `tualocms_dateien`.`typ` AS `typ`,
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
        `tualocms_dateien`
        left join `ds_files` on(
            `tualocms_dateien`.`file_id` = `ds_files`.`file_id`
        )
    );
    