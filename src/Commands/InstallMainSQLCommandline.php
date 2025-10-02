<?php

namespace Tualo\Office\CMS\Commands;

use Garden\Cli\Cli;
use Garden\Cli\Args;
use phpseclib3\Math\BigInteger\Engines\PHP;
use Tualo\Office\Basic\ICommandline;
use Tualo\Office\ExtJSCompiler\Helper;
use Tualo\Office\Basic\TualoApplication as App;
use Tualo\Office\Basic\PostCheck;

class InstallMainSQLCommandline implements ICommandline
{

    public static function getCommandName(): string
    {
        return 'install-sql-cms';
    }

    public static function setup(Cli $cli)
    {
        $cli->command(self::getCommandName())
            ->description('installs needed sql procedures for cms module')
            ->opt('client', 'only use this client', true, 'string');
    }


    public static function setupClients(string $msg, string $clientName, string $file, callable $callback)
    {
        $_SERVER['REQUEST_URI'] = '';
        $_SERVER['REQUEST_METHOD'] = 'none';
        App::run();

        $session = App::get('session');
        $sessiondb = $session->db;
        $dbs = $sessiondb->direct('select username db_user, password db_pass, id db_name, host db_host, port db_port from macc_clients ');
        foreach ($dbs as $db) {
            if (($clientName != '') && ($clientName != $db['db_name'])) {
                continue;
            } else {
                App::set('clientDB', $session->newDBByRow($db));
                PostCheck::formatPrint(['blue'], $msg . '(' . $db['db_name'] . '):  ');
                $callback($file);
                PostCheck::formatPrintLn(['green'], "\t" . ' done');
            }
        }
    }

    public static function run(Args $args)
    {

        $files = [
            //            'ddl-cms' => 'setup main ddl ',
            // 'ds.definition' => 'setup cms ds definition ',

            'install/ds_class' => 'setup ds_class',

            'install/tualocms_attribute' => 'setup tualocms_attribute',
            'install/tualocms_attribute.ds' => 'setup tualocms_attribute.ds',

            'install/tualocms_middleware' => 'setup tualocms_middleware',
            'install/tualocms_middleware.ds' => 'setup tualocms_middleware.ds',

            'middlewares' => 'setup cms middlewares ',

            'install/tualocms_page' => 'setup tualocms_page',
            'install/tualocms_page.ds' => 'setup tualocms_page.ds',


            'install/tualocms_page_middleware' => 'setup tualocms_page_middleware',
            'install/tualocms_page_middleware.ds' => 'setup tualocms_page_middleware.ds',

            'install/tualocms_section' => 'setup tualocms_section',
            'install/tualocms_section.ds' => 'setup tualocms_section.ds',

            'install/tualocms_section_tualocms_attributes' => 'setup tualocms_section_tualocms_attributes',
            'install/tualocms_section_tualocms_attributes.ds' => 'setup tualocms_section_tualocms_attributes.ds',

            'install/tualocms_section_tualocms_page'    => 'setup tualocms_section_tualocms_page',
            'install/tualocms_section_tualocms_page.ds' => 'setup tualocms_section_tualocms_page.ds',


            'install/view_load_tualocms_page_section_attributes'    => 'setup view_load_tualocms_page_section_attributes',
            'install/view_load_tualocms_page'    => 'setup view_load_tualocms_page',
            'install/view_load_tualocms_page.ds' => 'setup view_load_tualocms_page.ds',


            'install/tualocms_bilder_typen' => 'setup tualocms_bilder_typen',
            'install/tualocms_bilder_typen.ds' => 'setup tualocms_bilder_typen.ds',

            'install/tualocms_bilder' => 'setup tualocms_bilder',
            'install/tualocms_bilder.ds' => 'setup tualocms_bilder.ds',


            'install/tualocms_dateien_typen' => 'setup tualocms_dateien_typen',
            'install/tualocms_dateien_typen.ds' => 'setup tualocms_dateien_typen.ds',

            'install/tualocms_dateien' => 'setup tualocms_dateien',
            'install/tualocms_dateien.ds' => 'setup tualocms_dateien.ds',

            'install/tualocms_csp' => 'setup tualocms_csp',
            'install/tualocms_csp.ds' => 'setup tualocms_csp.ds',

            'install/tualocms_page_csp' => 'setup tualocms_page_csp',
            'install/tualocms_page_csp.ds' => 'setup tualocms_page_csp.ds',

            'install/view_load_tualocms_page_csp' => 'setup view_load_tualocms_page_csp',
            'install/view_load_tualocms_page_csp.ds' => 'setup view_load_tualocms_page_csp.ds',

            'install/tualocms_permission_policy' => 'setup tualocms_permission_policy',
            'install/tualocms_permission_policy.ds' => 'setup tualocms_permission_policy.ds',

            'install/tualocms_page_permission_policy' => 'setup tualocms_page_permission_policy',
            'install/tualocms_page_permission_policy.ds' => 'setup tualocms_page_permission_policy.ds',

            'install/view_load_tualocms_page_permission_policy' => 'setup view_load_tualocms_page_permission_policy',
            'install/view_load_tualocms_page_permission_policy.ds' => 'setup view_load_tualocms_page_permission_policy.ds',

            'install/tualocms_additional_headers' => 'setup tualocms_additional_headers',
            'install/tualocms_additional_headers.ds' => 'setup tualocms_additional_headers.ds',

            'install/tualocms_page_headers' => 'setup tualocms_page_headers',
            'install/tualocms_page_headers.ds' => 'setup tualocms_page_headers.ds',

            'install/view_load_tualocms_page_headers' => 'setup view_load_tualocms_page_headers',
            'install/view_load_tualocms_page_headers.ds' => 'setup view_load_tualocms_page_headers.ds',

            'sessions/view_session_oauth_check' => 'setup view_session_oauth_check',
        ];


        foreach ($files as $file => $msg) {
            $installSQL = function (string $file) {

                $filename = dirname(__DIR__) . '/sql/' . $file . '.sql';
                $sql = file_get_contents($filename);
                $sql = preg_replace('!/\*.*?\*/!s', '', $sql);
                $sql = preg_replace('#^\s*\-\-.+$#m', '', $sql);

                $sql = preg_replace('#SESSIONDB#', App::get('session')->db->dbname, $sql);

                $sinlgeStatements = App::get('clientDB')->explode_by_delimiter($sql);
                foreach ($sinlgeStatements as $commandIndex => $statement) {
                    try {
                        App::get('clientDB')->execute($statement);
                        App::get('clientDB')->moreResults();
                    } catch (\Exception $e) {
                        echo PHP_EOL;
                        PostCheck::formatPrintLn(['red'], $e->getMessage() . ': commandIndex => ' . $commandIndex);
                    }
                }
            };
            $clientName = $args->getOpt('client');
            if (is_null($clientName)) $clientName = '';
            self::setupClients($msg, $clientName, $file, $installSQL);
        }
    }
}
