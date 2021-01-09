<?php
namespace tualo\Office\CMS\Routes;
use tualo\Office\Basic\TualoApplication as App;
use tualo\Office\Basic\Route as BasicRoute;
use tualo\Office\Basic\IRoute;


class Route implements IRoute{
    public static function register(){
        BasicRoute::add('/cms/(?P<file>[\/.\w\d\-\_]+)'.'.js',function($matches){
            if (file_exists( dirname(__DIR__).'/js/'.$matches['file'].'.js') ){
                App::etagFile( dirname(__DIR__).'/js/'.$matches['file'].'.js' , true);
            }
        },array('get'),false);


        BasicRoute::add('/cms/hello',function($matches){
            App::result('msg', 'hello world' );
            App::result('success', true );

            App::result('skeleton_time_loggedIn',$_SESSION['skeleton_time_loggedIn']);
            App::result('skeleton_time',$_SESSION['skeleton_time']);
            
            App::contenttype('application/json');
        },array('get'),false);


    }
}