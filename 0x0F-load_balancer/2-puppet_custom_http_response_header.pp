# Install nginx and configure the server

# Ensures that nginx is installed
exec { '/usr/bin/env apt-get -y update':
}

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


# Edit configuration file
$line1 = ' server_names_hash_bucket_size 64;'
$match1 = '# server_names_hash_bucket_size 64;'
$path1 = '/etc/nginx/nginx.conf'
file_line { 'edit configuration file':
  ensure  => present,
  path    => ${path},
  line    => ${line1},
  match   => ${match1},
}

# Edit index.com site config
$line2 = " server_name index2.com www.index2.com;\n\tadd_header X-Served-By ${facts['networking']['hostname']}"
$match2 = 'server_name _;'
file_line { 'edit site configuration file':
  ensure  => present,
  path    => ${site},
  line    => ${line2},
  match   => ${match2},
}

# Replace root
$line3 = ' root /var/www/index.com/html;'
$match3 = 'root /var/www/html;'
file_line { 'edit site html configuration file':
  ensure  => present,
  path    => ${site},
  line    => ${line3},
  match   => ${match3},
}

# Redirection
$line4 = "\n\tlocation /redirect_me {\n\t\treturn 301 https://google.com;\n\t}\n\n\tlocation / {"
$match4 = '^\s+location \/ {'
file_line { 'edit site redirect configuration':
  ensure  => present,
  path    => ${site},
  line    => ${line4},
  match   => ${match4},
}

service { 'nginx':
  ensure  => 'running',
}
