  mscs_cluster {'cc-git01x':
    nodenames   => ['cc-git01'],
    ipaddresses => ['30.3.4.42'],
    subnetmasks => ['255.255.255.0'],
    ensure      => present,
  }

  mscs_node {'cc-git01':
    clustername => 'cc-git01x',
    require  => Mscs_cluster['cc-git01x'],
  }

  mscs_group {['booya','kasha']:
     clustername => 'cc-git01x',
     ensure   => present,
     require  => Mscs_cluster['cc-git01x'],
  }

  mscs_resource {'myresourcey':
    clustername => 'cc-git01x',
    resourcetype => 'ipaddress',
    clustergroup => 'booya',
    ipaddress => '30.3.4.44',
    subnetmask => '255.255.255.0',
    network => 'Cluster Network 1',
    ensure   => present,
    require  => Mscs_group['booya'],
  }

  mscs_resource {'networkname':
    clustername => 'cc-git01x',
    resourcetype => 'networkname',
    clustergroup => 'booya',
    ensure   => present,
    require  => Mscs_resource['myresourcey'],
  }

  mscs_disk {'mydisk':
    clustername      => 'cc-git01x',
    diskid           => '3953857710',
    clustergroup     => 'booya',
    ensure           => present,
  }
  
