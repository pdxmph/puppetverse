node default {
  notify { "Hello ${::hostname}!": }

  file { '/etc/motd':
    ensure  => file,
    content => "Welcome to ${::hostname}. This is a Puppet managed node in a Vagrant cluster.\n",
  }

  #######################################################
  # Any packages that should be applied to all nodes
  # should be added to this array. If you want them
  # to track the latest version, change the resource
  # attribute to ensure => latest.
  #######################################################
  $pkgs = ["emacs23-nox"]

  package { $pkgs:
    ensure => present,
  }

}

