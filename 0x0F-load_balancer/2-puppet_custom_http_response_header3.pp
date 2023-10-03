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
$line1 = ' server_names_hash_bucket_size 64;'
$match1 = '# server_names_hash_bucket_size 64;'
$path1 = '/etc/nginx/nginx.conf'
exec { 'edit configuration file':
  command  => 'sed -i "s|$match1|$line1|" "$path1"',
}

# Edit index.com site config
$line2 = " server_name index2.com www.index2.com;\n\tadd_header X-Served-By ${facts['networking']['hostname']}"
$match2 = 'server_name _;'
exec { 'edit site configuration file':
  command => 'sed -i "s|$match2|$line2|" "$site"',
}

# Replace root
$line3 = ' root /var/www/index.com/html;'
$match3 = 'root /var/www/html;'
exec { 'edit site html configuration file':
  command => 'sed -i "s|$match3|$line3|" "$site"',
}

# Redirection
$line4 = "\n\tlocation /redirect_me {\n\t\treturn 301 https://google.com;\n\t}\n\n\tlocation / {"
$match4 = '^\s+location \/ {'
exec { 'edit site redirect configuration':
  command => 'sed -i "s|$match4|$line4|" "$site"',
}

service { 'nginx':
  ensure  => 'running',
}
