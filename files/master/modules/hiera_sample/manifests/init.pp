class hiera_sample($special_episode,$message, $domain, $servers){
     notify { $hiera_sample::message:}
     notify { $hiera_sample::domain: }
     notify { $hiera_sample::special_episode: }
     notify { $servers: }
}

