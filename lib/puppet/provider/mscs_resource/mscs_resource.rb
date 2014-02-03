require 'C:/gitrepos/ruby-mscs/lib/mscs.rb'

# fetch the mscs_type call the class provide passing it mscs_resource 

Puppet::Type.type(:mscs_resource).provide(:mscs_resource) do
  desc "Resource Provider for MSCS clusters." 
  
  def config_ip
      $resource_config={
        :enabledhcp    => 0,
        :address       => @resource[:ipaddress],
        :subnetmask    => @resource[:subnetmask],
        :network       => @resource[:network],
        :enablenetbios => 0
      }
  end
  
  def config_name
      $resource_config={
        :name          => @resource[:name],
      }
  end
  
  def create
 
    cluster_handle=Mscs::Cluster.open('Cluster',@resource[:clustername])
    Mscs::Resource.add(cluster_handle,@resource[:name],@resource[:resourcetype],@resource[:clustergroup])
    case @resource[:resourcetype]
    when "ipaddress"
          config_ip
    when "networkname"
          config_name
    end #case

    Mscs::Resource.set_priv(cluster_handle, @resource[:name], $resource_config)

  end

  def destroy
    cluster_handle=Mscs::Cluster.open('Cluster',@resource[:clustername])
    removal=Mscs::Resource.remove(cluster_handle,@resource[:name])
    
  end

  def exists?
    cluster_handle=Mscs::Cluster.open('Cluster',@resource[:clustername])
    resourcequery=Mscs::Cluster.enumerate('Cluster', cluster_handle, 4)
    resourcequery.include? @resource[:name]
  end

end
