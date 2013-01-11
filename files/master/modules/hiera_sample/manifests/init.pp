class hiera_sample ($message,$domain,$special_episode){
 notify { $message :}
 notify { $domain : }
 notify { $special_episode :}

package { "dselect":
  ensure => present,
  }
}

