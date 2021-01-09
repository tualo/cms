<?php
namespace tualo\Office\CMS\Routes;
use tualo\Office\Basic\TualoApplication;
use tualo\Office\Basic\Route;
use tualo\Office\Basic\IRoute;

use tualo\Office\PUG\PUGRenderingHelper;
use tualo\Office\CMS\CMSMiddlewareWMHelper;
use tualo\Office\CMS\CMSRenderingHelper;

class Page implements IRoute{
    public static function register(){
        


        Route::add('/cms/page/(?P<path>.*)',function($matches){

            $path = $matches['path'];

            $db = TualoApplication::get('session')->getDB();
            $session = TualoApplication::get('session');
            try {
                $data = $db->singleRow('select pug_file,page_title,page_content from page_content where id={path}',array('path'=>$path));
                if ($data){


                    $template=$data['pug_file'];

                    $_REQUEST['tablename']='page_content';
                    $_REQUEST['id'] = $path;


                    if (!file_exists(TualoApplication::get("basePath").'/cache/'.$db->dbname)){
                        mkdir(TualoApplication::get("basePath").'/cache/'.$db->dbname);
                    }
                    if (!file_exists(TualoApplication::get("basePath").'/cache/'.$db->dbname.'/ds')){
                        mkdir(TualoApplication::get("basePath").'/cache/'.$db->dbname.'/ds');
                    }
                    if (!file_exists(TualoApplication::get("basePath").'/cache/'.$db->dbname.'/cache')){
                        mkdir(TualoApplication::get("basePath").'/cache/'.$db->dbname.'/cache');
                    }
                    if (!file_exists(TualoApplication::get("basePath").'/cache/'.$db->dbname.'/readcache')){
                        mkdir(TualoApplication::get("basePath").'/cache/'.$db->dbname.'/readcache');
                    }
                    TualoApplication::set("pugCachePath", TualoApplication::get("basePath").'/cache/'.$db->dbname.'/cache' );



                    set_time_limit(300);
                    $_REQUEST['pug_cache']=TualoApplication::get("basePath").'/cache/'.$db->dbname.'/ds';
                    $GLOBALS['pug_cache']=TualoApplication::get("basePath").'/cache/'.$db->dbname.'/ds';
                    
                    TualoApplication::set("pugCachePath",$GLOBALS['pug_cache']);
                    PUGRenderingHelper::exportPUG($db);

                    $GLOBALS['pug_merge'] = [];
                    $GLOBALS['pug_merge']['cms']=CMSMiddlewareWMHelper::$result;
                    
                     $hash = md5( $template.$_REQUEST['id'] );
                    /*
                    if (file_exists(TualoApplication::get("basePath").'/cache/'.$db->dbname.'/readcache/'.$hash)){
                        $html = file_get_contents(TualoApplication::get("basePath").'/cache/'.$db->dbname.'/readcache/'.$hash);
                    }else{
                    */
                        $html = PUGRenderingHelper::render( PUGRenderingHelper::getIDArray($matches,$_REQUEST) ,$template, $_REQUEST);
                        file_put_contents(TualoApplication::get("basePath").'/cache/'.$db->dbname.'/readcache/'.$hash,$html);
                    /*}*/


                    TualoApplication::body( $html );
                    if (isset( $_SESSION['session_error'] )){
                        unset($_SESSION['session_error']);
                    }

                }


            }catch(\Exception $e){
                TualoApplication::result('msg', $e->getMessage());
            }
            TualoApplication::contenttype('text/html');
        },array('get','post'),true);



    }
}