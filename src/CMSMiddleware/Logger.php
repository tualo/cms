<?php

namespace Tualo\Office\CMS\CMSMiddleware;


use Tualo\Office\Basic\TualoApplication as App;

class Logger
{


    public static function logger(): mixed
    {

        return function () {
            return App::logger('CMSMiddleware-Logger');
        };
    }

    public static function run(array &$request, array &$result)
    {
        $result['logger'] = self::logger();
    }
}
