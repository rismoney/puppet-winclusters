require 'C:/gitrepos/ruby-mscs/lib/mscs.rb'

# fetch the mscs_type call the class provide passing it mscs_resource 

Puppet::Type.type(:mscs_resource).provide(:mscs_resource) do
  desc "Resource Provider for MSCS clusters." 
  
  
  def create
 
     cluster_handle=Mscs::Cluster.open('Cluster',@resource[:clustername])
     #Mscs::Group.add(cluster_handle,@resource[:clustergroup])
     Mscs::Resource.add(cluster_handle,@resource[:name],@resource[:resourcetype],@resource[:clustergroup])
ipres={
        :enabledhcp    => 0,
        :address       => @resource[:ipaddress],
        :subnetmask    => @resource[:subnetmask],
        :network       => @resource[:network],
        :enablenetbios => 0
        }

    
    Mscs::Resource.set_priv(cluster_handle, @resource[:name], ipres)
    
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


