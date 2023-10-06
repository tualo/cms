DELIMITER ;
CREATE TABLE IF NOT EXISTS `tualocms_section_tualocms_page` (
  `tualocms_page` varchar(36) NOT NULL,
  `tualocms_section` varchar(36) NOT NULL,
  `position` int(11) DEFAULT 0,
  `valid_from` datetime NOT NULL DEFAULT current_timestamp(),
  `valid_until` datetime NOT NULL DEFAULT '2099-12-31 23:59:59',
  PRIMARY KEY (`tualocms_page`,`tualocms_section`),
  KEY `idx_tualocms_section_tualocms_page_page` (`tualocms_page`),
  KEY `idx_tualocms_section_tualocms_page_section` (`tualocms_section`),
  CONSTRAINT `fk_tualocms_section_tualocms_page_page` FOREIGN KEY (`tualocms_page`) REFERENCES `tualocms_page` (`tualocms_page`) ON UPDATE CASCADE,
  CONSTRAINT `fk_tualocms_section_tualocms_page_section` FOREIGN KEY (`tualocms_section`) REFERENCES `tualocms_section` (`tualocms_section`) ON UPDATE CASCADE
);
