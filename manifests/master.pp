class puppetmaster {
  File {
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
  }

  $confdir = '/etc/puppet'

  exec { "update":
    command => "apt-get update",
    path => "/usr/bin",
    require => Apt::Source['puppetlabs'],
  }

  package { 'puppet-common':
    ensure => present,
    require => Exec["update"],
  }

  package { 'puppet':
    ensure => present,
    require => Exec["update"],
  }


  package { 'puppetmaster':
    ensure => present,
    require => Exec["update"],
  }


  file { 'puppet.conf':
    ensure => file,
    path   => "$confdir/puppet.conf",
    source => '/tmp/vagrant-puppet/files/puppet_master.conf',
  }

  file { 'autosign.conf':
    ensure => file,
    path   => "$confdir/autosign.conf",
    source => '/tmp/vagrant-puppet/files/autosign.conf',
  }

  file { 'site.pp':
    ensure => file,
    path   => "$confdir/manifests/site.pp",
    source => '/tmp/vagrant-puppet/files/site.pp',
    require => Package['puppetmaster'],
  }


  service { 'puppetmaster':
    ensure  => running,
    enable  => true,
    require => [Package['puppetmaster'], File['puppet.conf', 'site.pp', 'autosign.conf' ]],
  }

  apt::source { 'puppetlabs':
    location   => 'http://apt.puppetlabs.com',
    repos      =>  'main',
    key        => '4BD6EC30',
    key_server => 'pgp.mit.edu',
  }

}

include puppetmaster

