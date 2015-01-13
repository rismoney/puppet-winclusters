require 'D:\gitrepo\ruby-mscs\lib\mscs.rb'

# fetch the mscs_type call the class provide passing it mscs_resource 

Puppet::Type.type(:mscs_group).provide(:mscs_group) do
  desc "Group Provider for MSCS clusters." 

  def init
    clustername = resource[:clustername]
    Mscs::Cluster.initialize clustername
  end
  
  def create
     Mscs::Group.create(@resource[:name])
  end

  def destroy
     Mscs::Group.delete(@resource[:name])
  end

  def exists?
    init
    grouplist=Mscs::Group.query
    grouplist.include?(@resource[:name])
  end
end