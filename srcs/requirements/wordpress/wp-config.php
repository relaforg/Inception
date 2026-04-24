<?php
define('DB_NAME',     'wordpress');
define('DB_USER',     'wpuser');
define('DB_PASSWORD', 'password');
define('DB_HOST',     'mariadb:3306');
define('DB_CHARSET',  'utf8');

define('WP_DEBUG', false);

$table_prefix = 'wp_';

if (!defined('ABSPATH')) {
    define('ABSPATH', __DIR__ . '/');
}

require_once ABSPATH . 'wp-settings.php';
