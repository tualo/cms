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


        if (!file_exists(dirname((string)App::get('basePath')) . '/.htaccess')) {
            self::formatPrintLn(['red'], '.htaccess file not found in base path.');
            return 4;
        }

        $htaccess_content = file_get_contents(dirname((string)App::get('basePath')) . '/.htaccess');
        // parse htaccess content for token

        $token_found = false;
        $token_valid_until = null;
        $token = preg_match('/RewriteRule \^\(.\*\)\$ \/\~\/([a-f0-9\-]{36})\/tualocms\/page\/\1 \[PT\]/', $htaccess_content, $matches);
        if ($token && isset($matches[1])) {
            $token_value = $matches[1];
            $templateSql = 'select * from view_session_oauth_check where path="/tualocms/page/*" and token={token} and validuntil + interval - ' . App::configuration("cms", "warn_days_before", 15) . ' day < now()';
            $data = $clientdb->direct($templateSql, ['token' => $token_value]);
            if (count($data) != 0) {
                $token_found = true;
                $token_valid_until = $data[0]['validuntil'];
                self::formatPrintLn(['green'], 'Valid auth token found in .htaccess file, valid until ' . $token_valid_until . '.');
            }
        }
        if (!$token_found) {
            self::formatPrintLn(['red'], 'No valid auth token found in .htaccess file vaild more than ' . App::configuration("cms", "warn_days_before", 15) . ' days.');
            return 5;
        }


        return 0;
    }
}
