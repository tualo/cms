<?php
namespace Tualo\Office\CMS\CMSMiddleware;
use Tualo\Office\Basic\TualoApplication as App;
use Tualo\Office\PUG\Request as R;

class Request{
    public static function request():mixed{
        return function(string|null $key):mixed{
            $req = new R();
            if(is_null($key))  return ''; 
            $result = $req->get($key);
            return $result;
        };
    }

    public function db() { return App::get('session')->getDB(); }
    
    

    public static function run(&$request,&$result){
        $result['request']= self::request();
    }
}
