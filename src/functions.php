<?php

if (class_exists("Tualo\Office\CMS\Middlewares\Middleware")){ }
if (class_exists("Tualo\Office\CMS\Routes\Route")){ }
if (class_exists("Tualo\Office\CMS\Routes\Page")){ }
if (class_exists("Tualo\Office\CMS\Routes\Stylesheet")){ }
if (class_exists("Tualo\Office\CMS\Routes\Images")){ }

require_once "SetupApache.php";
// shorthand for old pug templates
class DataRenderer extends Tualo\Office\DS\DataRenderer {  }