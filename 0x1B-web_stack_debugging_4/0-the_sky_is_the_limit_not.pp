# This will expand the number of worker processes we have
exec { 'increase worker process':
  command => 'sed -i "s|ULIMIT=\"-n 15\"|ULIMIT=\"-n 4096\"|g" /etc/default/nginx',
  path    => ['/bin', '/usr/sbin'],
}
