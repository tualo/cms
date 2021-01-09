<?php
namespace tualo\Office\CMS;
use tualo\Office\Basic\TualoApplication;

class CMSRenderingHelper{
    public static function pugPath($db){
        if (!file_exists(TualoApplication::get("basePath").'/cache/'.$db->dbname)){
            mkdir(TualoApplication::get("basePath").'/cache/'.$db->dbname);
        }
        if (!file_exists(TualoApplication::get("basePath").'/cache/'.$db->dbname.'/cms/')){
            mkdir(TualoApplication::get("basePath").'/cache/'.$db->dbname.'/cms/');
        }
        if (!file_exists(TualoApplication::get("basePath").'/cache/'.$db->dbname.'/cmspugcache/')){
            mkdir(TualoApplication::get("basePath").'/cache/'.$db->dbname.'/cmspugcache/');
        }

        return TualoApplication::get("basePath").'/cache/'.$db->dbname.'/cms/';
    }

    public static function exportPUG($db){
        $data = $db->direct('select concat(id,\'.pug\') filename,template pug_data from ds_pug_templates');
        foreach($data as $row){
            file_put_contents( self::pugPath($db).'/'.$row['filename'].'',$row['pug_data'] );
        }
    }

}