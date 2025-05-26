<?php

namespace Tualo\Office\CMS\Routes;

use Tualo\Office\Basic\TualoApplication;
use Tualo\Office\Basic\Route;
use Tualo\Office\Basic\IRoute;
use Tualo\Office\DS\DSTable;

use Tualo\Office\PUG\PUG;
use Tualo\Office\PUG\PUGRenderingHelper;

use Tualo\Office\CMS\CMSMiddlewareHelper;
use Spatie\Sitemap\SitemapGenerator;

class Page implements IRoute
{

    public static function register()
    {
        Route::add('/tualocms/page/sitemap.xml', function ($matches) {


            $name = TualoApplication::configuration('cms', 'domain', $_SERVER['SERVER_NAME']);
            TualoApplication::contenttype('text/xml');
            TualoApplication::body(SitemapGenerator::create('https://' . $name . '/')->render());
        }, array('get'), false);
    }
}
