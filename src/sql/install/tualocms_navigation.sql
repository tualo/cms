DELIMITER ;
CREATE TABLE IF NOT EXISTS `tualocms_navigation` (
  `id` varchar(36) NOT NULL default uuid(),
  `group` varchar(36) NOT NULL default'main',
  `name` varchar(255) NOT NULL,
  `url` varchar(255) NOT NULL,
  `parent_id` varchar(36) NOT NULL,
  `order` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ;
