# debug the apache2 server
exec { 'modify wp-setting file':
  command => "sed -i '137s|.*|require_once( ABSPATH . WPINC . \"/class-wp-locale.php\" );|' '/var/www/html/wp-settings.php'",
  path    => ['/bin'],
}
