<?php

namespace Tualo\Office\CMS\Routes;

use Tualo\Office\Basic\TualoApplication;
use Tualo\Office\Basic\Route;
use Tualo\Office\Basic\IRoute;
use Tualo\Office\DS\DSTable;

use Tualo\Office\PUG\PUG2;
use Tualo\Office\PUG\PUGRenderingHelper;

use Tualo\Office\CMS\CMSMiddlewareHelper;

class ReverseProxy extends \Tualo\Office\Basic\RouteWrapper
{

    public static function register()
    {
        Route::add('/tualocms/page/reverseproxy/(?P<path>.*)', function ($matches) {
            if (TualoApplication::configuration('reverseproxy', 'enabled', false) != '1') {
                TualoApplication::contenttype('application/json');
                TualoApplication::result('success', false);
                TualoApplication::result('msg', 'access denied');
                return;
            }

            $path = $matches['path'];

            // Target URL aus Konfiguration holen
            $targetBaseUrl = TualoApplication::configuration('reverseproxy', 'target_url', '');

            if (empty($targetBaseUrl)) {
                TualoApplication::contenttype('application/json');
                TualoApplication::result('success', false);
                TualoApplication::result('msg', 'target_url not configured');
                return;
            }

            // Vollständige Target URL zusammenbauen
            $targetUrl = rtrim($targetBaseUrl, '/') . '/' . ltrim($path, '/');

            // Query String hinzufügen wenn vorhanden
            if (!empty($_SERVER['QUERY_STRING'])) {
                $targetUrl .= '?' . $_SERVER['QUERY_STRING'];
            }

            // cURL initialisieren
            $ch = curl_init();

            // Request Method ermitteln
            $method = $_SERVER['REQUEST_METHOD'];

            // cURL Optionen setzen
            curl_setopt($ch, CURLOPT_URL, $targetUrl);
            curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
            curl_setopt($ch, CURLOPT_FOLLOWLOCATION, false); // Nicht automatisch folgen, wir behandeln Redirects manuell
            curl_setopt($ch, CURLOPT_MAXREDIRS, 10);
            curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, true);
            curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, 2);
            curl_setopt($ch, CURLOPT_TIMEOUT, 30);
            curl_setopt($ch, CURLOPT_CONNECTTIMEOUT, 10);
            curl_setopt($ch, CURLOPT_HEADER, true);
            curl_setopt($ch, CURLOPT_ENCODING, ''); // Akzeptiert alle Encodings

            // Request Headers sammeln und weiterleiten
            $requestHeaders = [];
            foreach ($_SERVER as $key => $value) {
                if (strpos($key, 'HTTP_') === 0) {
                    $headerName = str_replace(' ', '-', ucwords(strtolower(str_replace('_', ' ', substr($key, 5)))));

                    // Bestimmte Headers nicht weiterleiten
                    if (!in_array(strtolower($headerName), ['host', 'connection', 'accept-encoding'])) {
                        $requestHeaders[] = "$headerName: $value";
                    }
                }
            }

            // Content-Type explizit hinzufügen wenn vorhanden
            if (isset($_SERVER['CONTENT_TYPE'])) {
                $requestHeaders[] = 'Content-Type: ' . $_SERVER['CONTENT_TYPE'];
            }

            curl_setopt($ch, CURLOPT_HTTPHEADER, $requestHeaders);

            // Cookies sammeln und weiterleiten
            $cookies = [];
            foreach ($_COOKIE as $name => $value) {
                $cookies[] = "$name=" . urlencode($value);
            }
            if (!empty($cookies)) {
                curl_setopt($ch, CURLOPT_COOKIE, implode('; ', $cookies));
            }

            // POST/PUT/PATCH/DELETE Daten verarbeiten
            if (in_array($method, ['POST', 'PUT', 'PATCH', 'DELETE'])) {
                curl_setopt($ch, CURLOPT_CUSTOMREQUEST, $method);

                // POST Daten lesen
                $postData = file_get_contents('php://input');

                // Falls keine rohen Daten, normale POST-Daten verwenden
                if (empty($postData) && !empty($_POST)) {
                    $postData = http_build_query($_POST);
                }

                if (!empty($postData)) {
                    curl_setopt($ch, CURLOPT_POSTFIELDS, $postData);
                }
            } elseif ($method === 'GET') {
                curl_setopt($ch, CURLOPT_HTTPGET, true);
            }

            // Request ausführen
            $response = curl_exec($ch);

            // Fehlerbehandlung
            if (curl_errno($ch)) {
                $error = curl_error($ch);
                curl_close($ch);

                http_response_code(502); // Bad Gateway
                TualoApplication::contenttype('application/json');
                TualoApplication::result('success', false);
                TualoApplication::result('msg', 'Proxy error: ' . $error);
                return;
            }

            // Response Info
            $httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
            $headerSize = curl_getinfo($ch, CURLINFO_HEADER_SIZE);

            curl_close($ch);

            // Headers und Body trennen
            $responseHeaders = substr($response, 0, $headerSize);
            $responseBody = substr($response, $headerSize);

            // 301/302/303/307/308 Redirects behandeln - Location Header umschreiben
            if (in_array($httpCode, [301, 302, 303, 307, 308])) {
                $headerLines = explode("\r\n", $responseHeaders);

                foreach ($headerLines as &$line) {
                    if (empty($line) || strpos($line, 'HTTP/') === 0) {
                        continue;
                    }

                    $parts = explode(':', $line, 2);
                    if (count($parts) === 2) {
                        $headerName = trim($parts[0]);
                        $headerValue = trim($parts[1]);

                        if (strtolower($headerName) === 'location') {
                            // Location Header umschreiben
                            $newLocation = self::rewriteRedirectLocation($headerValue, $targetBaseUrl);
                            $line = "Location: " . $newLocation;
                        }
                    }
                }

                $responseHeaders = implode("\r\n", $headerLines);
            }

            // Response Headers verarbeiten
            $headerLines = explode("\r\n", $responseHeaders);
            $processedHeaders = [];

            foreach ($headerLines as $line) {
                if (empty($line) || strpos($line, 'HTTP/') === 0) {
                    continue;
                }

                $parts = explode(':', $line, 2);
                if (count($parts) === 2) {
                    $headerName = trim($parts[0]);
                    $headerValue = trim($parts[1]);

                    $lowerHeaderName = strtolower($headerName);

                    // Set-Cookie Headers sammeln
                    if ($lowerHeaderName === 'set-cookie') {
                        // Cookie parsen und setzen
                        self::parseAndSetCookie($headerValue);
                        continue;
                    }

                    // Bestimmte Headers nicht weiterleiten
                    if (in_array($lowerHeaderName, [
                        'transfer-encoding',
                        'connection',
                        'keep-alive',
                        'upgrade',
                        'content-encoding'
                    ])) {
                        continue;
                    }

                    $processedHeaders[$headerName] = $headerValue;
                }
            }

            // HTTP Status Code setzen
            http_response_code($httpCode);

            // Response Headers setzen
            foreach ($processedHeaders as $name => $value) {
                header("$name: $value", false);
            }

            // Content-Type URLs und Links im Response Body anpassen
            $contentType = isset($processedHeaders['Content-Type']) ? strtolower($processedHeaders['Content-Type']) : '';

            // Nur bei HTML/CSS/JavaScript URLs umschreiben
            if (
                strpos($contentType, 'text/html') !== false ||
                strpos($contentType, 'text/css') !== false ||
                strpos($contentType, 'application/javascript') !== false ||
                strpos($contentType, 'text/javascript') !== false
            ) {

                $responseBody = self::rewriteUrls($responseBody, $targetBaseUrl);
            }

            // Response Body ausgeben
            echo $responseBody;
        }, array('get', 'post', 'put', 'patch', 'delete'), false);
    }

    /**
     * Parse und setze Cookie aus Set-Cookie Header
     */
    private static function parseAndSetCookie($cookieString)
    {
        $parts = explode(';', $cookieString);
        $nameValue = explode('=', trim($parts[0]), 2);

        if (count($nameValue) !== 2) {
            return;
        }

        $name = trim($nameValue[0]);
        $value = trim($nameValue[1]);

        $expires = 0;
        $path = '/';
        $domain = '';
        $secure = false;
        $httponly = false;
        $samesite = '';

        for ($i = 1; $i < count($parts); $i++) {
            $part = trim($parts[$i]);
            $attr = explode('=', $part, 2);
            $attrName = strtolower(trim($attr[0]));
            $attrValue = isset($attr[1]) ? trim($attr[1]) : '';

            switch ($attrName) {
                case 'expires':
                    $expires = strtotime($attrValue);
                    break;
                case 'max-age':
                    $expires = time() + intval($attrValue);
                    break;
                case 'path':
                    $path = $attrValue;
                    break;
                case 'domain':
                    // Domain nicht übernehmen, nutze eigene Domain
                    break;
                case 'secure':
                    $secure = true;
                    break;
                case 'httponly':
                    $httponly = true;
                    break;
                case 'samesite':
                    $samesite = $attrValue;
                    break;
            }
        }

        // Cookie setzen
        if (PHP_VERSION_ID >= 70300) {
            $options = [
                'expires' => $expires,
                'path' => $path,
                'secure' => $secure,
                'httponly' => $httponly,
            ];
            if (!empty($samesite)) {
                $options['samesite'] = $samesite;
            }
            setcookie($name, $value, $options);
        } else {
            setcookie($name, $value, $expires, $path, $domain, $secure, $httponly);
        }
    }

    /**
     * Schreibe Location Header für Redirects um
     */
    private static function rewriteRedirectLocation($location, $targetBaseUrl)
    {
        // Basis-URL für Reverse Proxy
        $proxyBaseUrl = '/tualocms/page/reverseproxy';

        // Parse URLs
        $targetParsed = parse_url($targetBaseUrl);
        $targetScheme = $targetParsed['scheme'] ?? 'https';
        $targetHost = $targetParsed['host'] ?? '';
        $targetPort = isset($targetParsed['port']) ? ':' . $targetParsed['port'] : '';
        $targetPath = rtrim($targetParsed['path'] ?? '', '/');

        $locationParsed = parse_url($location);

        // Fall 1: Absolute URL mit gleichem Host wie Target
        if (isset($locationParsed['host'])) {
            $locationHost = $locationParsed['host'];
            $locationPort = isset($locationParsed['port']) ? ':' . $locationParsed['port'] : '';

            // Prüfen ob es der Target-Host ist
            if ($locationHost === $targetHost && $locationPort === $targetPort) {
                $newPath = $locationParsed['path'] ?? '/';
                $query = isset($locationParsed['query']) ? '?' . $locationParsed['query'] : '';
                $fragment = isset($locationParsed['fragment']) ? '#' . $locationParsed['fragment'] : '';

                // Entferne Target-Base-Path falls vorhanden
                if (!empty($targetPath) && strpos($newPath, $targetPath) === 0) {
                    $newPath = substr($newPath, strlen($targetPath));
                }

                return $proxyBaseUrl . $newPath . $query . $fragment;
            }

            // Anderer Host - absolute URL beibehalten
            return $location;
        }

        // Fall 2: Absolute Pfad (beginnt mit /)
        if (isset($locationParsed['path']) && strpos($locationParsed['path'], '/') === 0) {
            $newPath = $locationParsed['path'];
            $query = isset($locationParsed['query']) ? '?' . $locationParsed['query'] : '';
            $fragment = isset($locationParsed['fragment']) ? '#' . $locationParsed['fragment'] : '';

            // Entferne Target-Base-Path falls vorhanden
            if (!empty($targetPath) && strpos($newPath, $targetPath) === 0) {
                $newPath = substr($newPath, strlen($targetPath));
            }

            return $proxyBaseUrl . $newPath . $query . $fragment;
        }

        // Fall 3: Relative URL - unverändert lassen
        return $location;
    }

    /**
     * Schreibe URLs im Response Body um
     */
    private static function rewriteUrls($content, $targetBaseUrl)
    {
        // Basis-URL für Reverse Proxy
        $proxyBaseUrl = '/tualocms/page/reverseproxy';

        // Parse target URL
        $targetParsed = parse_url($targetBaseUrl);
        $targetScheme = $targetParsed['scheme'] ?? 'https';
        $targetHost = $targetParsed['host'] ?? '';
        $targetPort = isset($targetParsed['port']) ? ':' . $targetParsed['port'] : '';
        $targetPath = $targetParsed['path'] ?? '';

        // Absolute URLs mit vollem Schema umschreiben
        $content = preg_replace(
            '#(["\'])(https?://?' . preg_quote($targetHost, '#') . preg_quote($targetPort, '#') . ')([^"\']*?)(["\'])#i',
            '$1' . $proxyBaseUrl . '$3$4',
            $content
        );

        // Protokoll-relative URLs (//example.com/path)
        $content = preg_replace(
            '#(["\'])//' . preg_quote($targetHost, '#') . preg_quote($targetPort, '#') . '([^"\']*?)(["\'])#i',
            '$1' . $proxyBaseUrl . '$2$3',
            $content
        );

        // Absolute Pfade (/path/to/resource)
        if (!empty($targetPath)) {
            $content = preg_replace(
                '#(["\'])(' . preg_quote($targetPath, '#') . '[^"\']*?)(["\'])#i',
                '$1' . $proxyBaseUrl . '$2$3',
                $content
            );
        }

        // Base-Tag anpassen wenn vorhanden
        $content = preg_replace(
            '#<base\s+href=["\']https?://[^"\']+["\']#i',
            '<base href="' . $proxyBaseUrl . '/"',
            $content
        );

        return $content;
    }
}
