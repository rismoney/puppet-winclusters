  mscs_cluster {'cc-git01a.office.iseoptions.com':
    nodenames => 'cc-git01',
    ipaddresses => '30.3.4.43',
    subnetmasks => '255.255.255.0',
  }

  mscs_node {'cc-git01':
    clustername => 'cc-git01a',
    require  => Mscs_node['cc-git01a.office.iseoptions.com'],
  }

  mscs_group {['booya','kasha']:
    clustername => 'cc-git01a',
    ensure   => present,
    require  => Mscs_node['cc-git01']
  }

  mscs_resource {'myresourcex':
    clustername => 'cc-git01a',
    resourcetype => 'ipaddress',
    clustergroup => 'booya',
    ipaddress => '30.3.4.44',
    subnetmask => '255.255.255.0',
    network => 'C_MGMT-304',
    ensure   => present,
    require  => Mscs_group['booya'],
  }

# the logic for the following should perform the following
# When ensure = > present
# 1. validate the clustername.  if not valid cluster raise error (clusters should be created via mscs type)
# 2. validate the clustergroup. if not valid clusgrp raise error (clustgrp should be created via mscs_group type)
# 3a. if 1,2 true, and resource is absent, then resource will be created (raise error on creation failure)
#   - set attributes on newly created object
#   - raise errors if attributes can't be set
# 3b. if 1,2 true, and resource is present, then attribute hash table needs to be done on endpoint
#   - compare values in actual hash table vs puppet type 
#   - set any mismatches
#   - raise errors if attributes can't be set

# if ensure = > absent
# 4. if 1,2 true and resource is absent do nothing
# 5. if 1,2 true and resource is present 
#   - call cluster resource delete
#   - raise error if deletion fails

#mscs_resource will not create a cluster
#mscs_resource will not create a node
#mscs_resource will not create a group
#mscs_resource will only manage puppet supported priv properties (additional can only be added through code upgrades)
#valid values for resourcetype are checking at type level and will validate attribs accordingly