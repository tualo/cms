<?php

namespace Tualo\Office\CMS\Checks;

use Tualo\Office\Basic\Middleware\Session;
use Tualo\Office\Basic\PostCheck;
use Tualo\Office\Basic\TualoApplication as App;


class Tables  extends PostCheck
{

    public static function test(array $config)
    {
        $clientdb = App::get('clientDB');
        if (is_null($clientdb)) return;
        $tables = [
            'tualocms_page' => [
                'columns' => [
                    // 'table_name'=>'varchar(128)'
                ]
            ],
            'tualocms_page_headers' => [
                'columns' => [
                    'tualocms_page' => 'varchar(36)',
                    'header_key' => 'varchar(100)',
                    'value' => 'varchar(255)'
                ]
            ],
            'tualocms_additional_headers' => [
                'columns' => [
                    'header_key' => 'varchar(100)',
                    'header_value' => 'varchar(255)',
                    'valid_from' => 'datetime',
                    'valid_until' => 'datetime'
                ]
            ],
            'view_load_tualocms_page_headers' => [
                'columns' => [
                    'tualocms_page' => 'varchar(36)',
                    'header_key' => 'varchar(100)',
                    'header_value' => 'varchar(255)'
                ]
            ],
            'tualocms_domains' => [
                'columns' => [
                    'domain' => 'varchar(128)',
                    'valid_from' => 'datetime',
                    'valid_to' => 'datetime',
                    'notes' => 'text'
                ]
            ],
            'tualocms_domain_ip_certs' => [
                'columns' => [
                    'domain' => 'varchar(128)',
                    'ip' => 'varchar(255)',
                    'fingerprint' => 'varchar(255)',
                    'certificate_valid_from' => 'datetime',
                    'certificate_valid_to' => 'datetime',
                    'certificate_checked_on' => 'datetime'
                ]
            ],
        ];
        self::tableCheck(
            'cms',
            $tables,
            "please run the following command: `./tm install-sql-cms --client " . $clientdb->dbname . "`",
            "please run the following command: `./tm install-sql-cms --client " . $clientdb->dbname . "`"
        );
    }
}
