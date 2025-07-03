<?php

namespace Tualo\Office\CMS\CMSMiddleware;


class CSRFToken
{
    public static function fn(): callable
    {
        return function (bool $recreate = false): string {
            if (isset($_SESSION['csrf']) && $_SESSION['csrf'] != '' && !$recreate) {
                return $_SESSION['csrf'];
            } else {
                $_SESSION['csrf'] = uniqid('', true);
            }
            return $_SESSION['csrf'];
        };
    }




    public static function run(&$request, &$result)
    {
        $result['csrf'] = self::fn();
    }
}
