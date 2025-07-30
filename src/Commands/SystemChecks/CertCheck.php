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

        $allowed_valid_days = 21;


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

                    $dns = dns_get_record($domain['domain'], DNS_A | DNS_AAAA);
                    if (count($dns) == 0) {
                        self::formatPrintLn(['red'], 'No DNS records found for domain: ' . $domain['domain']);
                        self::unintent();
                        return 2;
                    } else {
                        self::formatPrintLn(['yellow'], 'No IPs found in database for domain: ' . $domain['domain'] . ', using DNS records instead.');
                        $tualocms_domain_ips = array_map(function ($ip) {
                            return ['ip' => $ip['ip']];
                        }, $dns);

                        foreach ($tualocms_domain_ips as $domain_ip) {
                            //tualocms_domain_ip
                            $sql = '
                            insert into tualocms_domain_ip (domain, ip) values ({domain}, {ip}) 
                            on duplicate key update ip = values(ip)
                            ';
                            $clientdb->direct($sql, [
                                'domain' => $domain['domain'],
                                'ip' => $domain_ip['ip']
                            ]);
                            self::formatPrintLn(['green'], '✅  Added IP: ' . $domain['domain'] . ' -> ' . $domain_ip['ip']);
                        }
                    }
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
                        self::formatPrintLn(['red'], '❌  Could not parse certificate for domain: ' . $domain['domain'] . ' IP: ' . $domain_ip['ip']);
                        $return_value += 1;
                        self::unintent();
                        continue;
                    }

                    $fingerprint = openssl_x509_fingerprint($cert['options']['ssl']['peer_certificate'], 'sha256', false);
                    if ($fingerprint === false) {
                        self::formatPrintLn(['red'], '❌  Could not get fingerprint for domain: ' . $domain['domain'] . ' IP: ' . $domain_ip['ip']);
                        $return_value += 1;
                        self::unintent();
                        continue;
                    }

                    $valid_to_unix = $certinfo['validTo_time_t'];
                    $valid_date = date("d.m.Y", $valid_to_unix);

                    $day_valid = floor(($valid_to_unix - time()) / (60 * 60 * 24));


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

                    if (($day_valid > $allowed_valid_days) && (($last_valid_date == 0) || ($valid_to_unix == $last_valid_date))) {
                        self::formatPrintLn(['green'], '✅  Valid until: ' . $valid_date . ' (' . $day_valid . ' days left)');
                    } elseif ($day_valid <= $allowed_valid_days && $day_valid > 0) {
                        self::formatPrintLn(['yellow'], '⚠️  Valid until: ' . $valid_date . ' (' . $day_valid . ' days left)');
                        $return_value += 1;
                    } elseif ($day_valid <= 0) {
                        self::formatPrintLn(['red'], '❌  Certificate expired on: ' . $valid_date);
                        $return_value += 1;
                    }


                    if (($last_fingerprint == '') || ($fingerprint == $last_fingerprint)) {
                        self::formatPrintLn(['green'], '✅  Fingerprint: ' . $fingerprint);
                    }

                    $last_fingerprint = $fingerprint;
                    $last_valid_date = $valid_to_unix;

                    $sql = '
                    insert into tualocms_domain_ip_certs 
                    (domain, ip, fingerprint, certificate_valid_from,certificate_valid_to,certificate_checked_on) values 
                    ({domain}, {ip}, {fingerprint}, {valid_from}, {valid_to}, now()) 
                    on duplicate key update
                        fingerprint = values(fingerprint), 
                        certificate_valid_to = values(certificate_valid_to),
                        certificate_valid_from = values(certificate_valid_from),
                        certificate_checked_on = now()
                    ';
                    $clientdb->direct($sql, [
                        'domain' => $domain['domain'],
                        'ip' => $domain_ip['ip'],
                        'fingerprint' => $fingerprint,
                        'valid_to' => date("Y-m-d H:i:s", $valid_to_unix),
                        'valid_from' => date("Y-m-d H:i:s", $certinfo['validFrom_time_t'])
                    ]);

                    self::unintent();
                }
                self::unintent();
            }
        }
        return $return_value;
    }
}
