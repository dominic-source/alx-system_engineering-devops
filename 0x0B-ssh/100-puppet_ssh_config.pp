# Use puppet to manage ssh
# ensures that configuration file exist
file { '/etc/ssh/ssh_config':
     ensure  => file,
}

file_line { 'Turn of the password authentication':
    ensure => present,
    line   => 'PasswordAuthentication no',
    match  => '^#?PasswordAuthentication ',
    path   => '/etc/ssh/ssh_config',
}

file_line { 'Ensure ssh is configured using private key':
    ensure => present,
    line   => 'IdentityFile ~/.ssh/school',
    match  => '^#?IdentityFile ',
    path   => '/etc/ssh/ssh_config',
}
