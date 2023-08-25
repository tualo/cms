<?php

namespace Tualo\Office\CMS\Middlewares;
use Tualo\Office\Basic\TualoApplication as App;
use Tualo\Office\Basic\IMiddleware;

class Middleware implements IMiddleware{
    public static function register(){
        App::use('cms',function(){
            try{
                // App::javascript(  'skeleton_js', './skeleton/Routes.js', [], 1 );
            }catch(\Exception $e){
                App::set('maintanceMode','on');
                App::addError($e->getMessage());
            }
        },-100);

    }
}