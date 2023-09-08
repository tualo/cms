<?php
namespace Tualo\Office\CMS\CMSMiddleware;
use Tualo\Office\Basic\TualoApplication as App;
use Michelf\MarkdownExtra;
use Parsedown;

class Markdown {
    public static function markdownfn():mixed{
        return function(string|null $markdownText):string{
            $Parsedown = new Parsedown();
            if(is_null($markdownText))  return ''; 
            $result = $Parsedown->text($markdownText);
            if (strpos($result,"<p>")===0) $result = substr( $result ,3,-4);
            return $result;
        };
    }

    public function db() { return App::get('session')->getDB(); }
    
    

    public static function run(&$request,&$result){
        $result['markdown']= self::markdownfn();
    }
}
