class puppetmaster {
  File {
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
  }

  $confdir = '/etc/puppet'


apt::source { 'puppetlabs':
    location   => 'http://apt.puppetlabs.com',
    repos      =>  'main',
    key        => '4BD6EC30',
    key_server => 'pgp.mit.edu',
  }

  exec { "update":
    command => "apt-get update",
    path => "/usr/bin",
    require => Apt::Source['puppetlabs'],
    }

  package { ['puppet-common','puppet','puppetmaster','puppetmaster-common']:
    ensure => latest,
    require => Exec['update'],
    before => Service['puppetmaster'],
  }


  file { 'puppet.conf':
    ensure => file,
    path   => "$confdir/puppet.conf",
    source => '/tmp/vagrant-puppet/files/puppet_master.conf',
    notify => Service['puppetmaster'],
  }

  file { 'autosign.conf':
    ensure => file,
    path   => "$confdir/autosign.conf",
    source => '/tmp/vagrant-puppet/files/autosign.conf',
    before => Service['puppetmaster'],
  }


  service { 'puppetmaster':
    ensure  => running,
    enable  => true,
    require => File['puppet.conf'],
  }

  file { '/etc/hiera.yaml':
    ensure => link,
    target => "/etc/puppet/hieradata/hiera.yaml",
    before => Service['puppetmaster'],
    }
}

include puppetmaster

