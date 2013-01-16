require 'C:/gitrepos/ruby-mscs/lib/mscs.rb'

# fetch the mscs_type call the class provide passing it mscs_resource 

Puppet::Type.type(:mscs_cluster).provide(:mscs_cluster) do
  desc "Cluster Provider for MSCS clusters." 

  def create
    cluster_config={
      :ClusterName     => @resource[:name],
      :NodeNames       => @resource[:nodenames].to_a,
      :IPAddresses     => @resource[:ipaddresses].to_a,
      :SubnetMasks     => @resource[:subnetmasks].to_a,
      }
      
    kerb_name="nyise\\#{@resource[:nodenames].to_a.first}"
    Mscs::Cluster.create(@resource[:nodenames].first, cluster_config,kerb_name)
  end

  def destroy
    cluster_handle=Mscs::Cluster.open('Cluster',@resource[:name])
    removal=Mscs::Cluster.destroy(cluster_handle,@resource[:name])
  end

  def exists?
    #we use the server name here, and not the virtual name,
    #because it may not be available yet...
    cluster_handle=Mscs::Cluster.open('Cluster',@resource[:nodenames].first)
    cluster_handle == 0 ? (return false) : (return true)
    #clusterquery=Mscs::Cluster.enumerate('Cluster', cluster_handle, 1)
    #clusterquery.include? @resource[:nodenames]
  end

end