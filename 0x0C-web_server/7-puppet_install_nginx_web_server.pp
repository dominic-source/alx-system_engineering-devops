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
$site = '/etc/nginx/sites-available/index2.com'

# duplicate configuration file
file { $site:
  ensure => present,
  source => '/etc/nginx/sites-available/default',
}

# Link index2.com file to sites-enabled folder
file { '/etc/nginx/sites-enabled/index2.com':
  ensure => link,
  target => $site,
}

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
