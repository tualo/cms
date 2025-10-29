<?php

namespace Tualo\Office\CMS\Routes;

use Tualo\Office\Basic\TualoApplication as App;
use Tualo\Office\Basic\Route as BasicRoute;
use Tualo\Office\Basic\IRoute;
use Tualo\Office\DS\DSFiles;

class Asset extends \Tualo\Office\Basic\RouteWrapper
{
    public static function register()
    {


        BasicRoute::add('/tualocms/page/asset/(?P<id>[\/.\w\d\-\_\.]+)' . '', function ($matches) {

            $image = DSFiles::instance('tualocms_dateien');
            $imagedata = $image->getBase64('titel', $matches['id'], true);
            $image_error = $image->getError();
            if ($image_error != '') {
                throw new \Exception($image_error);
            }
            BasicRoute::$finished = true;
            http_response_code(200);

            list($mime, $data) =  explode(',', $imagedata);
            $etag = md5($data);
            App::contenttype(str_replace('data:', '', $mime));


            // header("Last-Modified: ".gmdate("D, d M Y H:i:s", $last_modified_time)." GMT"); 
            header("Etag: $etag");
            header('Cache-Control: public');

            if (
                (isset($_SERVER['HTTP_IF_NONE_MATCH']) && (trim($_SERVER['HTTP_IF_NONE_MATCH']) == $etag))
            ) {
                header("HTTP/1.1 304 Not Modified");
                exit;
            }

            App::body(base64_decode($data));
            BasicRoute::$finished = true;
            http_response_code(200);
        }, ['get'], true);
    }
}
