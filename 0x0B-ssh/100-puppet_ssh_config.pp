# Use puppet to manage ssh
file { '/root/.ssh/config':
     ensure  => file,
     mode    => '0644',
     content => "Host *\n     PasswordAuthentication no\n     IdentityFile /root/.ssh/school"
}
