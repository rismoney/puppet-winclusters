require 'C:/gitrepos/ruby-mscs/lib/mscs.rb'

# fetch the mscs_type call the class provide passing it mscs_resource 

Puppet::Type.type(:mscs_cluster).provide(:mscs_cluster) do
  desc "Cluster Provider for MSCS clusters." 

  def create
    cluster_config={
      :ClusterName     => @resource[:name],
      :NodeNames       => @resource[:nodenames],
      :IPAddresses     => @resource[:ipaddresses],
      :SubnetMasks     => @resource[:subnetmasks],
      }
    Mscs::Cluster.create(server, cluster_config)
  end

  def destroy
    cluster_handle=Mscs::Cluster.open('Cluster',@resource[:clustername])
    removal=Mscs::Cluster.destroy(cluster_handle,@resource[:name])
  end

  def exists?
    cluster_handle=Mscs::Cluster.open('Cluster',@resource[:clustername])
    clusterquery=Mscs::Cluster.enumerate('Cluster', cluster_handle, 1)
    clusterquery.include? @resource[:nodenames]
  end

end