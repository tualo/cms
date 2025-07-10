DELIMITER ;
CREATE TABLE IF NOT EXISTS `tualocms_default_robots` (
  `id` varchar(36) NOT NULL,
  `data` longtext NOT NULL,
  PRIMARY KEY (`id`)
);

call fill_ds('tualocms_default_robots');
call fill_ds_column('tualocms_default_robots');
