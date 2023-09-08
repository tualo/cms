<?php
namespace Tualo\Office\CMS\Checks;

use Tualo\Office\Basic\Middleware\Session;
use Tualo\Office\Basic\PostCheck;
use Tualo\Office\Basic\TualoApplication as App;


class Tables  extends PostCheck {
    
    public static function test(array $config){
        $clientdb = App::get('clientDB');
        if (is_null($clientdb)) return;
        $tables = [
            'page_content'=>[
                'columns'=>[
                    'table_name'=>'varchar(128)'
                ]
            ]
        ];
        self::tableCheck(
            'cms',$tables,
        "please run the following command: `./tm install-sql-cms --client ".$clientdb->dbname."`",
        "please run the following command: `./tm install-sql-cms --client ".$clientdb->dbname."`"
        );
    }
}