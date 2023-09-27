# Install nginx and configure the server

# Ensures that nginx is installed
package { 'nginx':
  ensure  => installed,
}
file { '/var/www/index.com':
  ensure  => directory,
}

file { '/var/www/index.com/html':
  ensure  => directory,
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
#file { '/etc/nginx/sites-enabled/default':
#  ensure  => absent,
#}

# Edit configuration file
file_line { 'edit_conf_hash_buck':
  ensure => present,
  line   => '	server_names_hash_bucket_size 64;',
  match  => '# server_names_hash_bucket_size 64;',
  path   => '/etc/nginx/nginx.conf',
}

file_line { 'edit site configuration file':
  ensure   => present,
  line     => '	server_name index2.com www.index2.com;',
  match    => 'server_name _;',
  path     => $site,
  multiple => false,
}

file_line { 'edit site html configuration file':
  ensure   => present,
  line     => '	root /var/www/index.com/html;',
  match    => 'root /var/www/html;',
  path     => $site,
  multiple => false,
}

file_line { 'edit site redirect configuration':
  ensure   => present,
  line     => "\n\tlocation /redirect_me {\n\t\treturn 301 https://google.com;\n\t}\n\n\tlocation / {",
  match    => '^\s+location \/ {',
  path     => $site,
  multiple => false,
}

service { 'nginx':
  provider => 'service',
  restart  => true,
}
