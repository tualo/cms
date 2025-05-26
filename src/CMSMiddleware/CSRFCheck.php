<?php

namespace Tualo\Office\CMS\CMSMiddleware;

use Tualo\Office\Basic\TualoApplication as App;
use Michelf\MarkdownExtra;
use Parsedown;

class CSRFCheck
{
    public static function check(): bool
    {
        if (

            isset($_SESSION['csrf']) &&
            isset($_REQUEST['csrf']) &&
            $_SESSION['csrf'] != '' &&
            $_REQUEST['csrf'] != ''

        ) {
            if ($_SESSION['csrf'] !== $_REQUEST['csrf']) {
                return false;
            }
            return true;
        }
        return false;
    }




    public static function run(&$request, &$result)
    {
        if (self::check() === false) {
            $result['responsecode'] = 403; // Forbidden
            $result['response'] = 'CSRF token is invalid';
        }
    }
}
