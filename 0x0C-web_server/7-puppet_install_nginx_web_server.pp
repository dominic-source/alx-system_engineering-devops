# Install nginx and configure the server

# Ensures that nginx is installed
package { 'nginx':
  ensure  => installed,
}

# create html content file
file { '/var/www/html/index.html':
  content => 'Hello World!',
}

# declare site configuration path
$site = '/etc/nginx/sites-available/default'

file_line { 'edit site redirect configuration':
  ensure => present,
  path   => $site,
  line   => 'rewrite ^/redirect_me https://google.com permanent;',
  after  => 'listen 80 default_server;',
}

service { 'nginx':
  ensure  => 'running',
  require => Package['nginx'],
}
