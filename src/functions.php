<?php

require_once "CMSMiddleware/Session.php";
require_once "CMSMiddleware/Markdown.php";
require_once "CMSMiddleware/Uuid.php";
require_once "Checks/Tables.php";
require_once "Routes/Page.php";
require_once "Routes/OldPage.php";
require_once "Routes/Images.php";
require_once "Routes/Image.php";
require_once "Routes/Asset.php";
require_once "Routes/Stylesheet.php";
require_once "Routes/Route.php";

require_once "Routes/Robots.php";
require_once "Routes/Sitemap.php";
require_once "Routes/Public.php";
require_once "Routes/ReverseProxy.php";

require_once "Middlewares/Middleware.php";
require_once "Commands/InstallMainSQLCommandline.php";
require_once "Commands/InstallMenuSQLCommandline.php";
require_once "Commands/InstallSession.php";
require_once "Commands/RegisterClient.php";
require_once "Commands/SetupCMSApache.php";
require_once "Commands/Import.php";
require_once "Commands/SampleSite.php";
require_once "Commands/SystemCheck.php";
require_once "Commands/SystemChecks/AuthTokens.php";
require_once "Commands/SystemChecks/CertCheck.php";

require_once "Commands/Setup.php";
