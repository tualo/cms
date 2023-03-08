<?php
namespace Tualo\Office\CMS\Routes;
use Tualo\Office\Basic\TualoApplication;
use Tualo\Office\Basic\Route;
use Tualo\Office\Basic\IRoute;

use Tualo\Office\PUG\PUGRenderingHelper;
use Tualo\Office\CMS\CMSMiddlewareHelper;

class Page implements IRoute{
    private static $middlWareSQL = '
        select 
            page_content.id,
            page_content_middlewares.middleware
        from 
            page_content_middlewares 
            join page_content on 
            page_content_middlewares.page_content_id = page_content.id
        where 
            page_content.id = {path}
        order by 
            position
    ';

    public static function cmsMiddleware($db,$path){
        CMSMiddlewareHelper::$db=$db;
        $cmsmiddlewares = $db->directArray(self::$middlWareSQL,[ 'path'=> $path ],'middleware');

        $cmsmiddlewares[]='Tualo\Office\OnlineVote\CMSMiddleware\Init';
        $request = [];
        $result = [];
        $request['session'] = json_decode(json_encode($_SESSION),true);
        $request['request'] = json_decode(json_encode($_REQUEST),true);

        foreach($cmsmiddlewares as $cmsmiddleware){
            try{
                $class = new \ReflectionClass($cmsmiddleware);
                TualoApplication::timing("cmsMiddleware $cmsmiddleware");
                if (!$class->hasMethod('run')){ 
                    TualoApplication::logger('CMS')->error($cmsmiddleware.' has no run method'); 
                }else{
                    $cmsmiddleware::run($request,$result);
                    TualoApplication::timing("cmsMiddleware $cmsmiddleware after run");
                }
            }catch(\Exception $e ){
                TualoApplication::logger('CMS')->error($e->getMessage());
            }
        }
        CMSMiddlewareHelper::$request=$request;
        CMSMiddlewareHelper::$result=$result;
        
    }

    public static function register(){

        Route::add('/cms/page/(?P<path>.*).css',function($matches){
            $db = TualoApplication::get('session')->getDB();
            $session = TualoApplication::get('session');
            try {
                $data = $db->singleValue('select group_concat(css separator \'
                \') css from view_readtable_ds_renderer_stylesheet_groups_assign where pug_id={path} and active=1 ',$matches,'css' );
            TualoApplication::body( $data  );
            }catch(Exception $e){
                TualoApplication::body('/* '.$e->getMessage().' */');
            }
            TualoApplication::contenttype('text/css');
            Route::$finished=true;

        },array('get','post'),true);

        Route::add('/cms/page/(?P<path>.*)',function($matches){

            TualoApplication::timing("cms/page",'');
            $path = $matches['path'];

            TualoApplication::timing("cms/page get db 1");
            $session = TualoApplication::get('session');
            $db = $session->getDB();
            TualoApplication::timing("cms/page get db 2");
            
            try {
                TualoApplication::timing("before cmsMiddleware",'');
                self::cmsMiddleware($db,$path);
                TualoApplication::timing("after cmsMiddleware",'');

                $data = $db->singleRow('select pug_file,page_title,page_content from page_content where id={path}',array('path'=>$path));
                TualoApplication::timing("select page_content",'');
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
                    $GLOBALS['pug_merge']['cms']=CMSMiddlewareHelper::$result;
                    
                    $hash = md5( $template.$_REQUEST['id'] );
                    $html = PUGRenderingHelper::render( PUGRenderingHelper::getIDArray($matches,$_REQUEST) ,$template, $_REQUEST);
                    file_put_contents(TualoApplication::get("basePath").'/cache/'.$db->dbname.'/readcache/'.$hash,$html);


                    Route::$finished = true;
                    TualoApplication::body( $html );
                    TualoApplication::contenttype('text/html');

                    if (isset( $_SESSION['session_error'] )){
                        unset($_SESSION['session_error']);
                    }

    
                }


            }catch(\Exception $e){
                TualoApplication::logger('CMS')->error($e->getMessage());
                TualoApplication::result('msg', $e->getMessage());
            }
        },array('get','post'),true);



    }
}