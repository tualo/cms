<?php

namespace Tualo\Office\CMS\Routes;

use Tualo\Office\Basic\TualoApplication;
use Tualo\Office\Basic\Route;
use Tualo\Office\Basic\IRoute;

/**
 * Class PublicRoute
 * Handles public file access in Tualo CMS.
 *
 * This route allows access to files stored in the public path of the CMS.
 * It checks for double dots in the path to prevent directory traversal attacks.
 */

class PublicRoute implements IRoute
{

    public static function register()
    {
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
    }
}
