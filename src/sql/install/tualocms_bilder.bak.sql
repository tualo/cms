-- DO NOT USE
-- delimiter ;

CREATE TABLE IF NOT EXISTS tualocms_bilder_typen (
    id varchar(36) not null,
    name varchar(255) not null,
    primary key (id),
    unique index `uidx_tualocms_bilder_typ` (name)
);

insert into tualocms_bilder_typen (id,name) values ('1','Logo');

create table IF NOT EXISTS tualocms_bilder (
    id varchar(36) not null,
    titel varchar(255) default 'nicht gesetzt',
    typ varchar(36) not null,
    file_id varchar(36) not null,
    foreign key (typ) references tualocms_bilder_typen(id) on delete cascade on update cascade,
    primary key (id),
    unique index `uidx_tualocms_bilder_typ` (typ)
);

CREATE VIEW if not exists `view_readtable_tualocms_bilder` AS
select
    `tualocms_bilder`.`id` AS `id`,
    `tualocms_bilder`.`titel` AS `titel`,
    `tualocms_bilder`.`typ` AS `typ`,
    `ds_files`.`name` AS `__file_name`,
    `ds_files`.`path` AS `path`,
    `ds_files`.`size` AS `__file_size`,
    `ds_files`.`mtime` AS `mtime`,
    `ds_files`.`ctime` AS `ctime`,
    `ds_files`.`type` AS `__file_type`,
    `ds_files`.`file_id` AS `__file_id`,
    `ds_files`.`hash` AS `hash`,
    '' AS `__file_data`
from
    (
        `tualocms_bilder`
        left join `ds_files` on(
            `tualocms_bilder`.`file_id` = `ds_files`.`file_id`
        )
    );

INSERT INTO
    `ds` (
        `table_name`,
        `title`,
        `reorderfield`,
        `use_history`,
        `searchfield`,
        `displayfield`,
        `sortfield`,
        `searchany`,
        `hint`,
        `overview_tpl`,
        `sync_table`,
        `writetable`,
        `globalsearch`,
        `listselectionmodel`,
        `sync_view`,
        `syncable`,
        `cssstyle`,
        `alternativeformxtype`,
        `read_table`,
        `class_name`,
        `special_add_panel`,
        `existsreal`,
        `character_set_name`,
        `read_filter`,
        `listxtypeprefix`,
        `phpexporter`,
        `phpexporterfilename`,
        `combined`,
        `default_pagesize`,
        `allowForm`,
        `listviewbaseclass`,
        `showactionbtn`,
        `modelbaseclass`
    )
VALUES
    (
        'tualocms_bilder_typen',
        'CMS-Bildertyp',
        '',
        0,
        'id',
        'name',
        'name',
        0,
        '',
        '',
        '',
        '',
        0,
        'rowmodel',
        '',
        0,
        '',
        '',
        '',
        'Content-Management-System',
        '',
        1,
        '',
        '',
        '',
        'XlsxWriter',
        'tualocms_bilder_typen{DATE}',
        0,
        1000,
        0,
        'Tualo.DataSets.ListView',
        1,
        'Tualo.DataSets.model.Basic'
    ) ON DUPLICATE KEY
UPDATE
    title =
VALUES
(title),
    reorderfield =
VALUES
(reorderfield),
    use_history =
VALUES
(use_history),
    searchfield =
VALUES
(searchfield),
    displayfield =
VALUES
(displayfield),
    sortfield =
VALUES
(sortfield),
    searchany =
VALUES
(searchany),
    hint =
VALUES
(hint),
    overview_tpl =
VALUES
(overview_tpl),
    sync_table =
VALUES
(sync_table),
    writetable =
VALUES
(writetable),
    globalsearch =
VALUES
(globalsearch),
    listselectionmodel =
VALUES
(listselectionmodel),
    sync_view =
VALUES
(sync_view),
    syncable =
VALUES
(syncable),
    cssstyle =
VALUES
(cssstyle),
    alternativeformxtype =
VALUES
(alternativeformxtype),
    read_table =
VALUES
(read_table),
    class_name =
VALUES
(class_name),
    special_add_panel =
VALUES
(special_add_panel),
    existsreal =
VALUES
(existsreal),
    character_set_name =
VALUES
(character_set_name),
    read_filter =
VALUES
(read_filter),
    listxtypeprefix =
VALUES
(listxtypeprefix),
    phpexporter =
VALUES
(phpexporter),
    phpexporterfilename =
VALUES
(phpexporterfilename),
    combined =
VALUES
(combined),
    default_pagesize =
VALUES
(default_pagesize),
    allowForm =
VALUES
(allowForm),
    listviewbaseclass =
VALUES
(listviewbaseclass),
    showactionbtn =
VALUES
(showactionbtn),
    modelbaseclass =
VALUES
(modelbaseclass);

INSERT
    IGNORE INTO `ds_column` (
        `table_name`,
        `column_name`,
        `default_value`,
        `default_max_value`,
        `default_min_value`,
        `update_value`,
        `is_primary`,
        `syncable`,
        `referenced_table`,
        `referenced_column_name`,
        `is_nullable`,
        `is_referenced`,
        `writeable`,
        `note`,
        `data_type`,
        `column_key`,
        `column_type`,
        `character_maximum_length`,
        `numeric_precision`,
        `numeric_scale`,
        `character_set_name`,
        `privileges`,
        `existsreal`,
        `deferedload`,
        `hint`,
        `fieldtype`
    )
VALUES
    (
        'tualocms_bilder_typen',
        'id',
        '{:uuid()}',
        0,
        0,
        '',
        1,
        0,
        '',
        '',
        'NO',
        '',
        1,
        '',
        'varchar',
        'PRI',
        'varchar(12)',
        12,
        NULL,
        NULL,
        'utf8mb4',
        'select,insert,update,references',
        1,
        0,
        '',
        ''
    ),
    (
        'tualocms_bilder_typen',
        'name',
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        'NO',
        NULL,
        1,
        NULL,
        'varchar',
        '',
        'varchar(255)',
        255,
        NULL,
        NULL,
        'utf8mb4',
        'select,insert,update,references',
        1,
        NULL,
        NULL,
        ''
    );

INSERT
    IGNORE INTO `ds_column_list_label` (
        `table_name`,
        `column_name`,
        `language`,
        `label`,
        `xtype`,
        `editor`,
        `position`,
        `summaryrenderer`,
        `renderer`,
        `summarytype`,
        `hidden`,
        `active`,
        `filterstore`,
        `grouped`,
        `flex`,
        `direction`,
        `align`,
        `listfiltertype`,
        `hint`
    )
VALUES
    (
        'tualocms_bilder_typen',
        'id',
        'DE',
        'ID',
        'gridcolumn',
        NULL,
        0,
        '',
        '',
        '',
        0,
        1,
        '',
        0,
        1.00,
        'ASC',
        'left',
        '',
        NULL
    ),
    (
        'tualocms_bilder_typen',
        'name',
        'DE',
        'Name',
        'gridcolumn',
        NULL,
        1,
        '',
        '',
        '',
        0,
        1,
        '',
        0,
        1.00,
        'ASC',
        'left',
        '',
        NULL
    );

INSERT
    IGNORE INTO `ds_column_form_label` (
        `table_name`,
        `column_name`,
        `language`,
        `label`,
        `xtype`,
        `field_path`,
        `position`,
        `hidden`,
        `active`,
        `allowempty`,
        `fieldgroup`,
        `flex`,
        `hint`
    )
VALUES
    (
        'tualocms_bilder_typen',
        'id',
        'DE',
        'ID',
        'textfield',
        'Allgemein/Angaben',
        0,
        0,
        1,
        0,
        '1',
        1.00,
        '\'\''
    ),
    (
        'tualocms_bilder_typen',
        'name',
        'DE',
        'Name',
        'textfield',
        'Allgemein/Angaben',
        1,
        0,
        1,
        0,
        '1',
        1.00,
        '\'\''
    );

INSERT
    IGNORE INTO `ds_dropdownfields` (
        `table_name`,
        `name`,
        `idfield`,
        `displayfield`,
        `filterconfig`
    )
VALUES
    ('tualocms_bilder_typen', 'id', 'id', 'name', '');

INSERT
    IGNORE INTO `ds_access` (
        `role`,
        `table_name`,
        `read`,
        `write`,
        `delete`,
        `append`,
        `existsreal`
    )
VALUES
    (
        'administration',
        'tualocms_bilder_typen',
        1,
        1,
        1,
        1,
        1
    ),
    ('_default_', 'tualocms_bilder_typen', 1, 0, 0, 0, 1);




INSERT INTO
    `ds` (
        `table_name`,
        `title`,
        `reorderfield`,
        `use_history`,
        `searchfield`,
        `displayfield`,
        `sortfield`,
        `searchany`,
        `hint`,
        `overview_tpl`,
        `sync_table`,
        `writetable`,
        `globalsearch`,
        `listselectionmodel`,
        `sync_view`,
        `syncable`,
        `cssstyle`,
        `alternativeformxtype`,
        `read_table`,
        `class_name`,
        `special_add_panel`,
        `existsreal`,
        `character_set_name`,
        `read_filter`,
        `listxtypeprefix`,
        `phpexporter`,
        `phpexporterfilename`,
        `combined`,
        `default_pagesize`,
        `allowForm`,
        `listviewbaseclass`,
        `showactionbtn`,
        `modelbaseclass`
    )
VALUES
    (
        'tualocms_bilder',
        'CMS-Bilder',
        '',
        0,
        '__file_name',
        '__file_name',
        '__file_name',
        1,
        '',
        '',
        '',
        '',
        0,
        'rowmodel',
        '',
        0,
        '',
        '',
        'view_readtable_tualocms_bilder',
        'Content-Management-System',
        '',
        1,
        '',
        '',
        '',
        'XlsxWriter',
        'tualocms_bilder{DATE}',
        0,
        1000,
        0,
        'Tualo.DataSets.ListViewFileDrop',
        1,
        'Tualo.DataSets.model.Basic'
    ) ON DUPLICATE KEY
UPDATE
    title =
VALUES
(title),
    reorderfield =
VALUES
(reorderfield),
    use_history =
VALUES
(use_history),
    searchfield =
VALUES
(searchfield),
    displayfield =
VALUES
(displayfield),
    sortfield =
VALUES
(sortfield),
    searchany =
VALUES
(searchany),
    hint =
VALUES
(hint),
    overview_tpl =
VALUES
(overview_tpl),
    sync_table =
VALUES
(sync_table),
    writetable =
VALUES
(writetable),
    globalsearch =
VALUES
(globalsearch),
    listselectionmodel =
VALUES
(listselectionmodel),
    sync_view =
VALUES
(sync_view),
    syncable =
VALUES
(syncable),
    cssstyle =
VALUES
(cssstyle),
    alternativeformxtype =
VALUES
(alternativeformxtype),
    read_table =
VALUES
(read_table),
    class_name =
VALUES
(class_name),
    special_add_panel =
VALUES
(special_add_panel),
    existsreal =
VALUES
(existsreal),
    character_set_name =
VALUES
(character_set_name),
    read_filter =
VALUES
(read_filter),
    listxtypeprefix =
VALUES
(listxtypeprefix),
    phpexporter =
VALUES
(phpexporter),
    phpexporterfilename =
VALUES
(phpexporterfilename),
    combined =
VALUES
(combined),
    default_pagesize =
VALUES
(default_pagesize),
    allowForm =
VALUES
(allowForm),
    listviewbaseclass =
VALUES
(listviewbaseclass),
    showactionbtn =
VALUES
(showactionbtn),
    modelbaseclass =
VALUES
(modelbaseclass);

REPLACE INTO `ds_column` (
    `table_name`,
    `column_name`,
    `default_value`,
    `default_max_value`,
    `default_min_value`,
    `update_value`,
    `is_primary`,
    `syncable`,
    `referenced_table`,
    `referenced_column_name`,
    `is_nullable`,
    `is_referenced`,
    `writeable`,
    `note`,
    `data_type`,
    `column_key`,
    `column_type`,
    `character_maximum_length`,
    `numeric_precision`,
    `numeric_scale`,
    `character_set_name`,
    `privileges`,
    `existsreal`,
    `deferedload`,
    `hint`,
    `fieldtype`
)
VALUES
    (
        'tualocms_bilder',
        'ctime',
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        'YES',
        NULL,
        0,
        NULL,
        'datetime',
        '',
        'datetime',
        NULL,
        NULL,
        NULL,
        NULL,
        'select,insert,update,references',
        1,
        NULL,
        NULL,
        ''
    ),
    (
        'tualocms_bilder',
        'file_id',
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        'NO',
        NULL,
        1,
        NULL,
        'varchar',
        '',
        'varchar(36)',
        36,
        NULL,
        NULL,
        'utf8mb4',
        'select,insert,update,references',
        1,
        NULL,
        NULL,
        ''
    ),
    (
        'tualocms_bilder',
        'hash',
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        'YES',
        NULL,
        0,
        NULL,
        'varchar',
        '',
        'varchar(36)',
        36,
        NULL,
        NULL,
        'utf8mb4',
        'select,insert,update,references',
        1,
        NULL,
        NULL,
        ''
    ),
    (
        'tualocms_bilder',
        'id',
        '{:uuid()}',
        NULL,
        NULL,
        NULL,
        0,
        NULL,
        NULL,
        NULL,
        'YES',
        NULL,
        1,
        NULL,
        'varchar',
        '',
        'varchar(36)',
        36,
        NULL,
        NULL,
        'utf8mb4',
        'select,insert,update,references',
        1,
        NULL,
        NULL,
        ''
    ),
    (
        'tualocms_bilder',
        'titel',
        NULL,
        NULL,
        NULL,
        NULL,
        1,
        NULL,
        NULL,
        NULL,
        'NO',
        NULL,
        0,
        NULL,
        'varchar',
        '',
        'varchar(36)',
        12,
        NULL,
        NULL,
        'utf8mb4',
        'select,insert,update,references',
        1,
        NULL,
        NULL,
        ''
    ),
    (
        'tualocms_bilder',
        'mtime',
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        'YES',
        NULL,
        0,
        NULL,
        'datetime',
        '',
        'datetime',
        NULL,
        NULL,
        NULL,
        NULL,
        'select,insert,update,references',
        1,
        NULL,
        NULL,
        ''
    ),
    (
        'tualocms_bilder',
        'path',
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        'YES',
        NULL,
        0,
        NULL,
        'varchar',
        '',
        'varchar(255)',
        255,
        NULL,
        NULL,
        'utf8mb4',
        'select,insert,update,references',
        1,
        NULL,
        NULL,
        ''
    ),
    (
        'tualocms_bilder',
        'typ',
        1,
        NULL,
        NULL,
        NULL,
        1,
        NULL,
        NULL,
        NULL,
        'NO',
        NULL,
        1,
        NULL,
        'varchar',
        'PRI',
        'varchar(36)',
        12,
        NULL,
        NULL,
        'utf8mb4',
        'select,insert,update,references',
        1,
        NULL,
        NULL,
        ''
    ),
    (
        'tualocms_bilder',
        '__file_data',
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        'NO',
        NULL,
        0,
        NULL,
        'char',
        '',
        'char(0)',
        0,
        NULL,
        NULL,
        'utf8mb4',
        'select,insert,update,references',
        1,
        NULL,
        NULL,
        ''
    ),
    (
        'tualocms_bilder',
        '__file_id',
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        'YES',
        NULL,
        0,
        NULL,
        'varchar',
        '',
        'varchar(36)',
        36,
        NULL,
        NULL,
        'utf8mb4',
        'select,insert,update,references',
        1,
        NULL,
        NULL,
        ''
    ),
    (
        'tualocms_bilder',
        '__file_name',
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        'YES',
        NULL,
        0,
        NULL,
        'varchar',
        '',
        'varchar(255)',
        255,
        NULL,
        NULL,
        'utf8mb4',
        'select,insert,update,references',
        1,
        NULL,
        NULL,
        ''
    ),
    (
        'tualocms_bilder',
        '__file_size',
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        'YES',
        NULL,
        0,
        NULL,
        'int',
        '',
        'int(11)',
        NULL,
        10,
        0,
        NULL,
        'select,insert,update,references',
        1,
        NULL,
        NULL,
        ''
    ),
    (
        'tualocms_bilder',
        '__file_type',
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        'YES',
        NULL,
        0,
        NULL,
        'varchar',
        '',
        'varchar(255)',
        255,
        NULL,
        NULL,
        'utf8mb4',
        'select,insert,update,references',
        1,
        NULL,
        NULL,
        ''
    );

INSERT
    IGNORE INTO `ds_column_list_label` (
        `table_name`,
        `column_name`,
        `language`,
        `label`,
        `xtype`,
        `editor`,
        `position`,
        `summaryrenderer`,
        `renderer`,
        `summarytype`,
        `hidden`,
        `active`,
        `filterstore`,
        `grouped`,
        `flex`,
        `direction`,
        `align`,
        `listfiltertype`,
        `hint`
    )
VALUES
    (
        'tualocms_bilder',
        'bild',
        'DE',
        'bild',
        'gridcolumn',
        '',
        6,
        '',
        '',
        '',
        1,
        1,
        '',
        0,
        1.00,
        '',
        'left',
        '',
        'NULL'
    ),
    (
        'tualocms_bilder',
        'ctime',
        'DE',
        'Anlage',
        'gridcolumn',
        NULL,
        4,
        '',
        '',
        '',
        0,
        1,
        '',
        0,
        1.00,
        'ASC',
        'left',
        '',
        NULL
    ),
    (
        'tualocms_bilder',
        'file_id',
        'DE',
        'file_id',
        'gridcolumn',
        '',
        12,
        '',
        '',
        '',
        1,
        1,
        '',
        0,
        1.00,
        '',
        'left',
        '',
        'NULL'
    ),
    (
        'tualocms_bilder',
        'hash',
        'DE',
        'hash',
        'gridcolumn',
        '',
        8,
        '',
        '',
        '',
        1,
        1,
        '',
        0,
        1.00,
        '',
        'left',
        '',
        'NULL'
    ),
    (
        'tualocms_bilder',
        'id',
        'DE',
        'ID',
        'gridcolumn',
        NULL,
        0,
        '',
        '',
        '',
        0,
        1,
        '',
        0,
        1.00,
        'ASC',
        'left',
        '',
        NULL
    ),
    (
        'tualocms_bilder',
        'titel',
        'DE',
        'Titel',
        'gridcolumn',
        NULL,
        1,
        '',
        '',
        '',
        0,
        1,
        '',
        0,
        1.00,
        'ASC',
        'left',
        '',
        NULL
    ),
    (
        'tualocms_bilder',
        'mtime',
        'DE',
        'mtime',
        'gridcolumn',
        '',
        10,
        '',
        '',
        '',
        1,
        1,
        '',
        0,
        1.00,
        '',
        'left',
        '',
        'NULL'
    ),
    (
        'tualocms_bilder',
        'path',
        'DE',
        'path',
        'gridcolumn',
        '',
        7,
        '',
        '',
        '',
        1,
        1,
        '',
        0,
        1.00,
        '',
        'left',
        '',
        'NULL'
    ),
    (
        'tualocms_bilder',
        'typ',
        'DE',
        'Typ',
        'column_tualocms_bilder_typen_id',
        NULL,
        3,
        '',
        '',
        '',
        0,
        1,
        '',
        0,
        1.00,
        'ASC',
        'left',
        '',
        NULL
    ),
    (
        'tualocms_bilder',
        '__file_data',
        'DE',
        '__file_data',
        'gridcolumn',
        '',
        13,
        '',
        '',
        '',
        1,
        1,
        '',
        0,
        1.00,
        '',
        'left',
        '',
        'NULL'
    ),
    (
        'tualocms_bilder',
        '__file_id',
        'DE',
        '__file_id',
        'gridcolumn',
        '',
        9,
        '',
        '',
        '',
        1,
        1,
        '',
        0,
        1.00,
        '',
        'left',
        '',
        'NULL'
    ),
    (
        'tualocms_bilder',
        '__file_name',
        'DE',
        'Dateiname',
        'gridcolumn',
        NULL,
        2,
        '',
        '',
        '',
        0,
        1,
        '',
        0,
        1.00,
        'ASC',
        'left',
        '',
        NULL
    ),
    (
        'tualocms_bilder',
        '__file_size',
        'DE',
        'Größe',
        'tualodisplayfilesize',
        '',
        5,
        '',
        '',
        '',
        0,
        1,
        '',
        0,
        1.00,
        '',
        'end',
        '',
        'NULL'
    ),
    (
        'tualocms_bilder',
        '__file_type',
        'DE',
        '__file_type',
        'gridcolumn',
        '',
        11,
        '',
        '',
        '',
        1,
        1,
        '',
        0,
        1.00,
        '',
        'left',
        '',
        'NULL'
    );

INSERT
    IGNORE INTO `ds_column_form_label` (
        `table_name`,
        `column_name`,
        `language`,
        `label`,
        `xtype`,
        `field_path`,
        `position`,
        `hidden`,
        `active`,
        `allowempty`,
        `fieldgroup`,
        `flex`,
        `hint`
    )
VALUES
    (
        'tualocms_bilder',
        'bild',
        'DE',
        'bild',
        'displayfield',
        'Allgemein',
        6,
        1,
        0,
        0,
        '1',
        1.00,
        '\'\''
    ),
    (
        'tualocms_bilder',
        'ctime',
        'DE',
        'Anlage',
        'tualodatetimedisplayfield',
        'Allgemein/Angaben',
        4,
        0,
        1,
        1,
        '1',
        1.00,
        '\'\''
    ),
    (
        'tualocms_bilder',
        'file_id',
        'DE',
        'file_id',
        'displayfield',
        'Allgemein',
        12,
        1,
        0,
        0,
        '1',
        1.00,
        '\'\''
    ),
    (
        'tualocms_bilder',
        'hash',
        'DE',
        'hash',
        'displayfield',
        'Allgemein',
        8,
        1,
        0,
        0,
        '1',
        1.00,
        '\'\''
    ),
    (
        'tualocms_bilder',
        'id',
        'DE',
        'ID',
        'displayfield',
        'Allgemein/Angaben',
        0,
        0,
        1,
        1,
        '1',
        1.00,
        '\'\''
    ),
    (
        'tualocms_bilder',
        'titel',
        'DE',
        'Titel',
        'textfield',
        'Allgemein/Angaben',
        1,
        0,
        1,
        1,
        '1',
        1.00,
        '\'\''
    ),
    (
        'tualocms_bilder',
        'mtime',
        'DE',
        'mtime',
        'displayfield',
        'Allgemein',
        10,
        1,
        0,
        0,
        '1',
        1.00,
        '\'\''
    ),
    (
        'tualocms_bilder',
        'path',
        'DE',
        'path',
        'displayfield',
        'Allgemein',
        7,
        1,
        0,
        0,
        '1',
        1.00,
        '\'\''
    ),
    (
        'tualocms_bilder',
        'typ',
        'DE',
        'Typ',
        'combobox_tualocms_bilder_typen_id',
        'Allgemein/Angaben',
        3,
        0,
        1,
        1,
        '1',
        1.00,
        '\'\''
    ),
    (
        'tualocms_bilder',
        '__file_data',
        'DE',
        '__file_data',
        'displayfield',
        'Allgemein',
        13,
        1,
        0,
        0,
        '1',
        1.00,
        '\'\''
    ),
    (
        'tualocms_bilder',
        '__file_id',
        'DE',
        '__file_id',
        'displayfield',
        'Allgemein',
        9,
        1,
        0,
        0,
        '1',
        1.00,
        '\'\''
    ),
    (
        'tualocms_bilder',
        '__file_name',
        'DE',
        'Dateiname',
        'displayfield',
        'Allgemein/Angaben',
        2,
        0,
        1,
        1,
        '1',
        1.00,
        '\'\''
    ),
    (
        'tualocms_bilder',
        '__file_size',
        'DE',
        'Größe',
        'displayfield',
        'Allgemein/Angaben',
        5,
        0,
        1,
        0,
        '1',
        1.00,
        '\'\''
    ),
    (
        'tualocms_bilder',
        '__file_type',
        'DE',
        '__file_type',
        'displayfield',
        'Allgemein',
        11,
        1,
        0,
        0,
        '1',
        1.00,
        '\'\''
    );

INSERT
    IGNORE INTO `ds_reference_tables` (
        `table_name`,
        `reference_table_name`,
        `columnsdef`,
        `constraint_name`,
        `active`,
        `searchable`,
        `autosync`,
        `position`,
        `path`,
        `existsreal`,
        `tabtitle`
    )
VALUES

    (
        'tualocms_bilder',
        'tualocms_bilder_typen',
        '{\"typ\":\"id\"}',
        'tualocms_bilder_ibfk_2',
        0,
        0,
        0,
        999,
        '',
        1,
        ''
    );

INSERT
    IGNORE INTO `ds_access` (
        `role`,
        `table_name`,
        `read`,
        `write`,
        `delete`,
        `append`,
        `existsreal`
    )
VALUES
    ('administration', 'tualocms_bilder', 1, 1, 1, 1, 1),
    ('_default_', 'tualocms_bilder', 1, 0, 0, 0, 1);