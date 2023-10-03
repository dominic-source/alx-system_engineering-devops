# Ensures that nginx is installed
package { 'nginx':
  ensure  => installed,
}

# Ensure directories exist
file { '/var/www/index.com':
  ensure  => directory,
}

file { '/var/www/index.com/html':
  ensure  => directory,
}

# Create html content file
file { '/var/www/index.com/html/index.html':
  ensure  => file,
  mode    => '0755',
  content => 'Hello World!',
}

# Declare site configuration path
$site = '/etc/nginx/sites-available/index2.com'

# Duplicate configuration file
file { $site:
  ensure => present,
  source => '/etc/nginx/sites-available/default',
}

# Create a symlink to site enabled
file { '/etc/nginx/sites-enabled/index2.com':
  ensure  => link,
  target  => $site,
}

# Edit configuration file
$line1 = ' server_names_hash_bucket_size 64;'
$match1 = '# server_names_hash_bucket_size 64;'
$path1 = '/etc/nginx/nginx.conf'

# Edit site configuration
$line2 = " server_name index2.com www.index2.com;\n\tadd_header X-Served-By ${facts['networking']['hostname']};"
$match2 = 'server_name _;'

# Replace root
$line3 = ' root /var/www/index.com/html;'
$match3 = 'root /var/www/html;'

# Redirection
$line4 = "\n\tlocation /redirect_me {\n\t\treturn 301 https://google.com;\n\t}\n\n\tlocation / {"
$match4 = '^\s+location \/ {'

# Define a single exec resource to make all the edits
exec { 'edit nginx configuration4':
  command  => 'sudo sed -i "s|${match44}|${line4}|" "/etc/nginx/sites-available/index2.com"',
  path     => ['/bin', '/usr/bin'],
  notify => Service['nginx'],  # Restart Nginx when the configuration changes
}

exec { 'edit nginx config1':
  command  => 'sudo sed -i "s|${match1}|${line1}|" "/etc/nginx/nginx.conf"',
  path     => ['/bin', '/usr/bin'],
  notify   => Service['nginx'],
}

exec { 'edit nginx config2':
  command  => 'sudo sed -i "s|${match2}|${line2}|" "/etc/nginx/sites-available/index2.com"',
  path     => ['/bin', '/usr/bin'],
  notify   => Service['nginx'],
}
exec { 'edit nginx config3':
  command  => 'sudo sed -i "s|${match3}|${line3}|" "/etc/nginx/sites-available/index2.com"',
  path     => ['/bin', '/usr/bin'],
  notify   => Service['nginx'],
}

# Ensure nginx service is running and validate configuration
service { 'nginx':
  ensure  => 'running',
  require => Exec['edit nginx configuration4'],  # Wait for configuration edit before starting the service
}
