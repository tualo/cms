<?php

namespace Tualo\Office\CMS\Routes;

use Tualo\Office\Basic\TualoApplication as App;
use Tualo\Office\Basic\Route as BasicRoute;
use Tualo\Office\Basic\IRoute;


class Route extends \Tualo\Office\Basic\RouteWrapper
{
    public static function register()
    {
        BasicRoute::add('/cms/(?P<file>[\/.\w\d\-\_]+)' . '.js', function ($matches) {
            if (file_exists(dirname(__DIR__) . '/js/' . $matches['file'] . '.js')) {
                App::etagFile(dirname(__DIR__) . '/js/' . $matches['file'] . '.js', true);
            }
        }, array('get'), false);


        BasicRoute::add('/cms/hello', function ($matches) {
            App::result('msg', 'hello world');
            App::result('success', true);

            App::result('skeleton_time_loggedIn', $_SESSION['skeleton_time_loggedIn']);
            App::result('skeleton_time', $_SESSION['skeleton_time']);

            App::contenttype('application/json');
        }, array('get'), false);
    }
}
