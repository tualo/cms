<?php
namespace Tualo\Office\CMS\Commands;
use Garden\Cli\Cli;
use Garden\Cli\Args;
use phpseclib3\Math\BigInteger\Engines\PHP;
use Tualo\Office\Basic\ICommandline;
use Tualo\Office\ExtJSCompiler\Helper;
use Tualo\Office\Basic\TualoApplication as App;
use Tualo\Office\Basic\PostCheck;

class InstallMainSQLCommandline implements ICommandline{

    public static function getCommandName():string { return 'install-sql-cms';}

    public static function setup(Cli $cli){
        $cli->command(self::getCommandName())
            ->description('installs needed sql procedures for papervote module')
            ->opt('client', 'only use this client', true, 'string');
            
    }

   
    public static function setupClients(string $msg,string $clientName,string $file,callable $callback){
        $_SERVER['REQUEST_URI']='';
        $_SERVER['REQUEST_METHOD']='none';
        App::run();

        $session = App::get('session');
        $sessiondb = $session->db;
        $dbs = $sessiondb->direct('select username dbuser, password dbpass, id dbname, host dbhost, port dbport from macc_clients ');
        foreach($dbs as $db){
            if (($clientName!='') && ($clientName!=$db['dbname'])){ 
                continue;
            }else{
                App::set('clientDB',$session->newDBByRow($db));
                PostCheck::formatPrint(['blue'],$msg.'('.$db['dbname'].'):  ');
                $callback($file);
                PostCheck::formatPrintLn(['green'],"\t".' done');

            }
        }
    }

    public static function run(Args $args){

        $files = [
            'ddl-cms' => 'setup main ddl ',
            'middlewares' => 'setup cms middlewares ',
            'ds.definition' => 'setup cms ds definition ',

            'install/ds_class'=> 'setup ds_class',

            'install/tualocms_attribute' => 'setup tualocms_attribute',
            'install/tualocms_attribute.ds' => 'setup tualocms_attribute.ds',

            'install/tualocms_middleware' => 'setup tualocms_middleware',
            'install/tualocms_middleware.ds' => 'setup tualocms_middleware.ds',
            

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



        ];


        foreach($files as $file=>$msg){
            $installSQL = function(string $file){

                $filename = dirname(__DIR__).'/sql/'.$file.'.sql';
                $sql = file_get_contents($filename);
                $sql = preg_replace('!/\*.*?\*/!s', '', $sql);
                $sql = preg_replace('#^\s*\-\-.+$#m', '', $sql);

                $sinlgeStatements = App::get('clientDB')->explode_by_delimiter($sql);
                foreach($sinlgeStatements as $commandIndex => $statement){
                    try{
                        App::get('clientDB')->execute($statement);
                        App::get('clientDB')->moreResults();
                    }catch(\Exception $e){
                        echo PHP_EOL;
                        PostCheck::formatPrintLn(['red'], $e->getMessage().': commandIndex => '.$commandIndex);
                    }
                }
            };
            $clientName = $args->getOpt('client');
            if( is_null($clientName) ) $clientName = '';
            self::setupClients($msg,$clientName,$file,$installSQL);
        }


    }
}
