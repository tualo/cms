<?php
namespace Tualo\Office\CMS;
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
            ->description('installs needed sql procedures for cms module')
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

            'ds_class'=> 'setup ds_class',

            'tualocms_attribute' => 'setup tualocms_attribute',
            'tualocms_attribute.ds' => 'setup tualocms_attribute.ds',

            'tualocms_middleware' => 'setup tualocms_middleware',
            'tualocms_middleware.ds' => 'setup tualocms_middleware.ds',
            

            'tualocms_page' => 'setup tualocms_page',
            'tualocms_page.ds' => 'setup tualocms_page.ds',


            'tualocms_page_middleware' => 'setup tualocms_page_middleware',
            'tualocms_page_middleware.ds' => 'setup tualocms_page_middleware.ds',

            'tualocms_section' => 'setup tualocms_section',
            'tualocms_section.ds' => 'setup tualocms_section.ds',

            'tualocms_section_tualocms_attributes' => 'setup tualocms_section_tualocms_attributes',
            'tualocms_section_tualocms_attributes.ds' => 'setup tualocms_section_tualocms_attributes.ds',

            'tualocms_section_tualocms_page'    => 'setup tualocms_section_tualocms_page',
            'tualocms_section_tualocms_page.ds' => 'setup tualocms_section_tualocms_page.ds',

        ];
    
        foreach($files as $file=>$msg){
            $installSQL = function(string $file){
    
                $filename = __DIR__.'/sql/'.$file.'.sql';
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
