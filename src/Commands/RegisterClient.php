<?php

namespace Tualo\Office\CMS\Commands;

use Garden\Cli\Cli;
use Garden\Cli\Args;
use phpseclib3\Math\BigInteger\Engines\PHP;
use Tualo\Office\Basic\ICommandline;
use Tualo\Office\ExtJSCompiler\Helper;
use Tualo\Office\Basic\TualoApplication as App;
use Tualo\Office\Basic\PostCheck;



class RegisterClient implements ICommandline
{

    public static function getCommandName(): string
    {
        return 'cms-token';
    }

    public static function setup(Cli $cli)
    {
        $cli->command(self::getCommandName())
            ->description('create a token for the cms')
            ->opt('client', 'the clientsystem', true, 'string')
            ->opt('user', 'the existing user', true, 'string');
    }


    public static function getClientDB(string $clientName)
    {
        $_SERVER['REQUEST_URI'] = '';
        $_SERVER['REQUEST_METHOD'] = 'none';
        App::run();

        $session = App::get('session');
        $sessiondb = $session->db;
        $dbs = $sessiondb->direct('select username dbuser, password dbpass, id dbname, host dbhost, port dbport from macc_clients ');
        foreach ($dbs as $db) {
            if (($clientName != '') && ($clientName != $db['dbname'])) {
                continue;
            } else {
                return $session->newDBByRow($db);
            }
        }
        return false;
    }

    public static function run(Args $args)
    {

        $clientName = $args->getOpt('client');
        if (is_null($clientName)) throw new \Exception('client not set');
        $user = $args->getOpt('user');
        if (is_null($user)) throw new \Exception('user not set');

        $db = self::getClientDB($clientName);
        if (is_null($db)) throw new \Exception('clientdb not fount');

        try {
            if (!isset($_SESSION['tualoapplication'])) $_SESSION['tualoapplication'] = [];
            if (!isset($_SESSION['tualoapplication']['loggedIn'])) $_SESSION['tualoapplication']['loggedIn'] = true;
            if (!isset($_SESSION['tualoapplication']['username'])) $_SESSION['tualoapplication']['username'] = $user;
            if (!isset($_SESSION['tualoapplication']['client'])) $_SESSION['tualoapplication']['client'] = $clientName;

            $session = App::get('session');
            if (!isset($_SESSION['tualoapplication'])) $_SESSION['tualoapplication'] = [];
            if (!isset($_SESSION['tualoapplication']['loggedIn'])) $_SESSION['tualoapplication']['loggedIn'] = true;
            if (!isset($_SESSION['tualoapplication']['username'])) $_SESSION['tualoapplication']['username'] = $user;
            if (!isset($_SESSION['tualoapplication']['client'])) $_SESSION['tualoapplication']['client'] = $clientName;

            $defaultDays = App::configuration('cms', 'oauth_days', 365);
            $token = $session->registerOAuth($force = false, $anyclient = false, $path = 'tualocms/page/*', $name = 'CMS (Public)', $device = gethostname());
            $session->oauthValidDays($token, $defaultDays);
            echo $token . PHP_EOL;
        } catch (\Exception $e) {
            echo $e->getMessage();
        }
    }
}
