<?php

namespace Tualo\Office\CMS\CMSMiddleware;

use Tualo\Office\Basic\TualoApplication as App;

class ServerInformation
{
    public static function serverinformation(): mixed
    {
        return function (string|null $key): mixed {
            if (!isset($_SERVER[$key]))  return false;
            $result = $_SERVER[$key];
            return $result;
        };
    }

    public function db()
    {
        return App::get('session')->getDB();
    }

    public static function run(&$request, &$result)
    {
        $result['serverinformation'] = self::serverinformation();
    }
}
