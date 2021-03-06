puppet-winclusters
==================

** Member of the rismoney suite of Windows Puppet Providers **

puppet windows cluster module

Project Status:
This is currently being refactored.  All commits prior to this
point are based on a ruby gem I wrote to handle win32ole and wmi
calls.  This will be re-tooled to work on Win2008 and Win2012
with the cluster and powershell commands respectively.

This new work effort will occur in a branch called:
poshcli

Thank you and please stay tuned for future updates

```
  mscs_cluster {'cluster.my.domain.com':
    nodenames => 'server1',
    ipaddresses => '1.2.3.4',
    subnetmasks => '255.255.255.0',
  }

  mscs_node {'server1':
    clustername => 'cluster.my.domain.com',
    require  => Mscs_cluster['cluster.my.domain.com'],
  }

  mscs_group {'mygroup':
    clustername => 'clustername',
    ensure   => present,
    require  => Mscs_cluster['cluster.my.domain.com']
  }
  
  mscs_resource {'myip':
    clustername => 'clustername',
    resourcetype => 'ipaddress',
    clustergroup => 'mygroup',
    ipaddress => '1.2.3.5',
    subnetmask => '255.255.255.0',
    network => 'NICNAME',
    ensure   => present,
    require  => Mscs_group['mygroup'],
  }

```


Random thoughts:

* facter facts needed:
   (1) determine cluster service state 
   (2) determine if virtual cluster name exists

* idempotency approach
  
  * only deploy cluster module to intended hosts
  * if intended host has no cluster svc
       install dism features
  * if intended host has cluster cluster svc disabled
       run install cluster if no existing cluster exists
       run join existing cluster if existing cluster exists
  * if cluster all ready configured
       install cluster resources 

  developing [ruby-mscs gem] (https://github.com/rismoney/ruby-mscs) in tandem : 
  work in progress...
