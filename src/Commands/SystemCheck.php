<?php

namespace Tualo\Office\CMS\Commands;

use Tualo\Office\Basic\FormatedCommandLineOutput;
use Tualo\Office\Basic\ISystemCheck;

class SystemCheck extends FormatedCommandLineOutput implements ISystemCheck
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
        return 'cms';
    }

    public static function testSessionDB(array $config): int
    {
        return 0;
    }

    public static function test(array $config): int
    {
        self::formatPrintLn(['blue'], 'CMS SystemCheck:');
        // check if there are auth tokens about to expire


        return 0;
    }
}
