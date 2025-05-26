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
            $_REQUEST['csrf'] != '' &&
            $_SESSION['csrf'] === $_REQUEST['csrf']
        ) {
            // CSRF token is valid
            // Optionally, you can regenerate the token to prevent reuse
            return true;
        }
        return false;
    }




    public static function run(&$request, &$result)
    {
        if (self::check()) {
            $result['csrf'] = true;
        } else {
            $result['csrf'] = false;
            $result['responsecode'] = 403; // Forbidden
            $result['response'] = 'CSRF token is invalid';
            // Optionally, you can throw an exception or handle the error
            // throw new \Exception('CSRF token is invalid');
        }
    }
}
