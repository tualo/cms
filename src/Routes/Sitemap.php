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

class Sitemap implements IRoute
{

    public static function register()
    {
        Route::add('/tualocms/page/sitemap.xml', function ($matches) {


            $name = TualoApplication::configuration('cms', 'domain', $_SERVER['SERVER_NAME']);
            TualoApplication::contenttype('text/xml');
            $data = [];
            $data[] = '<?xml version="1.0" encoding="UTF-8"?>';
            $data[] = '<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">';
            $data[] = '<url>';
            $data[] = '<loc>https://' . $name . '</loc>';
            $data[] = '<lastmod>' . date('Y-m-d', time()) . '</lastmod>';
            $data[] = '    <changefreq>daily</changefreq>';
            $data[] = '<priority>1</priority>';
            $data[] = '</url>';
            $data[] = '</urlset>';
            TualoApplication::body(implode("\n", $data));
            Route::$finished = true;
        }, array('get'), false);
    }
}
