<?php

namespace Tualo\Office\CMS\CMSMiddleware;

use Tualo\Office\Basic\TualoApplication as App;
use Michelf\MarkdownExtra;

// use Parsedown; // Deprecated, using Michelf\MarkdownExtra instead
class Markdown
{


    public static function markdownExtrafn(): mixed
    {
        return function (string|null $markdownText): string {
            if (is_null($markdownText))  return '';
            $result = MarkdownExtra::defaultTransform($markdownText);
            if (strpos($result, "<p>") === 0) $result = substr($result, 3, -5);
            return $result;
        };
    }

    public static function markdownfn(): mixed
    {
        return function (string|null $markdownText): string {
            if (is_null($markdownText))  return '';
            $result  = MarkdownExtra::defaultTransform($markdownText);
            if (strpos($result, "<p>") === 0) $result = substr($result, 3, -5);
            return $result;
        };
    }


    public function db()
    {
        return App::get('session')->getDB();
    }



    public static function run(&$request, &$result)
    {
        $result['markdown'] = self::markdownfn();
        $result['markdownExtra'] = self::markdownExtrafn();
    }
}
