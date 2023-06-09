<?php
namespace Tualo\Office\Basic;
use Garden\Cli\Cli;
use Garden\Cli\Args;
use Tualo\Office\Basic\ICommandline;
use Tualo\Office\ExtJSCompiler\Helper;
use Tualo\Office\Basic\TualoApplication as App;
use Tualo\Office\Basic\PostCheck;
use Tualo\Office\DS\DataRenderer;

class SetupCMSApache implements ICommandline{

    public static $template = <<<EOT
RewriteEngine on
# SSLProxyEngine on

# LogLevel alert rewrite:trace6
RewriteCond %{REQUEST_URI} ^/(\s*|page\.css|dokumentation)$
RewriteCond %{REQUEST_URI} !^/{basename}
RewriteRule ^/(\s*|page\.css|dokumentation)$ /{basename}/~/{token}/cms/page/$1 [PT]


Header always set Strict-Transport-Security "max-age=63072000; includeSubDomains"
Header add X-Content-Type-Options nosniff
Header always set Content-Security-Policy "base-uri 'none', base-uri 'self'; default-src 'self' data:; script-src 'self' 'unsafe-eval'; style-src 'self' 'unsafe-inline'; form-action 'self'; img-src 'self' data:"
Header add X-Frame-Options "SAMEORIGIN"
Header add X-XSS-Protection "1; mode=block"
Header add Referrer-Policy "same-origin"

EOT;


    public static function getCommandName():string { return 'setup-cms-apache';}

    public static function setup(Cli $cli){
        $cli->command(self::getCommandName())
            ->description('setupapache get htaccess.')
        ;
    }
    public static function run(Args $args){
        if (!file_exists(dirname((string)App::get('basePath')).'/.htaccess')){

            $prompt = [
                "\t".'do you want to create the .htaccess in "'.dirname((string)App::get('basePath')).'" now? [y|n|c] '
            ];
            while(in_array($line = readline(implode("\n",$prompt)),['yes','y','n','no','c'])){
                if ($line=='c') exit();
                if ($line=='y'){
                    file_put_contents(
                        dirname((string)App::get('basePath')).'/.htaccess',
                        DataRenderer::renderTemplate(self::$template,
                            [
                                'basename'=>basename((string)App::get('basePath')),
                                'token'=>'usethistoken'
                            ]
                        )
                    );
                    PostCheck::formatPrintLn(['green'],"\t done");
                    break;
                }
                if ($line=='n'){
                    break;
                }
            }

             
        } 
    }
}
