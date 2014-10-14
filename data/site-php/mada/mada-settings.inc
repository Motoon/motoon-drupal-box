<?php
require_once '/var/www/site-scripts/site-info.php';
list($ah_site_name, $ah_site_group, $ah_site_stage, $secret) = ah_site_info();

 $databases['default']['default'] = array(
   'driver' => 'mysql',
   'database' => $ah_site_name,
   'username' => 'root',
   'password' => 'root',
   'host' => 'localhost',
   'collation' => 'utf8_general_ci',
 );
