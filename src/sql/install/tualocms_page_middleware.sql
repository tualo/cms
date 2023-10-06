DELIMITER ;
CREATE TABLE IF NOT EXISTS `tualocms_page_middleware` (
  `tualocms_page` varchar(36) NOT NULL,
  `tualocms_middleware` varchar(50) NOT NULL,
  `position` int(11) DEFAULT 0,
  `valid_from` datetime NOT NULL DEFAULT current_timestamp(),
  `valid_until` datetime NOT NULL DEFAULT '2099-12-31 23:59:59',
  PRIMARY KEY (`tualocms_page`,`tualocms_middleware`),
  KEY `idx_tualocms_page_middleware_middleware` (`tualocms_middleware`),
  CONSTRAINT `fk_tualocms_page_middleware_middleware` FOREIGN KEY (`tualocms_middleware`) REFERENCES `tualocms_middleware` (`tualocms_middleware`) ON UPDATE CASCADE,
  CONSTRAINT `fk_tualocms_page_middleware_page` FOREIGN KEY (`tualocms_page`) REFERENCES `tualocms_page` (`tualocms_page`) ON UPDATE CASCADE
);
