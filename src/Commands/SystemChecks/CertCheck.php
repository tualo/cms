<?php

namespace Tualo\Office\CMS\Commands\SystemChecks;

use Tualo\Office\Basic\SystemCheck;
use Tualo\Office\Basic\TualoApplication as App;

class CertCheck extends SystemCheck
{

    public static function hasClientTest(): bool
    {
        return true;
    }

    public static function hasSessionTest(): bool
    {
        return false;
    }

    public static function getModuleName(): string
    {
        return 'cms auth tokens';
    }

    public static function testSessionDB(array $config): int
    {
        return 0;
    }

    public static function test(array $config): int
    {
        $return_value = 0;

        $clientdb = App::get('clientDB');
        if (is_null($clientdb)) return 1;
        // self::formatPrintLn(['blue'], 'AuthTokens SystemCheck:');

        $urls = [];




        $tualocms_domains = $clientdb->direct('select * from tualocms_domains');
        if (count($tualocms_domains) == 0) {
            self::formatPrintLn(['red'], 'No Domains found.');
            return 2;
        }

        foreach ($tualocms_domains as $domain) {
            if (isset($domain['domain'])) {
                self::intent();
                self::formatPrintLn(['blue'], 'Domain found: ' . $domain['domain']);
                $tualocms_domain_ips = $clientdb->direct('select * from tualocms_domain_ip where domain = {domain}', $domain);
                if (count($tualocms_domain_ips) == 0) {
                    self::formatPrintLn(['red'], 'No IPs found for domain: ' . $domain['domain']);
                    self::unintent();
                    return 2;
                }
                $last_fingerprint = '';
                $last_valid_date = 0;
                foreach ($tualocms_domain_ips as $domain_ip) {


                    self::formatPrintLn(['blue'], 'IP found: ' . $domain_ip['ip']);
                    self::intent();


                    $get = stream_context_create(
                        [
                            "ssl" => [
                                'peer_name' => $domain['domain'],
                                "capture_peer_cert" => TRUE
                            ]
                        ]
                    );
                    $read = stream_socket_client("ssl://" . $domain_ip['ip'] . ":443", $errno, $errstr, 30, STREAM_CLIENT_CONNECT, $get);
                    $cert = stream_context_get_params($read);
                    $certinfo = openssl_x509_parse($cert['options']['ssl']['peer_certificate']);
                    if ($certinfo === false) {
                        self::formatPrintLn(['red'], 'Could not parse certificate for domain: ' . $domain['domain'] . ' IP: ' . $domain_ip['ip']);
                        $return_value += 1;
                        self::unintent();
                        continue;
                    }

                    $fingerprint = openssl_x509_fingerprint($cert['options']['ssl']['peer_certificate'], 'sha256', false);
                    if ($fingerprint === false) {
                        self::formatPrintLn(['red'], 'Could not get fingerprint for domain: ' . $domain['domain'] . ' IP: ' . $domain_ip['ip']);
                        $return_value += 1;
                        self::unintent();
                        continue;
                    }

                    $valid_to_unix = $certinfo['validTo_time_t'];
                    $valid_date = date("d.m.Y", $valid_to_unix);

                    if (($last_fingerprint != '') && ($fingerprint != $last_fingerprint)) {
                        self::formatPrintLn(['red'], '❌  Fingerprint changed for domain: ' . $domain['domain'] . ' IP: ' . $domain_ip['ip']);
                        $return_value += 1;
                    }
                    if (($last_valid_date != 0) && ($valid_to_unix < $last_valid_date)) {
                        self::formatPrintLn(['red'], '❌  Certificate valid date changed for domain: ' . $domain['domain'] . ' IP: ' . $domain_ip['ip']);
                        $return_value += 1;
                    }
                    if ($valid_to_unix < time()) {
                        self::formatPrintLn(['red'], '❌  Certificate expired for domain: ' . $domain['domain'] . ' IP: ' . $domain_ip['ip']);
                        $return_value += 1;
                    }

                    if (($valid_to_unix > time()) && (($last_valid_date == 0) || ($valid_to_unix == $last_valid_date))) {
                        self::formatPrintLn(['green'], '✅  Valid until: ' . $valid_date);
                    }


                    if (($last_fingerprint == '') || ($fingerprint == $last_fingerprint)) {
                        self::formatPrintLn(['green'], '✅  Fingerprint: ' . $fingerprint);
                    }

                    $last_fingerprint = $fingerprint;
                    $last_valid_date = $valid_to_unix;

                    self::unintent();
                }
                self::unintent();
            }
        }
        return $return_value;
    }
}
