class hiera_sample($special_episode,$message){
    # notify { $hiera_sample::message:}
    # notify { $hiera_sample::domain: }

    $values = hiera_hash(hiera_sample::hashvalues, {"val1" => "somevalue1","val2" => "somevalue2","val3" => "somevalue3"}, "dceast.acme.com")
    $ntp_servers = hiera_array(hiera_sample::servers, ["default1", "default2", "default3"], "dceast.acme.com")
#    $values =
#    $hash_vals = hiera_hash(hiera_sample::hashvalues)
#     notify { $::hiera_sample::special_episode: }
    notify { $ntp_servers: }
#    notify { $::hiera_sample::hashvalues['val1']: }
    # notify { a: message => $values['val1'] }
    # notify { b: message => $values['val2'] }
    # notify { c: message => $values['val3'] }
    # notify { a: message => $::hiera_sample::hashvalues['val1'] }
 #    notify { b: message => $::hiera_sample::hashvalues['val2'] }
 #    notify { c: message => $::hiera_sample::hashvalues['val3'] }
  }
