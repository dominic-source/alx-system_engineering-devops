# Install nginx and configure the server

# Ensures that nginx is installed
exec { '/usr/bin/env apt-get -y update':
}

package { 'nginx':
  ensure  => installed,
}
file { '/var/www/html/index.html':
  content => 'Holberton School!',
}

# Edit index.com site config
$line2 = "\tadd_header X-Served-By ${hostname};"
$match2 = 'server_name _;'
file_line { 'edit config file and add header':
  ensure  => present,
  path    => "/etc/nginx/sites-available/default",
  line    => ${line2},
  after   => ${match2},
}

service { 'nginx':
  ensure  => 'running',
}
