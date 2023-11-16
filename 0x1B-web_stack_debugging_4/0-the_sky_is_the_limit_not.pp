# This will expand the number of worker processes we have
exec { 'increase file open limit':
  command => 'sed -i "s|ULIMIT=\"-n 15\"|ULIMIT=\"-n 4096\"|g" /etc/default/nginx',
  path    => ['/bin', '/usr/sbin'],
}
exec { 'restart nginx configuration':
  command => 'sudo service nginx restart',
  path    => ['/bin', '/usr/sbin'],
}
