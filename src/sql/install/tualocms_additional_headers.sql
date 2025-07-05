
CREATE TABLE IF NOT EXISTS `tualocms_additional_headers` (
  `header_key` varchar(100) NOT NULL,
  `header_value` varchar(255) DEFAULT NULL,
  `valid_from` datetime NOT NULL DEFAULT current_timestamp(),
  `valid_until` datetime NOT NULL DEFAULT '2099-12-31 23:59:59',
  PRIMARY KEY (`header_key`)
) ;

INSERT IGNORE INTO `tualocms_additional_headers` VALUES
('Access-Control-Allow-Credentials','true','2025-01-01 01:00:00','2099-12-31 23:59:59'),
('Access-Control-Allow-Origin','*','2025-01-01 01:00:00','2099-12-31 23:59:59');

