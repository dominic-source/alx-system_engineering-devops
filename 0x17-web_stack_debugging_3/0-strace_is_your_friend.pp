# debug the apache2 server
exec { 'modify wp-setting file':
  command => "sudo sed -i 's|phpp|php|g' '/var/www/html/wp-settings.php'",
  path    => ['/bin', '/usr/bin', '/usr/sbin'],
}
