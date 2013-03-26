node default {
  #include hiera_sample
  #include ntp
}
hiera_include('classes')
