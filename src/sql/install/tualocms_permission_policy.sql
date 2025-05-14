
delimiter ;


CREATE TABLE IF NOT EXISTS `tualocms_permission_policy` (
  `policy` varchar(50) NOT NULL,
  `default_value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`policy`)
);
insert ignore into `tualocms_permission_policy` (`policy`,`default_value`) values
('accelerometer','()'),
('ambient-light-sensor','()'),
('attribution-reporting','()'),
('autoplay','()'),
('bluetooth','()'),
('browsing-topics','()'),
('camera','()'),
('compute-pressure','()'),
('cross-origin-isolated','()'),
('deferred-fetch','()'),
('deferred-fetch-minimal','()'),
('display-capture','()'),
('document-domain','()'),
('encrypted-media','()'),
('fullscreen','()'),
('geolocation','()'),
('gyroscope','()'),
('hid','()'),
('identity-credentials-get','()'),
('idle-detection','()'),
('local-fonts','()'),
('magnetometer','()'),
('microphone','()'),
('midi','()'),
('otp-credentials','()'),
('payment','()'),
('picture-in-picture','(self)'),
('publickey-credentials-create','(self)'),
('publickey-credentials-get','(self)'),
('screen-wake-lock','(self)'),
('serial','()'),
('storage-access','()'),
('summarizer','()'),
('usb','()'),
('web-share','(self)'),
('window-management','()'),
('xr-spatial-tracking','()')

;
