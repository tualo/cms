LOCK TABLES `ds` WRITE;
INSERT INTO `ds` (`table_name`, `title`, `reorderfield`, `use_history`, `searchfield`, `displayfield`, `sortfield`, `searchany`, `hint`, `overview_tpl`, `sync_table`, `writetable`, `globalsearch`, `listselectionmodel`, `sync_view`, `syncable`, `cssstyle`, `alternativeformxtype`, `read_table`, `class_name`, `special_add_panel`, `existsreal`, `character_set_name`, `read_filter`, `listxtypeprefix`, `phpexporter`, `phpexporterfilename`, `combined`, `default_pagesize`, `allowForm`, `listviewbaseclass`, `showactionbtn`, `modelbaseclass`) VALUES ('tualocms_attribute','CMS - verfügbare Attribute','',0,'name','name','name',1,'','','','',1,'cellmodel','',0,'','','','Content-Management-System','',1,'','','','XlsxWriter','tualocms_attribute {DATE} {TIME}',0,1000,0,'Tualo.DataSets.ListView',1,'Tualo.DataSets.model.Basic');
UNLOCK TABLES;
LOCK TABLES `ds_column` WRITE;
INSERT INTO `ds_column` (`table_name`, `column_name`, `default_value`, `default_max_value`, `default_min_value`, `update_value`, `is_primary`, `syncable`, `referenced_table`, `referenced_column_name`, `is_nullable`, `is_referenced`, `writeable`, `note`, `data_type`, `column_key`, `column_type`, `character_maximum_length`, `numeric_precision`, `numeric_scale`, `character_set_name`, `privileges`, `existsreal`, `deferedload`, `hint`, `fieldtype`) VALUES ('tualocms_attribute','name',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'YES',NULL,1,NULL,'varchar','','varchar(255)',255,NULL,NULL,'utf8mb4','select,insert,update,references',1,NULL,NULL,''),
('tualocms_attribute','tualocms_attribute','{:uuid()}',0,0,'',1,0,'','','NO','',1,'','varchar','PRI','varchar(36)',36,0,0,'utf8mb4','select,insert,update,references',1,0,'','');
UNLOCK TABLES;
LOCK TABLES `ds_column_list_label` WRITE;
INSERT INTO `ds_column_list_label` (`table_name`, `column_name`, `language`, `label`, `xtype`, `editor`, `position`, `summaryrenderer`, `renderer`, `summarytype`, `hidden`, `active`, `filterstore`, `grouped`, `flex`, `direction`, `align`, `listfiltertype`, `hint`) VALUES ('tualocms_attribute','name','DE','Name','gridcolumn',NULL,1,'','','',0,1,'',0,1.00,'ASC','left','',NULL),
('tualocms_attribute','tualocms_attribute','DE','Attribute','gridcolumn',NULL,0,'','','',0,1,'',0,1.00,'ASC','left','',NULL);
UNLOCK TABLES;
LOCK TABLES `ds_column_form_label` WRITE;
INSERT INTO `ds_column_form_label` (`table_name`, `column_name`, `language`, `label`, `xtype`, `field_path`, `position`, `hidden`, `active`, `allowempty`, `fieldgroup`, `flex`, `hint`) VALUES ('tualocms_attribute','name','DE','Name','textfield','Allgemein/Angaben',1,0,1,0,'1',1.00,'\'\''),
('tualocms_attribute','tualocms_attribute','DE','Attribute','displayfield','Allgemein/Angaben',0,0,1,1,'1',1.00,'\'\'');
UNLOCK TABLES;
LOCK TABLES `ds_dropdownfields` WRITE;
INSERT INTO `ds_dropdownfields` (`table_name`, `name`, `idfield`, `displayfield`, `filterconfig`) VALUES ('tualocms_attribute','tualocms_attribute','tualocms_attribute','name','');
UNLOCK TABLES;
LOCK TABLES `ds_reference_tables` WRITE;
UNLOCK TABLES;
LOCK TABLES `ds_addcommands` WRITE;
UNLOCK TABLES;
LOCK TABLES `ds_access` WRITE;
INSERT INTO `ds_access` (`role`, `table_name`, `read`, `write`, `delete`, `append`, `existsreal`) VALUES ('administration','tualocms_attribute',1,1,1,1,0);
UNLOCK TABLES;
LOCK TABLES `ds` WRITE;
INSERT INTO `ds` (`table_name`, `title`, `reorderfield`, `use_history`, `searchfield`, `displayfield`, `sortfield`, `searchany`, `hint`, `overview_tpl`, `sync_table`, `writetable`, `globalsearch`, `listselectionmodel`, `sync_view`, `syncable`, `cssstyle`, `alternativeformxtype`, `read_table`, `class_name`, `special_add_panel`, `existsreal`, `character_set_name`, `read_filter`, `listxtypeprefix`, `phpexporter`, `phpexporterfilename`, `combined`, `default_pagesize`, `allowForm`, `listviewbaseclass`, `showactionbtn`, `modelbaseclass`) VALUES ('tualocms_middleware','CMS - verfügbare Middlewares','',0,'tualocms_middleware','tualocms_middleware','tualocms_middleware',1,'','','','',1,'cellmodel','',0,'','','','Content-Management-System','',1,'','','','XlsxWriter','tualocms_middleware {DATE} {TIME}',0,1000,0,'Tualo.DataSets.ListView',1,'Tualo.DataSets.model.Basic');
UNLOCK TABLES;
LOCK TABLES `ds_column` WRITE;
INSERT INTO `ds_column` (`table_name`, `column_name`, `default_value`, `default_max_value`, `default_min_value`, `update_value`, `is_primary`, `syncable`, `referenced_table`, `referenced_column_name`, `is_nullable`, `is_referenced`, `writeable`, `note`, `data_type`, `column_key`, `column_type`, `character_maximum_length`, `numeric_precision`, `numeric_scale`, `character_set_name`, `privileges`, `existsreal`, `deferedload`, `hint`, `fieldtype`) VALUES ('tualocms_middleware','tualocms_middleware',NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,'NO',NULL,1,NULL,'varchar','PRI','varchar(50)',50,NULL,NULL,'utf8mb4','select,insert,update,references',1,NULL,NULL,'');
UNLOCK TABLES;
LOCK TABLES `ds_column_list_label` WRITE;
INSERT INTO `ds_column_list_label` (`table_name`, `column_name`, `language`, `label`, `xtype`, `editor`, `position`, `summaryrenderer`, `renderer`, `summarytype`, `hidden`, `active`, `filterstore`, `grouped`, `flex`, `direction`, `align`, `listfiltertype`, `hint`) VALUES ('tualocms_middleware','tualocms_middleware','DE','Middleware','gridcolumn',NULL,999,'','','',0,1,'',0,1.00,'ASC','left','',NULL);
UNLOCK TABLES;
LOCK TABLES `ds_column_form_label` WRITE;
INSERT INTO `ds_column_form_label` (`table_name`, `column_name`, `language`, `label`, `xtype`, `field_path`, `position`, `hidden`, `active`, `allowempty`, `fieldgroup`, `flex`, `hint`) VALUES ('tualocms_middleware','tualocms_middleware','DE','Middleware','textfield','Allgemein/Angaben',999,0,1,0,'1',1.00,'\'\'');
UNLOCK TABLES;
LOCK TABLES `ds_dropdownfields` WRITE;
INSERT INTO `ds_dropdownfields` (`table_name`, `name`, `idfield`, `displayfield`, `filterconfig`) VALUES ('tualocms_middleware','tualocms_middleware','tualocms_middleware','tualocms_middleware','');
UNLOCK TABLES;
LOCK TABLES `ds_reference_tables` WRITE;
UNLOCK TABLES;
LOCK TABLES `ds_addcommands` WRITE;
UNLOCK TABLES;
LOCK TABLES `ds_access` WRITE;
INSERT INTO `ds_access` (`role`, `table_name`, `read`, `write`, `delete`, `append`, `existsreal`) VALUES ('administration','tualocms_middleware',1,1,1,1,0);
UNLOCK TABLES;
LOCK TABLES `ds` WRITE;
INSERT INTO `ds` (`table_name`, `title`, `reorderfield`, `use_history`, `searchfield`, `displayfield`, `sortfield`, `searchany`, `hint`, `overview_tpl`, `sync_table`, `writetable`, `globalsearch`, `listselectionmodel`, `sync_view`, `syncable`, `cssstyle`, `alternativeformxtype`, `read_table`, `class_name`, `special_add_panel`, `existsreal`, `character_set_name`, `read_filter`, `listxtypeprefix`, `phpexporter`, `phpexporterfilename`, `combined`, `default_pagesize`, `allowForm`, `listviewbaseclass`, `showactionbtn`, `modelbaseclass`) VALUES ('tualocms_page','CMS - Seiten','',0,'title','title','title',1,'','','','',1,'cellmodel','',0,'','','','Content-Management-System','',1,'','','','XlsxWriter','tualocms_page {DATE} {TIME}',0,1000,0,'Tualo.DataSets.ListView',1,'Tualo.DataSets.model.Basic');
UNLOCK TABLES;
LOCK TABLES `ds_column` WRITE;
INSERT INTO `ds_column` (`table_name`, `column_name`, `default_value`, `default_max_value`, `default_min_value`, `update_value`, `is_primary`, `syncable`, `referenced_table`, `referenced_column_name`, `is_nullable`, `is_referenced`, `writeable`, `note`, `data_type`, `column_key`, `column_type`, `character_maximum_length`, `numeric_precision`, `numeric_scale`, `character_set_name`, `privileges`, `existsreal`, `deferedload`, `hint`, `fieldtype`) VALUES ('tualocms_page','content',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'YES',NULL,1,NULL,'longtext','','longtext',4294967295,NULL,NULL,'utf8mb4','select,insert,update,references',1,NULL,NULL,''),
('tualocms_page','path',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'NO',NULL,1,NULL,'varchar','','varchar(255)',255,NULL,NULL,'utf8mb4','select,insert,update,references',1,NULL,NULL,''),
('tualocms_page','pug_file',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'YES',NULL,1,NULL,'varchar','MUL','varchar(50)',50,NULL,NULL,'utf8mb4','select,insert,update,references',1,NULL,NULL,''),
('tualocms_page','title',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'YES',NULL,1,NULL,'longtext','','longtext',4294967295,NULL,NULL,'utf8mb4','select,insert,update,references',1,NULL,NULL,''),
('tualocms_page','tualocms_page','{:uuid()}',0,0,'',1,0,'','','NO','',1,'','varchar','PRI','varchar(36)',36,0,0,'utf8mb4','select,insert,update,references',1,0,'',''),
('tualocms_page','valid_from','{:now()}',0,0,'',0,0,'','','NO','',1,'','datetime','','datetime',0,0,0,'','select,insert,update,references',1,0,'',''),
('tualocms_page','valid_until','2099-12-31 23:59:59',0,0,'',0,0,'','','NO','',1,'','datetime','','datetime',0,0,0,'','select,insert,update,references',1,0,'','');
UNLOCK TABLES;
LOCK TABLES `ds_column_list_label` WRITE;
INSERT INTO `ds_column_list_label` (`table_name`, `column_name`, `language`, `label`, `xtype`, `editor`, `position`, `summaryrenderer`, `renderer`, `summarytype`, `hidden`, `active`, `filterstore`, `grouped`, `flex`, `direction`, `align`, `listfiltertype`, `hint`) VALUES ('tualocms_page','content','DE','Inhalt','gridcolumn','',4,'','','',1,1,'',0,1.00,'','left','','NULL'),
('tualocms_page','path','DE','Pfad','gridcolumn',NULL,1,'','','',0,1,'',0,1.00,'ASC','left','',NULL),
('tualocms_page','pug_file','DE','Template','column_ds_pug_templates_id',NULL,2,'','','',0,1,'',0,1.00,'ASC','left','',NULL),
('tualocms_page','title','DE','Titel','gridcolumn',NULL,3,'','','',0,1,'',0,1.00,'ASC','left','',NULL),
('tualocms_page','tualocms_page','DE','ID','gridcolumn',NULL,0,'','','',0,1,'',0,1.00,'ASC','left','',NULL),
('tualocms_page','valid_from','DE','von','gridcolumn',NULL,5,'','','',0,1,'',0,1.00,'ASC','left','',NULL),
('tualocms_page','valid_until','DE','bis','gridcolumn',NULL,6,'','','',0,1,'',0,1.00,'ASC','left','',NULL);
UNLOCK TABLES;
LOCK TABLES `ds_column_form_label` WRITE;
INSERT INTO `ds_column_form_label` (`table_name`, `column_name`, `language`, `label`, `xtype`, `field_path`, `position`, `hidden`, `active`, `allowempty`, `fieldgroup`, `flex`, `hint`) VALUES ('tualocms_page','content','DE','Inhalt','cherrymarkdown','Allgemein/Angaben',4,0,1,1,'1',1.00,'\'\''),
('tualocms_page','path','DE','Pfad','textfield','Allgemein/Angaben',1,0,1,0,'1',1.00,'\'\''),
('tualocms_page','pug_file','DE','Template','combobox_ds_pug_templates_id','Allgemein/Angaben',2,0,1,0,'1',1.00,'\'\''),
('tualocms_page','title','DE','Titel','textfield','Allgemein/Angaben',3,0,1,0,'1',1.00,'\'\''),
('tualocms_page','tualocms_page','DE','ID','displayfield','Allgemein/Angaben',0,0,1,0,'1',1.00,'\'\''),
('tualocms_page','valid_from','DE','von','datetimefield','Allgemein/Angaben',5,0,1,1,'1',1.00,'\'\''),
('tualocms_page','valid_until','DE','bis','datetimefield','Allgemein/Angaben',6,0,1,1,'1',1.00,'\'\'');
UNLOCK TABLES;
LOCK TABLES `ds_dropdownfields` WRITE;
INSERT INTO `ds_dropdownfields` (`table_name`, `name`, `idfield`, `displayfield`, `filterconfig`) VALUES ('tualocms_page','tualocms_page','tualocms_page','title','');
UNLOCK TABLES;
LOCK TABLES `ds_reference_tables` WRITE;
INSERT INTO `ds_reference_tables` (`table_name`, `reference_table_name`, `columnsdef`, `constraint_name`, `active`, `searchable`, `autosync`, `position`, `path`, `existsreal`, `tabtitle`) VALUES ('tualocms_page','ds_pug_templates','{\"pug_file\":\"id\"}','fk_tualocms_page_pug_file',0,0,0,999,'',1,'');
UNLOCK TABLES;
LOCK TABLES `ds_addcommands` WRITE;
UNLOCK TABLES;
LOCK TABLES `ds_access` WRITE;
INSERT INTO `ds_access` (`role`, `table_name`, `read`, `write`, `delete`, `append`, `existsreal`) VALUES ('administration','tualocms_page',1,1,1,1,0);
UNLOCK TABLES;
LOCK TABLES `ds` WRITE;
INSERT INTO `ds` (`table_name`, `title`, `reorderfield`, `use_history`, `searchfield`, `displayfield`, `sortfield`, `searchany`, `hint`, `overview_tpl`, `sync_table`, `writetable`, `globalsearch`, `listselectionmodel`, `sync_view`, `syncable`, `cssstyle`, `alternativeformxtype`, `read_table`, `class_name`, `special_add_panel`, `existsreal`, `character_set_name`, `read_filter`, `listxtypeprefix`, `phpexporter`, `phpexporterfilename`, `combined`, `default_pagesize`, `allowForm`, `listviewbaseclass`, `showactionbtn`, `modelbaseclass`) VALUES ('tualocms_section','CMS - Abschnitte','',0,'title','title','title',1,'','','','',1,'cellmodel','',0,'','','','Content-Management-System','',1,'','','','XlsxWriter','tualocms_section {DATE} {TIME}',0,1000,0,'Tualo.DataSets.ListView',1,'Tualo.DataSets.model.Basic');
UNLOCK TABLES;
LOCK TABLES `ds_column` WRITE;
INSERT INTO `ds_column` (`table_name`, `column_name`, `default_value`, `default_max_value`, `default_min_value`, `update_value`, `is_primary`, `syncable`, `referenced_table`, `referenced_column_name`, `is_nullable`, `is_referenced`, `writeable`, `note`, `data_type`, `column_key`, `column_type`, `character_maximum_length`, `numeric_precision`, `numeric_scale`, `character_set_name`, `privileges`, `existsreal`, `deferedload`, `hint`, `fieldtype`) VALUES ('tualocms_section','content',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'YES',NULL,1,NULL,'longtext','','longtext',4294967295,NULL,NULL,'utf8mb4','select,insert,update,references',1,NULL,NULL,''),
('tualocms_section','pug_file',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'YES',NULL,1,NULL,'varchar','MUL','varchar(50)',50,NULL,NULL,'utf8mb4','select,insert,update,references',1,NULL,NULL,''),
('tualocms_section','title',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'YES',NULL,1,NULL,'longtext','','longtext',4294967295,NULL,NULL,'utf8mb4','select,insert,update,references',1,NULL,NULL,''),
('tualocms_section','tualocms_section','{:uuid()}',0,0,'',1,0,'','','NO','',1,'','varchar','PRI','varchar(36)',36,0,0,'utf8mb4','select,insert,update,references',1,0,'',''),
('tualocms_section','valid_from','2023-01-01 00:00:00',0,0,'',0,0,'','','NO','',1,'','datetime','','datetime',0,0,0,'','select,insert,update,references',1,0,'',''),
('tualocms_section','valid_until','2023-12-31 23:59:59',0,0,'',0,0,'','','NO','',1,'','datetime','','datetime',0,0,0,'','select,insert,update,references',1,0,'','');
UNLOCK TABLES;
LOCK TABLES `ds_column_list_label` WRITE;
INSERT INTO `ds_column_list_label` (`table_name`, `column_name`, `language`, `label`, `xtype`, `editor`, `position`, `summaryrenderer`, `renderer`, `summarytype`, `hidden`, `active`, `filterstore`, `grouped`, `flex`, `direction`, `align`, `listfiltertype`, `hint`) VALUES ('tualocms_section','content','DE','Inhalt','gridcolumn',NULL,2,'','','',0,1,'',0,1.00,'ASC','left','',NULL),
('tualocms_section','pug_file','DE','Template','column_ds_pug_templates_id',NULL,3,'','','',0,1,'',0,1.00,'ASC','left','',NULL),
('tualocms_section','title','DE','Titel','gridcolumn',NULL,1,'','','',0,1,'',0,1.00,'ASC','left','',NULL),
('tualocms_section','tualocms_section','DE','ID','gridcolumn',NULL,0,'','','',0,1,'',0,1.00,'ASC','left','',NULL),
('tualocms_section','valid_from','DE','von','gridcolumn',NULL,4,'','','',0,1,'',0,1.00,'ASC','left','',NULL),
('tualocms_section','valid_until','DE','bis','gridcolumn',NULL,5,'','','',0,1,'',0,1.00,'ASC','left','',NULL);
UNLOCK TABLES;
LOCK TABLES `ds_column_form_label` WRITE;
INSERT INTO `ds_column_form_label` (`table_name`, `column_name`, `language`, `label`, `xtype`, `field_path`, `position`, `hidden`, `active`, `allowempty`, `fieldgroup`, `flex`, `hint`) VALUES ('tualocms_section','content','DE','Inhalt','cherrymarkdown','Allgemein/Angaben',2,0,1,0,'1',1.00,'\'\''),
('tualocms_section','pug_file','DE','Template','combobox_ds_pug_templates_id','Allgemein/Angaben',3,0,1,0,'1',1.00,'\'\''),
('tualocms_section','title','DE','Titel','textfield','Allgemein/Angaben',1,0,1,0,'1',1.00,'\'\''),
('tualocms_section','tualocms_section','DE','ID','displayfield','Allgemein/Angaben',0,0,1,0,'1',1.00,'\'\''),
('tualocms_section','valid_from','DE','von','datetimefield','Allgemein/Angaben',4,0,1,0,'1',1.00,'\'\''),
('tualocms_section','valid_until','DE','bis','datetimefield','Allgemein/Angaben',5,0,1,0,'1',1.00,'\'\'');
UNLOCK TABLES;
LOCK TABLES `ds_dropdownfields` WRITE;
INSERT INTO `ds_dropdownfields` (`table_name`, `name`, `idfield`, `displayfield`, `filterconfig`) VALUES ('tualocms_section','tualocms_section','tualocms_section','title','');
UNLOCK TABLES;
LOCK TABLES `ds_reference_tables` WRITE;
INSERT INTO `ds_reference_tables` (`table_name`, `reference_table_name`, `columnsdef`, `constraint_name`, `active`, `searchable`, `autosync`, `position`, `path`, `existsreal`, `tabtitle`) VALUES ('tualocms_section','ds_pug_templates','{\"pug_file\":\"id\"}','fk_tualocms_section_pug_file',0,0,0,999,'',1,'');
UNLOCK TABLES;
LOCK TABLES `ds_addcommands` WRITE;
UNLOCK TABLES;
LOCK TABLES `ds_access` WRITE;
INSERT INTO `ds_access` (`role`, `table_name`, `read`, `write`, `delete`, `append`, `existsreal`) VALUES ('administration','tualocms_section',1,1,1,1,0);
UNLOCK TABLES;
LOCK TABLES `ds` WRITE;
INSERT INTO `ds` (`table_name`, `title`, `reorderfield`, `use_history`, `searchfield`, `displayfield`, `sortfield`, `searchany`, `hint`, `overview_tpl`, `sync_table`, `writetable`, `globalsearch`, `listselectionmodel`, `sync_view`, `syncable`, `cssstyle`, `alternativeformxtype`, `read_table`, `class_name`, `special_add_panel`, `existsreal`, `character_set_name`, `read_filter`, `listxtypeprefix`, `phpexporter`, `phpexporterfilename`, `combined`, `default_pagesize`, `allowForm`, `listviewbaseclass`, `showactionbtn`, `modelbaseclass`) VALUES ('tualocms_page_middleware','CMS - Seitenmiddleware','position',0,'tualocms_middleware','tualocms_middleware','position',0,'','','','',0,'cellmodel','',0,'','','','Content-Management-System','',1,'','','','XlsxWriter','tualocms_page_middleware {DATE} {TIME}',0,1000,0,'Tualo.DataSets.ListView',1,'Tualo.DataSets.model.Basic');
UNLOCK TABLES;
LOCK TABLES `ds_column` WRITE;
INSERT INTO `ds_column` (`table_name`, `column_name`, `default_value`, `default_max_value`, `default_min_value`, `update_value`, `is_primary`, `syncable`, `referenced_table`, `referenced_column_name`, `is_nullable`, `is_referenced`, `writeable`, `note`, `data_type`, `column_key`, `column_type`, `character_maximum_length`, `numeric_precision`, `numeric_scale`, `character_set_name`, `privileges`, `existsreal`, `deferedload`, `hint`, `fieldtype`) VALUES ('tualocms_page_middleware','position','999',0,0,'',0,0,'','','YES','',1,'','int','','int(11)',0,10,0,'','select,insert,update,references',1,0,'',''),
('tualocms_page_middleware','tualocms_middleware',NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,'NO',NULL,1,NULL,'varchar','PRI','varchar(50)',50,NULL,NULL,'utf8mb4','select,insert,update,references',1,NULL,NULL,''),
('tualocms_page_middleware','tualocms_page',NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,'NO',NULL,1,NULL,'varchar','PRI','varchar(36)',36,NULL,NULL,'utf8mb4','select,insert,update,references',1,NULL,NULL,''),
('tualocms_page_middleware','valid_from','2023-01-01 00:00:00',0,0,'',0,0,'','','NO','',1,'','datetime','','datetime',0,0,0,'','select,insert,update,references',1,0,'',''),
('tualocms_page_middleware','valid_until','2099-12-31 23:59:59',0,0,'',0,0,'','','NO','',1,'','datetime','','datetime',0,0,0,'','select,insert,update,references',1,0,'','');
UNLOCK TABLES;
LOCK TABLES `ds_column_list_label` WRITE;
INSERT INTO `ds_column_list_label` (`table_name`, `column_name`, `language`, `label`, `xtype`, `editor`, `position`, `summaryrenderer`, `renderer`, `summarytype`, `hidden`, `active`, `filterstore`, `grouped`, `flex`, `direction`, `align`, `listfiltertype`, `hint`) VALUES ('tualocms_page_middleware','position','DE','Position','gridcolumn','',0,'number','','count',0,1,'',0,1.00,'','left','','NULL'),
('tualocms_page_middleware','tualocms_middleware','DE','Middleware','column_tualocms_middleware_tualocms_middleware',NULL,2,'','','',0,1,'',0,1.00,'ASC','left','',NULL),
('tualocms_page_middleware','tualocms_page','DE','Seite','column_tualocms_page_tualocms_page',NULL,1,'','','',0,1,'',0,1.00,'ASC','left','',NULL),
('tualocms_page_middleware','valid_from','DE','Von','gridcolumn',NULL,3,'','','',0,1,'',0,1.00,'ASC','left','',NULL),
('tualocms_page_middleware','valid_until','DE','Bis','gridcolumn',NULL,4,'','','',0,1,'',0,1.00,'ASC','left','',NULL);
UNLOCK TABLES;
LOCK TABLES `ds_column_form_label` WRITE;
INSERT INTO `ds_column_form_label` (`table_name`, `column_name`, `language`, `label`, `xtype`, `field_path`, `position`, `hidden`, `active`, `allowempty`, `fieldgroup`, `flex`, `hint`) VALUES ('tualocms_page_middleware','position','DE','Position','displayfield','Allgemein/Angaben',0,0,1,0,'1',1.00,'\'\''),
('tualocms_page_middleware','tualocms_middleware','DE','Middleware','combobox_tualocms_middleware_tualocms_middleware','Allgemein/Angaben',2,0,1,0,'1',1.00,'\'\''),
('tualocms_page_middleware','tualocms_page','DE','Seite','combobox_tualocms_page_tualocms_page','Allgemein/Angaben',1,0,1,0,'1',1.00,'\'\''),
('tualocms_page_middleware','valid_from','DE','Von','datetimefield','Allgemein/Angaben',3,0,1,0,'Aktiv',1.00,'\'\''),
('tualocms_page_middleware','valid_until','DE','Bis','datetimefield','Allgemein/Angaben',4,0,1,0,'Aktiv',1.00,'\'\'');
UNLOCK TABLES;
LOCK TABLES `ds_dropdownfields` WRITE;
UNLOCK TABLES;
LOCK TABLES `ds_reference_tables` WRITE;
INSERT INTO `ds_reference_tables` (`table_name`, `reference_table_name`, `columnsdef`, `constraint_name`, `active`, `searchable`, `autosync`, `position`, `path`, `existsreal`, `tabtitle`) VALUES ('tualocms_page_middleware','tualocms_middleware','{\"tualocms_middleware\":\"tualocms_middleware\"}','fk_tualocms_page_middleware_middleware',0,0,0,999,'',1,''),
('tualocms_page_middleware','tualocms_middleware','{\"tualocms_middleware\":\"tualocms_middleware\"}','fk_tualocms_page_middleware_middleware',1,0,0,999,'',1,''),
('tualocms_page_middleware','tualocms_page','{\"tualocms_page\":\"tualocms_page\"}','fk_tualocms_page_middleware_page',0,0,0,999,'',1,''),
('tualocms_page_middleware','tualocms_page','{\"tualocms_page\":\"tualocms_page\"}','fk_tualocms_page_middleware_page',1,0,0,999,'',1,'');
UNLOCK TABLES;
LOCK TABLES `ds_addcommands` WRITE;
UNLOCK TABLES;
LOCK TABLES `ds_access` WRITE;
INSERT INTO `ds_access` (`role`, `table_name`, `read`, `write`, `delete`, `append`, `existsreal`) VALUES ('administration','tualocms_page_middleware',1,1,1,1,0);
UNLOCK TABLES;
LOCK TABLES `ds` WRITE;
INSERT INTO `ds` (`table_name`, `title`, `reorderfield`, `use_history`, `searchfield`, `displayfield`, `sortfield`, `searchany`, `hint`, `overview_tpl`, `sync_table`, `writetable`, `globalsearch`, `listselectionmodel`, `sync_view`, `syncable`, `cssstyle`, `alternativeformxtype`, `read_table`, `class_name`, `special_add_panel`, `existsreal`, `character_set_name`, `read_filter`, `listxtypeprefix`, `phpexporter`, `phpexporterfilename`, `combined`, `default_pagesize`, `allowForm`, `listviewbaseclass`, `showactionbtn`, `modelbaseclass`) VALUES ('tualocms_section_tualocms_attributes','CMS - Abschnitte-Attribute','position',0,'tualocms_attribute','tualocms_attribute','position',0,'','','','',0,'cellmodel','',0,'','','','Content-Management-System','',1,'','','','XlsxWriter','tualocms_section_tualocms_attributes {DATE} {TIME}',0,1000,0,'Tualo.DataSets.ListView',1,'Tualo.DataSets.model.Basic');
UNLOCK TABLES;
LOCK TABLES `ds_column` WRITE;
INSERT INTO `ds_column` (`table_name`, `column_name`, `default_value`, `default_max_value`, `default_min_value`, `update_value`, `is_primary`, `syncable`, `referenced_table`, `referenced_column_name`, `is_nullable`, `is_referenced`, `writeable`, `note`, `data_type`, `column_key`, `column_type`, `character_maximum_length`, `numeric_precision`, `numeric_scale`, `character_set_name`, `privileges`, `existsreal`, `deferedload`, `hint`, `fieldtype`) VALUES ('tualocms_section_tualocms_attributes','position','999',0,0,'',0,0,'','','YES','',1,'','int','','int(11)',0,10,0,'','select,insert,update,references',1,0,'',''),
('tualocms_section_tualocms_attributes','tualocms_attribute',NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,'NO',NULL,1,NULL,'varchar','PRI','varchar(36)',36,NULL,NULL,'utf8mb4','select,insert,update,references',1,NULL,NULL,''),
('tualocms_section_tualocms_attributes','tualocms_section',NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,'NO',NULL,1,NULL,'varchar','PRI','varchar(36)',36,NULL,NULL,'utf8mb4','select,insert,update,references',1,NULL,NULL,''),
('tualocms_section_tualocms_attributes','valid_from','2023-01-01 00:00:00',0,0,'',0,0,'','','NO','',1,'','datetime','','datetime',0,0,0,'','select,insert,update,references',1,0,'',''),
('tualocms_section_tualocms_attributes','valid_until','2099-12-31 23:59:59',0,0,'',0,0,'','','NO','',1,'','datetime','','datetime',0,0,0,'','select,insert,update,references',1,0,'','');
UNLOCK TABLES;
LOCK TABLES `ds_column_list_label` WRITE;
INSERT INTO `ds_column_list_label` (`table_name`, `column_name`, `language`, `label`, `xtype`, `editor`, `position`, `summaryrenderer`, `renderer`, `summarytype`, `hidden`, `active`, `filterstore`, `grouped`, `flex`, `direction`, `align`, `listfiltertype`, `hint`) VALUES ('tualocms_section_tualocms_attributes','position','DE','Position','gridcolumn',NULL,0,'','','',0,1,'',0,1.00,'ASC','left','',NULL),
('tualocms_section_tualocms_attributes','tualocms_attribute','DE','Attribut','column_tualocms_attribute_tualocms_attribute',NULL,2,'','','',0,1,'',0,1.00,'ASC','left','',NULL),
('tualocms_section_tualocms_attributes','tualocms_section','DE','Abschnitt','column_tualocms_section_tualocms_section',NULL,1,'','','',0,1,'',0,1.00,'ASC','left','',NULL),
('tualocms_section_tualocms_attributes','valid_from','DE','von','gridcolumn',NULL,3,'','','',0,1,'',0,1.00,'ASC','left','',NULL),
('tualocms_section_tualocms_attributes','valid_until','DE','bis','gridcolumn',NULL,4,'','','',0,1,'',0,1.00,'ASC','left','',NULL);
UNLOCK TABLES;
LOCK TABLES `ds_column_form_label` WRITE;
INSERT INTO `ds_column_form_label` (`table_name`, `column_name`, `language`, `label`, `xtype`, `field_path`, `position`, `hidden`, `active`, `allowempty`, `fieldgroup`, `flex`, `hint`) VALUES ('tualocms_section_tualocms_attributes','position','DE','Position','displayfield','Allgemein/Angaben',0,0,1,0,'1',1.00,'\'\''),
('tualocms_section_tualocms_attributes','tualocms_attribute','DE','Attribut','combobox_tualocms_attribute_tualocms_attribute','Allgemein/Angaben',2,0,1,0,'1',1.00,'\'\''),
('tualocms_section_tualocms_attributes','tualocms_section','DE','Abschnitt','combobox_tualocms_section_tualocms_section','Allgemein/Angaben',1,0,1,0,'1',1.00,'\'\''),
('tualocms_section_tualocms_attributes','valid_from','DE','von','datetimefield','Allgemein/Angaben',3,0,1,0,'1',1.00,'\'\''),
('tualocms_section_tualocms_attributes','valid_until','DE','bis','datetimefield','Allgemein/Angaben',4,0,1,0,'1',1.00,'\'\'');
UNLOCK TABLES;
LOCK TABLES `ds_dropdownfields` WRITE;
UNLOCK TABLES;
LOCK TABLES `ds_reference_tables` WRITE;
INSERT INTO `ds_reference_tables` (`table_name`, `reference_table_name`, `columnsdef`, `constraint_name`, `active`, `searchable`, `autosync`, `position`, `path`, `existsreal`, `tabtitle`) VALUES ('tualocms_section_tualocms_attributes','tualocms_attribute','{\"tualocms_attribute\":\"tualocms_attribute\"}','fk_tualocms_section_tualocms_attributes_attribute',0,0,0,999,'',1,''),
('tualocms_section_tualocms_attributes','tualocms_attribute','{\"tualocms_attribute\":\"tualocms_attribute\"}','fk_tualocms_section_tualocms_attributes_attribute',1,0,0,999,'',1,''),
('tualocms_section_tualocms_attributes','tualocms_attribute','{\"tualocms_attribute\":\"tualocms_attribute\"}','fk_tualocms_section_tualocms_attributes_attribute',0,0,0,999,'',1,''),
('tualocms_section_tualocms_attributes','tualocms_attribute','{\"tualocms_attribute\":\"tualocms_attribute\"}','fk_tualocms_section_tualocms_attributes_attribute',1,0,0,999,'',1,''),
('tualocms_section_tualocms_attributes','tualocms_section','{\"tualocms_section\":\"tualocms_section\"}','fk_tualocms_section_tualocms_attributes_section',0,0,0,999,'',1,''),
('tualocms_section_tualocms_attributes','tualocms_section','{\"tualocms_section\":\"tualocms_section\"}','fk_tualocms_section_tualocms_attributes_section',1,0,0,999,'',1,''),
('tualocms_section_tualocms_attributes','tualocms_section','{\"tualocms_section\":\"tualocms_section\"}','fk_tualocms_section_tualocms_attributes_section',0,0,0,999,'',1,''),
('tualocms_section_tualocms_attributes','tualocms_section','{\"tualocms_section\":\"tualocms_section\"}','fk_tualocms_section_tualocms_attributes_section',1,0,0,999,'',1,'');
UNLOCK TABLES;
LOCK TABLES `ds_addcommands` WRITE;
UNLOCK TABLES;
LOCK TABLES `ds_access` WRITE;
INSERT INTO `ds_access` (`role`, `table_name`, `read`, `write`, `delete`, `append`, `existsreal`) VALUES ('administration','tualocms_section_tualocms_attributes',1,1,1,1,0);
UNLOCK TABLES;
LOCK TABLES `ds` WRITE;
INSERT INTO `ds` (`table_name`, `title`, `reorderfield`, `use_history`, `searchfield`, `displayfield`, `sortfield`, `searchany`, `hint`, `overview_tpl`, `sync_table`, `writetable`, `globalsearch`, `listselectionmodel`, `sync_view`, `syncable`, `cssstyle`, `alternativeformxtype`, `read_table`, `class_name`, `special_add_panel`, `existsreal`, `character_set_name`, `read_filter`, `listxtypeprefix`, `phpexporter`, `phpexporterfilename`, `combined`, `default_pagesize`, `allowForm`, `listviewbaseclass`, `showactionbtn`, `modelbaseclass`) VALUES ('tualocms_section_tualocms_page','CMS - Seiten und Abschnitte','position',0,'tualocms_section','tualocms_section','position',0,'','','','',0,'cellmodel','',0,'','','','Content-Management-System','',1,'','','','XlsxWriter','tualocms_section_tualocms_page {DATE} {TIME}',0,1000,0,'Tualo.DataSets.ListView',1,'Tualo.DataSets.model.Basic');
UNLOCK TABLES;
LOCK TABLES `ds_column` WRITE;
INSERT INTO `ds_column` (`table_name`, `column_name`, `default_value`, `default_max_value`, `default_min_value`, `update_value`, `is_primary`, `syncable`, `referenced_table`, `referenced_column_name`, `is_nullable`, `is_referenced`, `writeable`, `note`, `data_type`, `column_key`, `column_type`, `character_maximum_length`, `numeric_precision`, `numeric_scale`, `character_set_name`, `privileges`, `existsreal`, `deferedload`, `hint`, `fieldtype`) VALUES ('tualocms_section_tualocms_page','position','999',0,0,'',0,0,'','','YES','',1,'','int','','int(11)',0,10,0,'','select,insert,update,references',1,0,'',''),
('tualocms_section_tualocms_page','tualocms_page',NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,'NO',NULL,1,NULL,'varchar','PRI','varchar(36)',36,NULL,NULL,'utf8mb4','select,insert,update,references',1,NULL,NULL,''),
('tualocms_section_tualocms_page','tualocms_section',NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,'NO',NULL,1,NULL,'varchar','PRI','varchar(36)',36,NULL,NULL,'utf8mb4','select,insert,update,references',1,NULL,NULL,''),
('tualocms_section_tualocms_page','valid_from','2023-01-01 00:00:00',0,0,'',0,0,'','','NO','',1,'','datetime','','datetime',0,0,0,'','select,insert,update,references',1,0,'',''),
('tualocms_section_tualocms_page','valid_until','2099-12-21 23:59:59',0,0,'',0,0,'','','NO','',1,'','datetime','','datetime',0,0,0,'','select,insert,update,references',1,0,'','');
UNLOCK TABLES;
LOCK TABLES `ds_column_list_label` WRITE;
INSERT INTO `ds_column_list_label` (`table_name`, `column_name`, `language`, `label`, `xtype`, `editor`, `position`, `summaryrenderer`, `renderer`, `summarytype`, `hidden`, `active`, `filterstore`, `grouped`, `flex`, `direction`, `align`, `listfiltertype`, `hint`) VALUES ('tualocms_section_tualocms_page','position','DE','Position','gridcolumn',NULL,0,'','','',0,1,'',0,1.00,'ASC','left','',NULL),
('tualocms_section_tualocms_page','tualocms_page','DE','Seite','column_tualocms_page_tualocms_page',NULL,2,'','','',0,1,'',0,1.00,'ASC','left','',NULL),
('tualocms_section_tualocms_page','tualocms_section','DE','Abschnitt','column_tualocms_section_tualocms_section',NULL,1,'','','',0,1,'',0,1.00,'ASC','left','',NULL),
('tualocms_section_tualocms_page','valid_from','DE','von','gridcolumn',NULL,3,'','','',0,1,'',0,1.00,'ASC','left','',NULL),
('tualocms_section_tualocms_page','valid_until','DE','bis','gridcolumn',NULL,4,'','','',0,1,'',0,1.00,'ASC','left','',NULL);
UNLOCK TABLES;
LOCK TABLES `ds_column_form_label` WRITE;
INSERT INTO `ds_column_form_label` (`table_name`, `column_name`, `language`, `label`, `xtype`, `field_path`, `position`, `hidden`, `active`, `allowempty`, `fieldgroup`, `flex`, `hint`) VALUES ('tualocms_section_tualocms_page','position','DE','Position','displayfield','Allgemein/Angaben',0,0,1,0,'1',1.00,'\'\''),
('tualocms_section_tualocms_page','tualocms_page','DE','Seite','combobox_tualocms_page_tualocms_page','Allgemein/Angaben',2,0,1,0,'1',1.00,'\'\''),
('tualocms_section_tualocms_page','tualocms_section','DE','Abschnitt','combobox_tualocms_section_tualocms_section','Allgemein/Angaben',1,0,1,0,'1',1.00,'\'\''),
('tualocms_section_tualocms_page','valid_from','DE','von','datetimefield','Allgemein/Angaben',3,0,1,0,'1',1.00,'\'\''),
('tualocms_section_tualocms_page','valid_until','DE','bis','datetimefield','Allgemein/Angaben',4,0,1,0,'1',1.00,'\'\'');
UNLOCK TABLES;
LOCK TABLES `ds_dropdownfields` WRITE;
UNLOCK TABLES;
LOCK TABLES `ds_reference_tables` WRITE;
INSERT INTO `ds_reference_tables` (`table_name`, `reference_table_name`, `columnsdef`, `constraint_name`, `active`, `searchable`, `autosync`, `position`, `path`, `existsreal`, `tabtitle`) VALUES ('tualocms_section_tualocms_page','tualocms_page','{\"tualocms_page\":\"tualocms_page\"}','fk_tualocms_section_tualocms_page_page',0,0,0,999,'',1,''),
('tualocms_section_tualocms_page','tualocms_page','{\"tualocms_page\":\"tualocms_page\"}','fk_tualocms_section_tualocms_page_page',1,0,0,999,'',1,''),
('tualocms_section_tualocms_page','tualocms_section','{\"tualocms_section\":\"tualocms_section\"}','fk_tualocms_section_tualocms_page_section',0,0,0,999,'',1,''),
('tualocms_section_tualocms_page','tualocms_section','{\"tualocms_section\":\"tualocms_section\"}','fk_tualocms_section_tualocms_page_section',1,0,0,999,'',1,'');
UNLOCK TABLES;
LOCK TABLES `ds_addcommands` WRITE;
UNLOCK TABLES;
LOCK TABLES `ds_access` WRITE;
INSERT INTO `ds_access` (`role`, `table_name`, `read`, `write`, `delete`, `append`, `existsreal`) VALUES ('administration','tualocms_section_tualocms_page',1,1,1,1,0);
UNLOCK TABLES;
LOCK TABLES `ds` WRITE;
INSERT INTO `ds` (`table_name`, `title`, `reorderfield`, `use_history`, `searchfield`, `displayfield`, `sortfield`, `searchany`, `hint`, `overview_tpl`, `sync_table`, `writetable`, `globalsearch`, `listselectionmodel`, `sync_view`, `syncable`, `cssstyle`, `alternativeformxtype`, `read_table`, `class_name`, `special_add_panel`, `existsreal`, `character_set_name`, `read_filter`, `listxtypeprefix`, `phpexporter`, `phpexporterfilename`, `combined`, `default_pagesize`, `allowForm`, `listviewbaseclass`, `showactionbtn`, `modelbaseclass`) VALUES ('view_load_tualocms_page','view_load_tualocms_page','',0,'path','path','',0,'','','','',0,'cellmodel','',0,'','','','Content-Management-System','',1,'','','','XlsxWriter','view_load_tualocms_page {DATE} {TIME}',0,1000,0,'Tualo.DataSets.ListView',1,'Tualo.DataSets.model.Basic');
UNLOCK TABLES;
LOCK TABLES `ds_column` WRITE;
INSERT INTO `ds_column` (`table_name`, `column_name`, `default_value`, `default_max_value`, `default_min_value`, `update_value`, `is_primary`, `syncable`, `referenced_table`, `referenced_column_name`, `is_nullable`, `is_referenced`, `writeable`, `note`, `data_type`, `column_key`, `column_type`, `character_maximum_length`, `numeric_precision`, `numeric_scale`, `character_set_name`, `privileges`, `existsreal`, `deferedload`, `hint`, `fieldtype`) VALUES ('view_load_tualocms_page','o',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'YES',NULL,0,NULL,'longtext','','longtext',4294967295,NULL,NULL,'utf8mb4','select,insert,update,references',0,NULL,NULL,''),
('view_load_tualocms_page','page',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'YES',NULL,1,NULL,'longtext','','longtext',4294967295,NULL,NULL,'utf8mb4','select,insert,update,references',1,NULL,NULL,''),
('view_load_tualocms_page','path','',0,0,'',1,0,'','','NO','',1,'','varchar','','varchar(255)',255,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,'',''),
('view_load_tualocms_page','pug_file',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'YES',NULL,1,NULL,'varchar','','varchar(50)',50,NULL,NULL,'utf8mb4','select,insert,update,references',1,NULL,NULL,''),
('view_load_tualocms_page','tualocms_page',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'NO',NULL,1,NULL,'varchar','','varchar(36)',36,NULL,NULL,'utf8mb4','select,insert,update,references',1,NULL,NULL,'');
UNLOCK TABLES;
LOCK TABLES `ds_column_list_label` WRITE;
INSERT INTO `ds_column_list_label` (`table_name`, `column_name`, `language`, `label`, `xtype`, `editor`, `position`, `summaryrenderer`, `renderer`, `summarytype`, `hidden`, `active`, `filterstore`, `grouped`, `flex`, `direction`, `align`, `listfiltertype`, `hint`) VALUES ('view_load_tualocms_page','o','DE','o','gridcolumn','',999,'','','',0,1,'',0,1.00,'','start','','NULL'),
('view_load_tualocms_page','path','DE','path','gridcolumn','',999,'','','',0,1,'',0,1.00,'','start','','NULL'),
('view_load_tualocms_page','pug_file','DE','pug_file','gridcolumn','',999,'','','',0,1,'',0,1.00,'','start','','NULL'),
('view_load_tualocms_page','tualocms_page','DE','tualocms_page','gridcolumn','',999,'','','',0,1,'',0,1.00,'','start','','NULL');
UNLOCK TABLES;
LOCK TABLES `ds_column_form_label` WRITE;
UNLOCK TABLES;
LOCK TABLES `ds_dropdownfields` WRITE;
UNLOCK TABLES;
LOCK TABLES `ds_reference_tables` WRITE;
UNLOCK TABLES;
LOCK TABLES `ds_addcommands` WRITE;
UNLOCK TABLES;
LOCK TABLES `ds_access` WRITE;
INSERT INTO `ds_access` (`role`, `table_name`, `read`, `write`, `delete`, `append`, `existsreal`) VALUES ('administration','view_load_tualocms_page',1,0,0,0,0);
UNLOCK TABLES;
