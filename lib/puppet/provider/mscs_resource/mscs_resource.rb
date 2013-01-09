require 'C:/gitrepos/ruby-mscs/lib/mscs.rb'
require 'win32ole'

# fetch the mscs_type call the class provide passing it mscs_resource 

Puppet::Type.type(:mscs_resource).provide(:mscs_resource) do
  desc "Resource Provider for MSCS clusters." 
  
  def create
 
     cluster_handle=Mscs::Cluster.open('Cluster',@resource[:clustername])
     Mscs::Group.add(cluster_handle,@resource[:clustergroup])
     Mscs::Resource.add(cluster_handle,@resource[:name],@resource[:resourcetype],@resource[:clustergroup])
ipres={
        :enabledhcp    => 0,
        :address       => @resource[:ipaddress],
        :subnetmask    => @resource[:subnetmask],
        :network       => @resource[:network],
        :enablenetbios => 0
        }

    
    Mscs::Resource.set_priv(cluster_handle, 'myresourcex', ipres)
    
  end

  def destroy
    # kill the mofo
  end

  def exists?
    File.exists?('C:/hello.txt')
  end

end


