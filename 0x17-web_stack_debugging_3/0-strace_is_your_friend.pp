# debug the apache2 server
exec { 'modify wp-setting file':
  command => "sed -i '137s|phpp|php|' '/var/www/html/wp-settings.php'",
  path    => ['/bin', '/usr/bin', '/usr/sbin'],
}
service { 'apache2':
  ensure  => 'running',
}
