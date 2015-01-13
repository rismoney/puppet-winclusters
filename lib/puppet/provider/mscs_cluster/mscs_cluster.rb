require 'D:\gitrepo\ruby-mscs\lib\mscs.rb'

# fetch the mscs_type call the class provide passing it mscs_resource 

Puppet::Type.type(:mscs_cluster).provide(:mscs_cluster) do
  desc "Cluster Provider for MSCS clusters." 

  @@nodename = ""
  
  def init
    @@nodename = resource[:nodenames].to_a.first
    Mscs::Cluster.initialize @@nodename
    Mscs::Cluster.wmiconnect
  end
  
  def create
    cluster_config={
      :ClusterName     => @resource[:name],
      :NodeNames       => @resource[:nodenames].to_a,
      :IPAddresses     => @resource[:ipaddresses].to_a,
      :SubnetMasks     => @resource[:subnetmasks].to_a,
      }
    Mscs::Cluster.create(cluster_config)
  end

  def destroy
    Mscs::Cluster.destroy
  end

  def exists?
    init
    cluster_state = Mscs::Cluster.state
    cluster_state == 'ClusterStateNotInstalled' or cluster_state == 'ClusterStateNotConfigured' ? (return false) : (return true)
  end

end