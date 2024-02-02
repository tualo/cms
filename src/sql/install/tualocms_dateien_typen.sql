DELIMITER ;
CREATE TABLE IF NOT EXISTS `tualocms_dateien_typen` (
  `id` varchar(36) NOT NULL,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uidx_tualocms_dateien_typ` (`name`)
);

insert ignore into tualocms_dateien_typen (id, name) values ('n/a', 'N/A');