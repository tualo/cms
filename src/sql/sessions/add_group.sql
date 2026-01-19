delimiter ;

insert ignore into SESSIONDB.macc_groups (name,aktiv) values ('public-cms',1);


INSERT IGNORE INTO `ds_access` (`append`,`delete`,`read`,`role`,`table_name`,`write`) VALUES ('0','0','1','public-cms','view_load_tualocms_page','0') ; 
INSERT IGNORE INTO `ds_access` (`append`,`delete`,`read`,`role`,`table_name`,`write`) VALUES ('0','0','1','public-cms','view_load_tualocms_page_csp','0') ; 
INSERT IGNORE INTO `ds_access` (`append`,`delete`,`read`,`role`,`table_name`,`write`) VALUES ('0','0','1','public-cms','view_load_tualocms_page_headers','0') ; 
INSERT IGNORE INTO `ds_access` (`append`,`delete`,`read`,`role`,`table_name`,`write`) VALUES ('0','0','1','public-cms','view_load_tualocms_page_permission_policy','0') ; 
INSERT IGNORE INTO `ds_access` (`append`,`delete`,`read`,`role`,`table_name`,`write`) VALUES ('0','0','1','public-cms','tualocms_additional_headers','0') ; 
 
insert ignore into route_scopes(scope) values ('cms.page');
insert ignore into route_scopes_permissions (scope,`group`,allowed) values ('cms.page', 'public-cms', 1);