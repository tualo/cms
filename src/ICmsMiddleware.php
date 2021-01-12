<?php
namespace Tualo\Office\CMS;

interface ICmsMiddleware
{
    public static function run(&$request,&$result);
}