<?php

namespace Tualo\Office\CMS;

use Tualo\Office\Basic\TualoApplication;
use Tualo\Office\PUG\PUGRenderingHelper;

class CMSMiddlewareHelper
{
    public static $db = null;
    public static $request = [];
    public static $result = [];

    public static function log($type, $data)
    {
        try {
            /* 
            create table wm_loginpage_logfile (id varchar(36) primary key,type varchar(10),createtime timestamp,uri varchar(255), data longtext);
            */

            self::$db->direct(
                '
                    insert into wm_loginpage_logfile (
                        id,
                        createtime,
                        uri,
                        type,
                        data
                    ) values (
                        uuid(),
                        current_timestamp,
                        {uri},
                        {type},
                        {data}
                        
                    )
                ',
                array(
                    'uri' => $_SERVER['REQUEST_URL'],
                    'data' => $data,
                    'type' => $type
                )
            );
        } catch (\Exception $e) {
        }
    }


    public static function query($url, $index_redirect)
    {
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_HEADER, FALSE);
        curl_setopt($ch, CURLOPT_NOBODY, FALSE);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, TRUE);
        $data = curl_exec($ch);
        $httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
        curl_close($ch);
        if ($httpCode !== 200) {
            $_SESSION['session_error'] = 'Die Identifikation ist fehlgeschlagen (Code 1 / ' + $httpCode + ')';
            header('Location: ' . $index_redirect);
            exit;
        } else {

            $object = json_decode($data, true);
            if (
                !is_null($object) &&
                isset($object["success"]) &&
                ($object["success"] === true)

            ) {
                return $object;
            } else {
                self::log('error', 'Code 2' . "\API:" . $url . "\nResult:" . $data);

                $_SESSION['session_error'] = 'Die Identifikation ist fehlgeschlagen (Code 2)';
                header('Location: ' . $index_redirect);
                exit;
            }
        }
    }

    public static function querySingleItem($url, $index_redirect)
    {
        $object = self::query($url, $index_redirect);
        if (
            isset($object["data"]) &&
            count($object["data"]) == 1
        ) {
            return $object["data"][0];
        } else {
            self::log('error', 'Code 3' . "\API:" . $url . "\nResult:" . json_encode($object));
            $_SESSION['session_error'] = 'Die Identifikation ist fehlgeschlagen (Code 3 / ' . (isset($object["total"]) ? $object["total"] : '-1') . ')';
            header('Location: ' . $index_redirect);
            exit;
        }
    }

    public static function loadWMClasses()
    {
        /*
        if (get_declared_classes()){
            if (is_subclass_of($class,'CMSMiddleWare',true)){
                
            }
        }*/
    }
}
