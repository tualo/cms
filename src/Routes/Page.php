<?php

namespace Tualo\Office\CMS\Routes;

use Tualo\Office\Basic\TualoApplication;
use Tualo\Office\Basic\Route;
use Tualo\Office\Basic\IRoute;
use Tualo\Office\DS\DSTable;

use Tualo\Office\PUG\PUG;
use Tualo\Office\PUG\PUGRenderingHelper;

use Tualo\Office\CMS\CMSMiddlewareHelper;

class Page implements IRoute
{

    public static function datetime(): callable
    {
        return function (string $dt): \DateTime {
            return (new \DateTime($dt));
        };
    }


    public static function base64file(): callable
    {
        return function (string $tablename, string $value, string $field = '__filename'): string {
            return \Tualo\Office\DS\DSFiles::instance($tablename)->getBase64($field, $value, true);
        };
    }

    public static function dstable(): callable
    {
        return function ($tn): \Tualo\Office\DS\DSTable {
            return \Tualo\Office\DS\DSTable::instance($tn);
        };
    }

    public static function keysort(): callable
    {
        return function (array $data, string $key, string $direction = 'asc'): array {
            usort($data, function ($a, $b) use ($key, $direction) {
                if ($direction == 'asc') {
                    return $a[$key] <=> $b[$key];
                } else {
                    return $b[$key] <=> $a[$key];
                }
            });
            return $data;
        };
    }

    private static $middlWareSQL = '
        select 
            tualocms_page.path,
            tualocms_page_middleware.tualocms_middleware
        from 
            tualocms_page_middleware 
            join tualocms_page 
                on tualocms_page_middleware.tualocms_page = tualocms_page.tualocms_page
        where 
            tualocms_page.path = {path}
        order by 
            tualocms_page_middleware.position
    ';



    public static function middlewares($db, $path)
    {
        CMSMiddlewareHelper::$db = $db;
        $cmsmiddlewares = $db->directArray(self::$middlWareSQL, ['path' => $path], 'tualocms_middleware');

        $request = [];
        $result = [];
        // $request['session'] = json_decode(json_encode($_SESSION),true);
        $request['request'] = json_decode(json_encode($_REQUEST), true);

        foreach ($cmsmiddlewares as $cmsmiddleware) {
            try {
                $class = new \ReflectionClass($cmsmiddleware);
                TualoApplication::timing("cmsMiddleware $cmsmiddleware");
                if (!$class->hasMethod('run')) {
                    TualoApplication::logger('CMS')->error($cmsmiddleware . ' has no run method');
                } else {
                    $cmsmiddleware::run($request, $result);
                    TualoApplication::timing("cmsMiddleware $cmsmiddleware after run");
                }
            } catch (\Exception $e) {
                TualoApplication::logger('CMS')->error($e->getMessage());
            }
        }
        CMSMiddlewareHelper::$request = $request;
        CMSMiddlewareHelper::$result = $result;
    }

    public static function register()
    {


        Route::add('/tualocms/page/(?P<path>.*).css', function ($matches) {


            $db = TualoApplication::get('session')->getDB();
            $session = TualoApplication::get('session');
            try {
                $data = $db->singleValue('select group_concat(css separator \'
                \') css from view_readtable_ds_renderer_stylesheet_groups_assign where pug_id={path} and active=1 ', $matches, 'css');
                if ($data !== false) {
                    TualoApplication::body($data);
                    TualoApplication::contenttype('text/css');
                    Route::$finished = true;
                }
            } catch (\Exception $e) {
                TualoApplication::body('/* ' . $e->getMessage() . ' */');
            }
        }, array('get', 'post'), true);




        Route::add('/tualocms/page/public/(?P<path>.*)', function ($matches) {

            if (Route::checkDoubleDots($matches, 'path', 'Path contains ".."')) {
                if (!isset($matches['path']) || $matches['path'] == '') {
                    TualoApplication::body('Path not found');
                    TualoApplication::contenttype('text/plain');
                    http_response_code(404);
                    return;
                }


                $publicpath =  TualoApplication::configuration(
                    'tualo-cms',
                    'public_path'
                );

                if ($publicpath !== false) {
                    if (file_exists(
                        str_replace(
                            '//',
                            '/',
                            implode('/', [
                                $publicpath,
                                $matches['path']
                            ])
                        )
                    )) {
                        TualoApplication::etagFile(str_replace('//', '/', implode('/', [
                            $publicpath,
                            $matches['path']
                        ])), true);
                        Route::$finished = true;
                        http_response_code(200);
                    }
                }
            }
        }, ['get', 'post'], true);

        Route::add('/tualocms/page/(?P<path>.*)', function ($matches) {



            // header("Content-Security-Policy: base-uri 'none', base-uri 'self'; default-src 'self' data:; script-src 'self' 'sha256-+YWRMZ88jMyO7jVlBA52tZADiPobPIUA8LAWee68Fvs='; style-src 'self' 'sha256-+YWRMZ88jMyO7jVlBA52tZADiPobPIUA8LAWee68Fvs='; form-action 'self'; img-src 'self' data:; worker-src 'self' ;");

            //             header("Permissions-Policy: geolocation=(),microphone=(),sync-xhr=(self),camera=(),usb=()");



            $session = TualoApplication::get('session');
            $db = $session->getDB();

            try {
                $matches['path'] = '/' . $matches['path'];
                $table = (new DSTable($db, 'view_load_tualocms_page'))->filter(
                    'path',
                    '=',
                    $matches['path']
                );
                $table->limit(1);
                $table->read();
                if (!$table->empty()) {
                    $data = $table->getSingle();


                    $pmh = (new DSTable($db, 'view_load_tualocms_page_permission_policy'))->filter(
                        'tualocms_page',
                        '=',
                        $data['tualocms_page']
                    )->limit(1)->read();
                    if (!$pmh->empty()) {
                        $pmh = $pmh->getSingle();
                        if (isset($pmh['permission'])) {
                            header("Permissions-Policy: " . $pmh['permission']);
                        } else {
                            header("Permissions-Policy: geolocation=(),microphone=(),sync-xhr=(self),camera=(),usb=()");
                            header("CMSPMH: default PMH");
                        }
                    } else {
                        header("Permissions-Policy: geolocation=(),microphone=(),sync-xhr=(self),camera=(),usb=()");
                        header("CMSPMH: default PMH");
                    }


                    $csp = (new DSTable($db, 'view_load_tualocms_page_csp'))->filter(
                        'tualocms_page',
                        '=',
                        $data['tualocms_page']
                    )->limit(1)->read();
                    if (!$csp->empty()) {
                        $csp = $csp->getSingle();
                        if (isset($csp['csp'])) {
                            header("Content-Security-Policy: " . $csp['csp']);
                        } else {
                            header("Content-Security-Policy:  base-uri 'self'; default-src 'self' data:; script-src 'self'; style-src 'self' ; form-action 'self'; img-src 'self' data:; worker-src 'self';");
                            header("CMS: default CSP");
                        }
                    } else {
                        header("Content-Security-Policy: base-uri 'self'; default-src 'self' data:; script-src 'self'; style-src 'self' ; form-action 'self'; img-src 'self' data:; worker-src 'self';");
                        header("CMS: default CSP");
                    }

                    TualoApplication::set("pugCachePath", TualoApplication::get("basePath") . '/cache/' . $db->dbname . '/cache');
                    Route::$finished = true;
                    $template = $data['pug_file'];


                    $css = (new DSTable($db, 'ds_renderer_stylesheet_groups_assign'))
                        ->filter('active', '=', 1)
                        ->filter('pug_id', '=', $template)
                        ->read();
                    $data['stylesheets'] = $css->get();

                    PUG::exportPUG($db);
                    if (!isset($data['page'])) throw new \Exception('attribute page not found');
                    $data['page'] = json_decode($data['page'], true);
                    self::middlewares($db, $matches['path']);

                    $data = array_merge(
                        $data,
                        [
                            'datetime' => self::datetime(),
                            'base64file' => self::base64file(),
                            'dstable' => self::dstable(),
                            'keysort' => self::keysort()
                        ]
                    );
                    $data['cms'] = CMSMiddlewareHelper::$result;
                    $html = PUG::render(
                        $template,
                        $data
                    );
                    TualoApplication::body($html);
                    TualoApplication::contenttype('text/html');
                    if (isset(CMSMiddlewareHelper::$result['responsecode'])) {
                        http_response_code(CMSMiddlewareHelper::$result['responsecode']);
                    } else {
                        http_response_code(200);
                    }
                } else {


                    /*
                    if (strpos($matches['path'], '/img/') === 0) {
                        return false;
                    }

                    if (strpos($matches['path'], '/assets/') === 0) {
                        return false;
                    }

                    if (strpos($matches['path'], '/public/') === 0) {
                        return false;
                    }*/

                    //print_r(TualoApplication::get('configuration'));

                    Route::pathNotFound(function ($path) {
                        TualoApplication::body("Not found");

                        header("Permissions-Policy: geolocation=(),microphone=(),sync-xhr=(self),camera=(),usb=()");
                        header("Content-Security-Policy:  base-uri 'self'; default-src 'self' data:; script-src 'self'; style-src 'self' ; form-action 'self'; img-src 'self' data:; worker-src 'self';");
                        TualoApplication::contenttype('text/html');
                        http_response_code(404);
                    });

                    return false;
                }
            } catch (\Exception $e) {
                echo $e->getMessage();
                TualoApplication::logger('CMS')->error($e->getMessage());
                TualoApplication::result('msg', $e->getMessage());
            }
        }, ['get', 'post'], false);
    }
}
