# Install nginx and configure the server

# Ensures that nginx is installed
package { 'nginx':
  ensure  => installed,
}

# Ensures that augeas puppet module is install
package { 'augeas':
  ensure   => installed,
}

# create html content file
file { '/var/www/index.com/html/index.html':
  ensure  => file,
  mode    => '0755',
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

# deletes default file in sites-enabled
file { '/etc/nginx/sites-enabled/default':
  ensure  => absent,
}

# Edit configuration file
augeas { 'edit_conf_hash_buck':
  context => '/etc/nginx/nginx.conf',
  changes => [
    'set server_names_hash_bucket_size 64',
  ],
  require => Package['augeas'],
}

stdlib::file_line { 'edit site configuration file':
  ensure   => present,
  line     => 'server_name index2.com www.index2.com;',
  match    => 'server_name _;',
  path     => $site,
  multiple => false,
}

stdlib::file_line { 'edit site html configuration file':
  ensure   => present,
  line     => 'root /var/www/index.com/html;',
  match    => 'root /var/www/html;',
  path     => $site,
  multiple => false,
}

stdlib::file_line { 'edit site redirect configuration':
  ensure   => present,
  line     => '\n\tlocation /redirect_me {\n\t\treturn 301 https://google.com;\n\t}\n\n\tlocation / {',
  match    => 'location / {',
  path     => $site,
  multiple => false,
}

service { 'nginx':
  ensure   => running,
  provider => service,
}
