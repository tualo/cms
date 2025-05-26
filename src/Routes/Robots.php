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

    public static function register()
    {
        Route::add('/tualocms/page/robots.txt', function ($matches) {
            header("Permissions-Policy: geolocation=(),microphone=(),sync-xhr=(self),camera=(),usb=()");
            header("Content-Security-Policy:  base-uri 'self'; default-src 'self' data:; script-src 'self'; style-src 'self' ; form-action 'self'; img-src 'self' data:; worker-src 'self';");
            /*
            if ($robots) {
                header("Permissions-Policy: geolocation=(),microphone=(),sync-xhr=(self),camera=(),usb=()");
                header("Content-Security-Policy:  base-uri 'self'; default-src 'self' data:; script-src 'self'; style-src 'self' ; form-action 'self'; img-src 'self' data:; worker-src 'self';");
                TualoApplication::contenttype('text/plain');
                echo $robots;
            } else {
            */
            $name = TualoApplication::configuration('cms', 'domain', $_SERVER['SERVER_NAME']);
            TualoApplication::contenttype('text/plain');
            echo "User-agent: *\nDisallow: / \n\nSitemap: https://$name/sitemap.xml";
            //}
        }, array('get'), false);
    }
}
