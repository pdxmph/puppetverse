class hiera_sample (
  $message = hiera('hiera_sample::message'),
  $domain,
  $special_episode){
 notify { $hiera_sample::message:}
 notify { $hiera_sample::domain: }
 notify { $hiera_sample::special_episode:}
}
