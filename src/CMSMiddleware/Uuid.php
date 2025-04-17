<?php

namespace Tualo\Office\CMS\CMSMiddleware;

use Ramsey\Uuid\Uuid as U;


class Uuid
{

    public function uuid(): mixed
    {
        return (U::uuid4())->toString();
    }

    public static function run(&$request, &$result)
    {
        $result['uuid'] = new Uuid();
    }
}
