  mscs_cluster {'cc-git01x':
    nodenames   => ['cc-git01'],
    ipaddresses => ['30.3.4.42'],
    subnetmasks => ['255.255.255.0'],
    ensure      => present,
  }

  #mscs_node {'cc-git01':
  #  clustername => 'cc-git01a',
  #  require  => Mscs_node['cc-git01a.office.iseoptions.com'],
  #}

  mscs_group {['booya','kasha']:
    clustername => 'cc-git01x',
    ensure   => present,
    require  => Mscs_cluster['cc-git01x']
  }

  mscs_resource {'myresourcex':
    clustername => 'cc-git01x',
    resourcetype => 'ipaddress',
    clustergroup => 'booya',
    ipaddress => '30.3.4.44',
    subnetmask => '255.255.255.0',
    network => 'Cluster Network 1',
    ensure   => present,
    require  => Mscs_group['booya'],
  }
