<?php

namespace Tualo\Office\CMS\Commands\SystemChecks;

use Tualo\Office\Basic\FormatedCommandLineOutput;
use Tualo\Office\Basic\ISystemCheck;
use Tualo\Office\Basic\TualoApplication as App;

class AuthTokens extends FormatedCommandLineOutput implements ISystemCheck
{

    public static function hasClientTest(): bool
    {
        return true;
    }

    public static function hasSessionTest(): bool
    {
        return false;
    }

    public static function getModuleName(): string
    {
        return 'cms auth tokens';
    }

    public static function testSessionDB(array $config): int
    {
        return 0;
    }

    public static function test(array $config): int
    {

        $clientdb = App::get('clientDB');
        if (is_null($clientdb)) return 1;

        self::formatPrintLn(['blue'], 'AuthTokens SystemCheck:');
        $templateSql = 'select * from view_session_oauth_check where path="tualocms/page/*" and validuntil>now()';
        $data = $clientdb->direct($templateSql);
        if (count($data) == 0) {
            self::formatPrintLn(['red'], 'No active auth tokens found.');
            return 2;
        }

        self::formatPrintLn(['green'], 'Active auth tokens found.');

        $templateSql = 'select * from view_session_oauth_check where path="tualocms/page/*" and validuntil + interval - ' . App::configuration("cms", "warn_days_before", 15) . ' day < now()';
        $data = $clientdb->direct($templateSql);
        if (count($data) != 0) {
            self::formatPrintLn(['red'], 'There are tokens about to expire.');
            return 3;
        }



        return 0;
    }
}
