# execute the pkill command to kill a process
exec { 'killmenow':
  command => '/bin/pkill killmenow',
  path    => '/bin/pkill',
}
