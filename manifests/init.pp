# == Class: ansible_base
#
# Full description of class ansible_base here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if it
#   has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should not be used in preference to class parameters  as of
#   Puppet 2.6.)
#
# === Examples
#
#  class { ansible_base:
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ]
#  }
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2014 Your name here, unless otherwise noted.
#
class ansible_base (
  $base_enabled = $ansible_base::params::base_enabled,
  $master = $ansible_base::params::master,
  $master_enabled = $ansible_base::params::master_enabled,
  $group = $ansible_base::params::group,
  $port = $ansible_base::params::port,
) inherits ansible_base::params {

  if $base_enabled {

    class { 'ansible::node' :
      master  => $master
    }

    # Export inventory
    @@ansible_base::inventory { "ansible_${::fqdn}_inventory":
      fqdn         => $::fqdn,
      ipaddress    => $::ipaddress,
      port         => $port,
      group        => $group,
      tag          => "ansible_node_${ansible::node::master}_inventory"
    }

    if $master_enabled {
      include ansible::master

      file {'/etc/ansible':
        ensure => directory
      }

      # Collect inventory from nodes
      Ansible_base::Inventory <<| tag == "ansible_node_${::fqdn}_inventory" |>>

    }

  }

}
