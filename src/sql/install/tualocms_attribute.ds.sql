DELIMITER;

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
        'tualocms_attribute',
        'CMS - verfügbare Attribute',
        '',
        0,
        'name',
        'name',
        'name',
        1,
        '',
        '',
        '',
        '',
        1,
        'cellmodel',
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
        'tualocms_attribute {DATE} {TIME}',
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
        'tualocms_attribute',
        'name',
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
    ),
    (
        'tualocms_attribute',
        'tualocms_attribute',
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
        'varchar(36)',
        36,
        NULL,
        NULL,
        'utf8mb4',
        'select,insert,update,references',
        1,
        0,
        '',
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
        'tualocms_attribute',
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
    ),
    (
        'tualocms_attribute',
        'tualocms_attribute',
        'DE',
        'Attribute',
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
        'tualocms_attribute',
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
    ),
    (
        'tualocms_attribute',
        'tualocms_attribute',
        'DE',
        'Attribute',
        'displayfield',
        'Allgemein/Angaben',
        0,
        0,
        1,
        1,
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
    (
        'tualocms_attribute',
        'tualocms_attribute',
        'tualocms_attribute',
        'name',
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
    ('administration', 'tualocms_attribute', 1, 1, 1, 1, 0);