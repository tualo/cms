<?php

namespace Tualo\Office\CMS\CMSMiddleware;


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
            if (!is_string($_SESSION['csrf']) || is_string($_REQUEST['csrf'])) {
                return false; // CSRF tokens must be strings
            }
        }
        return true;
    }




    public static function run(&$request, &$result)
    {
        if (self::check() === false) {
            $result['responsecode'] = 403; // Forbidden
            $result['response'] = 'CSRF token is invalid';
        }
    }
}
