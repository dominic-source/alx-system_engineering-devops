# debug the apache2 server
exec { 'modify wp-setting file':
  command => "sudo sed -i '137s|phpp|php|' '/var/www/html/wp-settings.php'",
  path    => ['/bin', '/usr/bin', '/usr/sbin'],
}
