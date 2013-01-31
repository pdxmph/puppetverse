node default {
  notify { "Hello ${::hostname}!": }

  file { '/etc/motd':
    ensure  => file,
    content => "Welcome to ${::hostname}. This is a Puppet-managed node in a Vagrant cluster.\n",
  }
  include hiera_sample
}

