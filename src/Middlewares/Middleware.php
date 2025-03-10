<?php

namespace Tualo\Office\CMS\Middlewares;

use Tualo\Office\Basic\TualoApplication as App;
use Tualo\Office\Basic\IMiddleware;

class Middleware implements IMiddleware
{
    public static function register()
    {
        App::use('tualocms', function () {
            try {
                $session = App::get('session');
                if (App::configuration('cms', 'rewrite_htaccess', 0) == 1) {
                    if (file_exists(dirname("" . App::get('basePath')) . '/.htaccess')) {

                        if (isset($_SESSION['tualoapplication']) && (isset($_SESSION['tualoapplication']['oauth']))) {

                            $defaultDays = App::configuration('cms', 'oauth_days', 365);
                            $replace_before_days = App::configuration('cms', 'replace_before_days', 60);


                            $list = $session->db->direct(
                                'select 
                                oauth.id,
                                oauth_path.path
                            from oauth join oauth_path on oauth.id = oauth_path.id where oauth.id = {oauth_id} and oauth.singleuse=0 and (oauth.validuntil + interval - {days} day) < now() and oauth_path.path = {path}',
                                [
                                    'days' => $replace_before_days,
                                    'odays' => $defaultDays,
                                    'oauth_id' => $_SESSION['tualoapplication']['oauth'],
                                    'path' => 'tualocms/page/*'
                                ]
                            );



                            if (count($list) > 0) {

                                $session->db->execute('begin transaction');
                                $session->db->direct(
                                    'delete from oauth where id  in (select id from oauth_path where path = {path})',
                                    ['path' => 'tualocms/page/*']
                                );

                                $session->db->direct(
                                    'delete from oauth_path where path = {path}',
                                    ['path' => 'tualocms/page/*']
                                );

                                $token = $session->registerOAuth($params = ['cmp' => 'cmp_ds'], $force = true, $anyclient = false, $path = 'tualocms/page/*');
                                $session->oauthValidDays($token, $defaultDays);

                                $content = file_get_contents(dirname("" . App::get('basePath')) . '/.htaccess');
                                // (?<match>~[0-9a-z\-]*)
                                if (preg_match('#~/(?<old_token>[0-9a-z\-]*)/tualocms/page#', $content, $matches) !== false) {
                                    $old_token = $matches['old_token'];
                                    $content = str_replace($old_token, $token, $content);
                                    file_put_contents(dirname("" . App::get('basePath')) . '/.htaccess', $content);
                                    unset($_SESSION['tualoapplication']['oauth']);
                                    $session->db->execute('commit');
                                }
                            }
                        }
                    }
                }
            } catch (\Exception $e) {
                App::set('maintanceMode', 'on');
                App::addError($e->getMessage());
            }
        }, 100000000);
    }
}
