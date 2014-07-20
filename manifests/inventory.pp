define ansible_base::inventory (
  $fqdn,
  $ipaddress,
  $port = 22,
  $group = undef,
) {

  ini_setting { $fqdn:
    ensure  => present,
    path    => '/etc/ansible/hosts',
    section => $group,
    setting => "${fqdn} ansible_ssh_host",
    value   => "${ipaddress} ansible_ssh_port=${port}",
    key_val_separator => '='
  }

}
