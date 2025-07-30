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
                foreach ($tualocms_domain_ips as $domain_ip) {

                    self::formatPrintLn(['blue'], 'IP found: ' . $domain_ip['ip']);
                    $urls[] = [
                        'name' => $domain['domain'],
                        'url' => 'https://' . $domain['domain'],
                        'ip' => $domain_ip['ip']
                    ];

                    // serialNumberHex
                }
                self::unintent();
            }
        }
        /*

        $urls[] = array(
            "name" => "Domain 1 Name (1)",
            "url" => "https://datencheck.stimmzettel.online",
            "ip" => "85.214.23.79"
        );

        $urls[] = array(
            "name" => "Domain 1 Name (2)",
            "url" => "https://datencheck.stimmzettel.online",
            "ip" => "85.214.33.39"
        );

        if (count($urls) == 0) {
            self::formatPrintLn(['red'], 'No URLs configured for SSL check.');
            return 1;
        }

        self::formatPrintLn(['green'], 'SSL Certificates for configured URLs:');

        foreach ($urls as $value) {

            $ip = $value['ip'];
            if (filter_var($ip, FILTER_VALIDATE_IP) === false) {
                self::formatPrintLn(['red'], 'Invalid IP address: ' . $ip);
                continue;
            }
            $orignal_parse = parse_url($value['url'], PHP_URL_HOST);
            $get = stream_context_create(
                [
                    "ssl" => [
                        'peer_name' => $orignal_parse,
                        "capture_peer_cert" => TRUE
                    ]
                ]
            );
            $read = stream_socket_client("ssl://" . $ip . ":443", $errno, $errstr, 30, STREAM_CLIENT_CONNECT, $get);
            echo "ssl://" . $orignal_parse . ":443" . "\n";
            // 85.214.23.79
            $cert = stream_context_get_params($read);
            $certinfo = openssl_x509_parse($cert['options']['ssl']['peer_certificate']);
            $valid_to_unix = $certinfo['validTo_time_t'];

            print_r($certinfo);
            echo "BEGIN:VEVENT\n";
            // echo "UID:" . uniqid() . "\n";
            echo "DTSTAMP:" . date("Ymd") . "T" . date("His") . "Z\n";
            echo "DTSTART:" . date("Ymd", $valid_to_unix) . "T080000Z\n";
            echo "DTEND:" . date("Ymd", $valid_to_unix) . "T160000Z\n";
            echo "SUMMARY:SSL Cert - {$value['name']}\n";
            echo "END:VEVENT\n\n";
        }
            */


        return 0;
    }
}
