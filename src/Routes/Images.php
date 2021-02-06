<?php
namespace Tualo\Office\CMS\Routes;
use Tualo\Office\Basic\TualoApplication;
use Tualo\Office\Basic\Route;
use Tualo\Office\Basic\IRoute;

use Tualo\Office\PUG\PUGRenderingHelper;
use Tualo\Office\CMS\CMSMiddlewareWMHelper;
use Tualo\Office\CMS\CMSRenderingHelper;

use Tualo\Office\DS\DSFileHelper;

class Images implements IRoute{
    public static function register(){

        Route::add('/cms/page/images/(?P<tablename>[\w\-\_]+)/(?P<id>[\w\-\_]+).png',function($matches){
            $db = TualoApplication::get('session')->getDB();
            $session = TualoApplication::get('session');
            try {
                $id = $db->singleValue('select doc_id from `'.$matches['tablename'].'_doc` where id = {id} ',$matches,'doc_id');
                $m = DSFileHelper::getFileMimeType($db,$matches['tablename'],$id);
                $f = DSFileHelper::getFile($db,$matches['tablename'],$id,$direct=true,$base64=true);

                TualoApplication::contenttype( 'image/png' );
                TualoApplication::body( base64_decode($f['data']) );
                Route::$finished = true;
            }catch(\Exception $e){
                TualoApplication::result('msg', $e->getMessage());
            }

        },array('get'),true);


    }
}