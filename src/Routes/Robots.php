<?php

namespace Tualo\Office\CMS\Routes;

use Tualo\Office\Basic\TualoApplication;
use Tualo\Office\Basic\Route;
use Tualo\Office\Basic\IRoute;
use Tualo\Office\DS\DSTable;

use Tualo\Office\PUG\PUG;
use Tualo\Office\PUG\PUGRenderingHelper;

use Tualo\Office\CMS\CMSMiddlewareHelper;

class Robots implements IRoute
{

    public static function register()
    {
        Route::add('/tualocms/page/robots.txt', function ($matches) {
            header("Permissions-Policy: geolocation=(),microphone=(),sync-xhr=(self),camera=(),usb=()");
            header("Content-Security-Policy:  base-uri 'self'; default-src 'self' data:; script-src 'self'; style-src 'self' ; form-action 'self'; img-src 'self' data:; worker-src 'self';");
            $name = TualoApplication::configuration('cms', 'domain', $_SERVER['SERVER_NAME']);
            $content = "User-agent: *\nDisallow: / \n\nSitemap: https://$name/sitemap.xml";
            try {
                $db_content = DSTable::instance("tualocms_default_robots")->f('id', '=', 'default')->getSingle();
                if ($db_content) {
                    $content = $db_content['content'];
                }
            } catch (\Exception $e) {
                // TualoApplication::result('error', $e->getMessage());
            } finally {
                // TualoApplication::result('success', true);
            }
            TualoApplication::contenttype('text/plain');
            TualoApplication::body($content);
            Route::$finished = true;
            //}
        }, array('get'), false);
    }
}
