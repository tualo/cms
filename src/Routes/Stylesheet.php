<?php
namespace Tualo\Office\CMS\Routes;
use Tualo\Office\Basic\TualoApplication;
use Tualo\Office\Basic\Route;
use Tualo\Office\Basic\IRoute;

use Tualo\Office\PUG\PUGRenderingHelper;
use Tualo\Office\CMS\CMSMiddlewareWMHelper;
use Tualo\Office\CMS\CMSRenderingHelper;

class Stylesheet implements IRoute{
    public static function register(){
        
        Route::add('/cms/page/stylesheet/(?P<id>[\w\-\_]+)',function($matches){


            $db = TualoApplication::get('session')->getDB();
            $session = TualoApplication::get('session');
            try {
                $data = $db->singleValue('select group_concat(css separator \'
                \') css from view_readtable_ds_renderer_stylesheet_groups_assign where pug_id={id} and active=1 ',$matches,'css' );
                TualoApplication::body( $data );
        
            }catch(\Exception $e){
                TualoApplication::result('msg', $e->getMessage());
            }
            TualoApplication::contenttype('text/css');
        },array('get'),true);


    }
}