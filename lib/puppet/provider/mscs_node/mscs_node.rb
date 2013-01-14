require 'C:/gitrepos/ruby-mscs/lib/mscs.rb'

# fetch the mscs_type call the class provide passing it mscs_resource 

Puppet::Type.type(:mscs_node).provide(:mscs_node) do
  desc "Group Provider for MSCS clusters." 

  def create
     cluster_handle=Mscs::Cluster.open('Cluster',@resource[:clustername])
     Mscs::Node.add(cluster_handle,@resource[:name])
  end

  def destroy
    cluster_handle=Mscs::Cluster.open('Cluster',@resource[:clustername])
    removal=Mscs::Node.remove(cluster_handle,@resource[:name])
  end

  def exists?
    cluster_handle=Mscs::Cluster.open('Cluster',@resource[:clustername]) 
    nodequery=Mscs::Cluster.enumerate('Cluster', cluster_handle, 1)
    nodequery.include? @resource[:name]
  end

end


