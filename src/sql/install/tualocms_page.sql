DELIMITER ;
CREATE TABLE IF NOT EXISTS `tualocms_page` (
  `tualocms_page` varchar(36) NOT NULL,
  `path` varchar(255) NOT NULL,
  `pug_file` varchar(50) DEFAULT NULL,
  `valid_from` datetime NOT NULL DEFAULT current_timestamp(),
  `valid_until` datetime NOT NULL DEFAULT '2099-12-31 23:59:59',
  `title` longtext DEFAULT NULL,
  `content` longtext DEFAULT NULL,
  PRIMARY KEY (`tualocms_page`),
  KEY `idx_tualocms_page_pug_file` (`pug_file`),
  CONSTRAINT `fk_tualocms_page_pug_file` FOREIGN KEY (`pug_file`) REFERENCES `ds_pug_templates` (`id`) ON UPDATE CASCADE
);



alter table tualocms_page add if not exists show_in_sitemap tinyint default 1;