class puppetmaster {
  $puppetmaster_ip = '192.168.33.10'
  $packages = ['puppet', 'puppet-common', 'facter']

  File {
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
  }

 apt::source { 'puppetlabs':
    location   => 'http://apt.puppetlabs.com',
    repos      =>  'devel',
    key        => '4BD6EC30',
    key_server => 'pgp.mit.edu',
  }

  exec { 'update':
    command => 'apt-get update',
    path => '/usr/bin',
    require => Apt::Source['puppetlabs'],
  }

  package { $packages:
    ensure => present,
    require => Exec['update'],
  }

  file { 'puppet.conf':
    ensure => file,
    path   => "$confdir/puppet.conf",
    source => '/tmp/vagrant-puppet/files/puppet.conf',
    require => Package[$packages],
  }

  host { 'master.vagrant.lan':
    ip => $puppetmaster_ip,
    host_aliases => ['puppet','master'],
  }
}

include puppetmaster

