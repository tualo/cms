
delimiter ;

CREATE TABLE IF NOT EXISTS `tualocms_csp` (
  `policy` varchar(50) NOT NULL,
  `default_value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`policy`)
);
insert ignore into `tualocms_csp` (`policy`,`default_value`) values
('default-src',"'self'"),
('script-src',"'self'"),
('style-src',"'self'"),
('img-src',"'self'"),
('connect-src',"'self'"),
('font-src',"'self'"),
('object-src',"'none'"),
('media-src',"'self'"),
('frame-src',"'self'"),
('child-src',"'self'"),
('manifest-src',"'self'"),
('worker-src',"'self'"),
('navigate-to',"'self'"),
('form-action',"'self'"),
('upgrade-insecure-requests',NULL),
('block-all-mixed-content',NULL),
('base-uri',"'self'"),
('report-uri',NULL),
('report-to',NULL),
('frame-ancestors',"'none'"),
('sandbox',NULL),
('script-src-elem',"'self'"),
('script-src-attr',"'self'"),
('style-src-elem',"'self'"),
('style-src-attr',"'self'"),
('form-enctype',"'application/x-www-form-urlencoded'"),
('form-method',"'get'");
