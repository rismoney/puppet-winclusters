puppet-winclusters
==================

puppet windows cluster module

Not an official release but:
Updated Status!  Resource and Group Creation work

```

  mscs_group {'mygroup':
    clustername => 'clustername',
    ensure   => present,
  }
  
  mscs_resource {'myip':
    clustername => 'clustername',
    resourcetype => 'ipaddress',
    clustergroup => 'mygroup',
    ipaddress => '30.3.4.42',
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
