# debug the apache2 server
exec { 'modify wp-setting file':
  command => "sed -i '138s|phpp|php|' '/var/www/html/wp-settings.php'",
  path    => ['/bin', '/usr/bin', '/usr/sbin'],
}
