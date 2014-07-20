class ansible_base::params {

  $base_enabled = false
  $master = $fqdn
  $master_enabled = false
  $group = $::hostgroup
  $port = 22

}