<?php
namespace Tualo\Office\CMS\Routes;
use Tualo\Office\Basic\TualoApplication;
use Tualo\Office\Basic\Route;
use Tualo\Office\Basic\IRoute;

use Tualo\Office\PUG\PUGRenderingHelper;
use Tualo\Office\CMS\CMSMiddlewareWMHelper;
use Tualo\Office\CMS\CMSRenderingHelper;

class Page implements IRoute{

    public static function cmsMiddleware($db,$path){
        CMSMiddlewareWMHelper::$db=$db;

        $cmsmiddlewares = $db->direct('
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
        ',array('path'=> $path ));

        $request = [];
        $result = [];
        $request['session'] = json_decode(json_encode($_SESSION),true);
        $request['request'] = json_decode(json_encode($_REQUEST),true);


        $classes = get_declared_classes();
        
        $aICmsMiddlewares=[];
        foreach($classes as $cls){
            $class = new \ReflectionClass($cls);
            if ( $class->implementsInterface('Tualo\Office\CMS\ICmsMiddleware') ) {
                $aICmsMiddlewares[$cls] = $cls;
                $a=explode("\\",$cls);
                $aICmsMiddlewares[array_pop($a)] = $cls;

            }
        }
        foreach($cmsmiddlewares as $cmsmiddleware){
            if (
                isset($aICmsMiddlewares[$cmsmiddleware['middleware']])
            ){
                $aICmsMiddlewares[$cmsmiddleware['middleware']]::run($request,$result);
            }else{
                throw new \Exception("cannot get ".$cmsmiddleware['middleware']);
            }
        }

        CMSMiddlewareWMHelper::$request=$request;
        CMSMiddlewareWMHelper::$result=$result;
    }

    public static function register(){


        Route::add('/cms/page/(?P<path>.*)',function($matches){

            TualoApplication::timing("cms/page",'');
            $path = $matches['path'];



            $db = TualoApplication::get('session')->getDB();
            $session = TualoApplication::get('session');
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
                    $GLOBALS['pug_merge']['cms']=CMSMiddlewareWMHelper::$result;
                    
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
                echo $e->getMessage();
                TualoApplication::result('msg', $e->getMessage());
            }
        },array('get','post'),true);



    }
}