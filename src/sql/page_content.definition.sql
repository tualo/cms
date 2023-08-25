LOCK TABLES `ds` WRITE;
INSERT INTO `ds` (`table_name`, `title`, `reorderfield`, `use_history`, `searchfield`, `displayfield`, `sortfield`, `searchany`, `hint`, `overview_tpl`, `sync_table`, `writetable`, `globalsearch`, `listselectionmodel`, `sync_view`, `syncable`, `cssstyle`, `alternativeformxtype`, `read_table`, `class_name`, `special_add_panel`, `existsreal`, `character_set_name`, `read_filter`, `listxtypeprefix`, `phpexporter`, `phpexporterfilename`, `combined`, `default_pagesize`, `allowForm`, `listviewbaseclass`, `showactionbtn`) VALUES ('page_content','Seite','',0,'id','id','id',1,'','','','',0,'tualomultirowmodel','',0,'','','','CMS','',1,'','','listview','XlsxWriter','{GUID}',0,100,1,'Tualo.DataSets.ListView',1);
UNLOCK TABLES;
LOCK TABLES `ds_column` WRITE;
INSERT INTO `ds_column` (`table_name`, `column_name`, `default_value`, `default_max_value`, `default_min_value`, `update_value`, `is_primary`, `syncable`, `referenced_table`, `referenced_column_name`, `is_nullable`, `is_referenced`, `writeable`, `note`, `data_type`, `column_key`, `column_type`, `character_maximum_length`, `numeric_precision`, `numeric_scale`, `character_set_name`, `privileges`, `existsreal`, `deferedload`, `hint`) VALUES ('page_content','id','',10000000,0,'',1,0,'','','NO','NO',1,'','varchar','PRI','varchar(255)',255,0,0,'utf8mb4','select,insert,update,references',1,0,NULL),
('page_content','page_content','',10000000,0,'',0,0,'','','YES','NO',1,'','longtext','','longtext',4294967295,0,0,'utf8mb4','select,insert,update,references',1,0,NULL),
('page_content','page_title','',10000000,0,'',0,0,'','','YES','NO',1,'','longtext','','longtext',4294967295,0,0,'utf8mb4','select,insert,update,references',1,0,NULL),
('page_content','pug_file','',10000000,0,'',0,0,'','','YES','NO',1,'','varchar','MUL','varchar(50)',50,0,0,'utf8mb4','select,insert,update,references',1,0,NULL);
UNLOCK TABLES;
LOCK TABLES `ds_column_list_label` WRITE;
INSERT INTO `ds_column_list_label` (`table_name`, `column_name`, `language`, `label`, `xtype`, `editor`, `position`, `summaryrenderer`, `renderer`, `summarytype`, `hidden`, `active`, `filterstore`, `grouped`, `flex`, `direction`, `align`, `listfiltertype`, `hint`) VALUES ('page_content','id','DE','ID','gridcolumn','',0,'','','',0,1,'',0,1.00,'ASC','left','',NULL),
('page_content','page_content','DE','Inhalt','gridcolumn','',2,'','','',1,1,'',0,1.00,'','','',NULL),
('page_content','page_title','DE','Titel','gridcolumn','',1,'','','',0,1,'',0,1.00,'','','',NULL),
('page_content','pug_file','DE','PUG','gridcolumn','',3,'','','',0,1,'',0,1.00,'','','',NULL);
UNLOCK TABLES;
LOCK TABLES `ds_column_form_label` WRITE;
INSERT INTO `ds_column_form_label` (`table_name`, `column_name`, `language`, `label`, `xtype`, `field_path`, `position`, `hidden`, `active`, `allowempty`, `fieldgroup`) VALUES ('page_content','id','DE','ID','textfield','Allgemein',0,0,1,1,''),
('page_content','page_content','DE','Inhalt','textarea','Allgemein',3,0,1,0,''),
('page_content','page_title','DE','Titel','textfield','Allgemein',2,0,1,0,''),
('page_content','pug_file','DE','PUG','combobox_ds_pug_templates_id','Allgemein',1,0,1,0,'');
UNLOCK TABLES;
LOCK TABLES `ds_dropdownfields` WRITE;
UNLOCK TABLES;
LOCK TABLES `ds_reference_tables` WRITE;
INSERT INTO `ds_reference_tables` (`table_name`, `reference_table_name`, `columnsdef`, `constraint_name`, `active`, `searchable`, `autosync`, `position`, `path`, `existsreal`) VALUES ('page_content','ds_pug_templates','{\"page_content__pug_file\":\"ds_pug_templates__id\"}','fk_page_content_page_content',0,0,1,99999,'',1);
UNLOCK TABLES;
LOCK TABLES `ds_addcommands` WRITE;
UNLOCK TABLES;
LOCK TABLES `ds_access` WRITE;
INSERT INTO `ds_access` (`role`, `table_name`, `read`, `write`, `delete`, `append`, `existsreal`) VALUES ('administration','page_content',0,1,1,1,0);
UNLOCK TABLES;
