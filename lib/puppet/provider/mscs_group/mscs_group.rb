require 'C:/gitrepos/ruby-mscs/lib/mscs.rb'

# fetch the mscs_type call the class provide passing it mscs_resource 

Puppet::Type.type(:mscs_group).provide(:mscs_group) do
  desc "Group Provider for MSCS clusters." 

  def create
     cluster_handle=Mscs::Cluster.open('Cluster',@resource[:clustername])
     Mscs::Group.add(cluster_handle,@resource[:name])
  end

  def destroy
    cluster_handle=Mscs::Cluster.open('Cluster',@resource[:clustername])
    removal=Mscs::Group.remove(cluster_handle,@resource[:name])
  end

  def exists?
    cluster_handle=Mscs::Cluster.open('Cluster',@resource[:clustername])
    if cluster_handle == 0
      raise Puppet::Error, "Cannot make connection to cluster" 
    else
      groupquery=Mscs::Cluster.enumerate('Cluster', cluster_handle, 8)
      groupquery.include? @resource[:name]
    end
  end
end  