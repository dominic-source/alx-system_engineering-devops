# Install nginx and configure the server

# Ensures that nginx is installed
-> package { 'nginx':
  ensure  => installed,
}

# create html content file
-> file { '/var/www/html/index.html':
  ensure  => file,
  mode    => '0755',
  content => 'Hello World!',
}

# declare site configuration path
$site = '/etc/nginx/sites-available/index2.com'

# duplicate configuration file
-> file { $site:
  ensure => present,
  source => '/etc/nginx/sites-available/default',
}

# Link index2.com file to sites-enabled folder
-> file { '/etc/nginx/sites-enabled/index2.com':
  ensure => link,
  target => $site,
}

-> file_line { 'edit site redirect configuration':
  ensure => present,
  line   => "\n\tlocation /redirect_me {\n\t\treturn 301 https://google.com;\n\t}\n\n\tlocation / {",
  match  => '^\s+location \/ {',
  path   => $site,
}

-> service { 'nginx':
  ensure  => 'running',
}
