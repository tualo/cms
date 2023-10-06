DELIMITER ;
CREATE TABLE IF NOT EXISTS `tualocms_attribute` (
  `tualocms_attribute` varchar(36) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`tualocms_attribute`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
