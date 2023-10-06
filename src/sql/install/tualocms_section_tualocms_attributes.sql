DELIMITER ;
CREATE TABLE IF NOT EXISTS `tualocms_section_tualocms_attributes` (
  `tualocms_attribute` varchar(36) NOT NULL,
  `tualocms_section` varchar(36) NOT NULL,
  `position` int(11) DEFAULT 0,
  `valid_from` datetime NOT NULL DEFAULT current_timestamp(),
  `valid_until` datetime NOT NULL DEFAULT '2099-12-31 23:59:59',
  PRIMARY KEY (`tualocms_attribute`,`tualocms_section`),
  KEY `idx_tualocms_section_tualocms_attributes_attribute` (`tualocms_attribute`),
  KEY `idx_tualocms_section_tualocms_attributes_section` (`tualocms_section`),
  CONSTRAINT `fk_tualocms_section_tualocms_attributes_attribute` FOREIGN KEY (`tualocms_attribute`) REFERENCES `tualocms_attribute` (`tualocms_attribute`) ON UPDATE CASCADE,
  CONSTRAINT `fk_tualocms_section_tualocms_attributes_section` FOREIGN KEY (`tualocms_section`) REFERENCES `tualocms_section` (`tualocms_section`) ON UPDATE CASCADE
);
