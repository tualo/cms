<?php

namespace Tualo\Office\CMS\Commands;

use Garden\Cli\Cli;
use Garden\Cli\Args;
use Tualo\Office\Basic\ICommandline;
use Tualo\Office\ExtJSCompiler\Helper;
use Tualo\Office\Basic\TualoApplication as App;
use Tualo\Office\Basic\PostCheck;
use Tualo\Office\DS\DataRenderer;
use Tualo\Office\CMS\Commands\RegisterClient;

class SetupCMSApache implements ICommandline
{

    public static $template = <<<EOT
RewriteEngine on
# SSLProxyEngine on

# LogLevel alert rewrite:trace6
# RewriteCond %{HTTP_HOST} ^www.domain.com$ [OR]
# RewriteCond %{HTTP_HOST} ^domain.com$
RewriteCond %{REQUEST_URI} ^/(\s*|page\.css|dokumentation)$
RewriteCond %{REQUEST_URI} !^/{basename}
RewriteRule ^/(\s*|page\.css|dokumentation)$ /{basename}/~/{token}/tualocms/page/$1 [PT]


Header always set Strict-Transport-Security "max-age=63072000; includeSubDomains; preload"
Header set Permissions-Policy "camera=(), microphone=(), usb=(), geolocation=()"
Header set X-Content-Type-Options nosniff
Header always set Content-Security-Policy "base-uri 'none', base-uri 'self'; default-src 'self' data:; script-src 'self' 'unsafe-eval'; style-src 'self' 'unsafe-inline'; form-action 'self'; img-src 'self' data:"
Header set X-Frame-Options "SAMEORIGIN"
Header set X-XSS-Protection "1; mode=block"
Header set Referrer-Policy "same-origin"

EOT;


    public static function getCommandName(): string
    {
        return 'setup-cms-apache';
    }

    public static function setup(Cli $cli)
    {
        $cli->command(self::getCommandName())
            ->description('setupapache get htaccess.')
        ;
    }

    public static function getClientDB(string $clientName)
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

        if (!file_exists(dirname((string)App::get('basePath')) . '/.htaccess')) {

            $prompt = [
                "\t" . 'do you want to create the .htaccess in "' . dirname((string)App::get('basePath')) . '" now? [y|n|c] '
            ];
            while (in_array($line = readline(implode("\n", $prompt)), ['yes', 'y', 'n', 'no', 'c'])) {
                if ($line == 'c') exit();
                if ($line == 'y') {
                    file_put_contents(
                        dirname((string)App::get('basePath')) . '/.htaccess',
                        DataRenderer::renderTemplate(
                            self::$template,
                            [
                                'basename' => basename((string)App::get('basePath')),
                                'token' => RegisterClient::getToken(
                                    $user,
                                    $clientName
                                ),
                            ]
                        )
                    );
                    PostCheck::formatPrintLn(['green'], "\t done");
                    break;
                }
                if ($line == 'n') {
                    break;
                }
            }
        }
    }
}
