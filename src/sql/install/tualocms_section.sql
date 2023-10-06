DELIMITER ;
CREATE TABLE IF NOT EXISTS `tualocms_section` (
  `tualocms_section` varchar(36) NOT NULL,
  `title` longtext DEFAULT NULL,
  `content` longtext DEFAULT NULL,
  `valid_from` datetime NOT NULL DEFAULT current_timestamp(),
  `valid_until` datetime NOT NULL DEFAULT '2099-12-31 23:59:59',
  `pug_file` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`tualocms_section`),
  KEY `idx_tualocms_section_pug_file` (`pug_file`),
  CONSTRAINT `fk_tualocms_section_pug_file` FOREIGN KEY (`pug_file`) REFERENCES `ds_pug_templates` (`id`) ON UPDATE CASCADE
);
