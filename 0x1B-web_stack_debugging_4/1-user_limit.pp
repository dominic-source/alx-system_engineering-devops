# This command helps to manage our holberton user
exec { 'increase user file open':
  command => 'sed -i "s|holberton hard nofile 5|holberton hard nofile 8192|g" /etc/security/limits.conf',
  path    => ['/bin', '/usr/sbin'],
}

exec { 'increase user no. of file open':
  command => 'sed -i "s|holberton soft nofile 4|holberton soft nofile 4096|g" /etc/security/limits.conf',
  path    => ['/bin', '/usr/sbin'],
}
