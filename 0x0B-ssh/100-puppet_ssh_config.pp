# Use puppet to manage ssh
file { '/root/.ssh/config':
     ensure  => file,
     mode    => '0644',
     content => "Host * \n\t PasswordAuthentication no \n\t IdentityFile ~/.ssh/school"
}
