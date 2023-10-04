# Install nginx and configure the server
# Ensures that nginx is installed

exec { '/usr/bin/env apt-get -y update':
}
-> package { 'nginx':
  ensure  => installed,
}

# Edit index.com site config
-> file_line { 'edit config file and add header':
  ensure => present,
  path   => '/etc/nginx/sites-available/default',
  line   => "\tadd_header X-Served-By ${hostname};",
  after  => 'server_name _;',
}

-> service { 'nginx':
  ensure  => 'running',
}
