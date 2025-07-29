<?php

namespace Tualo\Office\Profile\Commandline;

use Tualo\Office\Basic\ICommandline;
use Tualo\Office\Basic\CommandLineInstallSQL;

class InstallSession extends CommandLineInstallSQL  implements ICommandline
{
    public static function getDir(): string
    {
        return dirname(__DIR__, 1);
    }
    public static $shortName  = 'cms-auth-views';
    public static $files = [
        'sessions/view_session_oauth_check' => 'setup view_session_oauth_check '
    ];
}
