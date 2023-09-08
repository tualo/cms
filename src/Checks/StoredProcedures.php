<?php

namespace Tualo\Office\CMS\Checks;

use Tualo\Office\Basic\Middleware\Session;
use Tualo\Office\Basic\PostCheck;
use Tualo\Office\Basic\TualoApplication as App;


class StoredProcedures extends PostCheck {

    
    public static function test(array $config){
        

        $def = [
             
        ];
        self::procedureCheck('cms',$def);
        
    }
}