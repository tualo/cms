delimiter ;
set autocommit=0;
INSERT IGNORE INTO `tualocms_section` VALUES
('f42cd32e-f46f-11f0-b173-82529e98ead0','Willkommen','Mein Abschnit','2023-01-01 00:00:00','2099-12-31 23:59:00','page-section','');
commit;
set autocommit=0;
INSERT IGNORE INTO `tualocms_page` VALUES
('e4adce57-f46f-11f0-b173-82529e98ead0','/','page','2026-01-19 08:49:32','2099-12-31 23:59:59','Startseite','Mein Inhalt',1,'','','','','','');
commit;
set autocommit=0;
INSERT IGNORE INTO `tualocms_section_tualocms_page` VALUES
('e4adce57-f46f-11f0-b173-82529e98ead0','f42cd32e-f46f-11f0-b173-82529e98ead0',999,'2023-01-01 00:00:00','2099-12-21 23:59:59');
commit;
set autocommit=0;
INSERT IGNORE INTO `tualocms_page_permission_policy` VALUES
    ('e4adce57-f46f-11f0-b173-82529e98ead0','camera',7,1,'()','2026-01-19 08:51:28','2099-12-31 23:59:59'),
    ('e4adce57-f46f-11f0-b173-82529e98ead0','fullscreen',15,1,'()','2026-01-19 08:51:28','2099-12-31 23:59:59'),
    ('e4adce57-f46f-11f0-b173-82529e98ead0','geolocation',16,1,'()','2026-01-19 08:51:28','2099-12-31 23:59:59');
commit;
set autocommit=0;
INSERT IGNORE INTO `tualocms_page_csp` VALUES
    ('e4adce57-f46f-11f0-b173-82529e98ead0','base-uri',1,1,'\'self\'','2026-01-19 08:51:06','2099-12-31 23:59:59'),
    ('e4adce57-f46f-11f0-b173-82529e98ead0','default-src',5,1,'\'self\'','2026-01-19 08:51:06','2099-12-31 23:59:59'),
    ('e4adce57-f46f-11f0-b173-82529e98ead0','script-src',20,1,'\'self\'','2026-01-19 08:51:06','2099-12-31 23:59:59'),
    ('e4adce57-f46f-11f0-b173-82529e98ead0','style-src',23,1,'\'self\'','2026-01-19 08:51:06','2099-12-31 23:59:59');
commit;
set autocommit=0;
INSERT IGNORE INTO `tualocms_page_middleware` VALUES
('e4adce57-f46f-11f0-b173-82529e98ead0','\\Tualo\\Office\\CMS\\CMSMiddleware\\Markdown',999,'2023-01-01 00:00:00','2099-12-31 23:59:59');
commit;