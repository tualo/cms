<?php
namespace Tualo\Office\CMS\CMSMiddleware;
use Tualo\Office\Basic\TualoApplication as App;

class Session {
    public function db() { return App::get('session')->getDB(); }
    public function get($key):mixed { 
        return $_SESSION[$key]; 
    }
    public function set($key,$value):Session { 
        @session_start();
        $_SESSION[$key]=$value; 
        return $this;
    }

    public static function run(&$request,&$result){
        $result['session']= new Session() ;
    }
}