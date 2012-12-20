  mscs_resource {'blah':
    resourcetype => ip,
    ipaddress => '1.2.3.4',
    subnetmask => '1.1.2.4',
    ensure   => present,
  }

