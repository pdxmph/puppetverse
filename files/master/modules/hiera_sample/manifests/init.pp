class hiera_sample (
  $message,
  $domain,
  $special_episode,
  $os_message,){

   $my_array = hiera_array($hiera_sample::os_message,undef)

#    notify { $hiera_sample::message:}
#    notify { $hiera_sample::domain: }
#    notify { $hiera_sample::special_episode:}
#    notify { $hiera_sample::hashval[val2]: }
#    notify { $my_array: }

}
