DELIMITER ;
CREATE TABLE IF NOT EXISTS `tualocms_bilder_typen` (
  `id` varchar(36) NOT NULL,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uidx_tualocms_bilder_typ` (`name`)
);
