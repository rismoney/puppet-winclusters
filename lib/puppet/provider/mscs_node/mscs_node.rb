require 'mscs'

# fetch the mscs_type call the class provide passing it mscs_resource 

Puppet::Type.type(:mscs_node).provide(:mscs_node) do
  desc "Node Provider for MSCS clusters." 

  def init
    clustername = resource[:clustername]
    Mscs::Cluster.initialize clustername
  end
  
  def create
     Mscs::Node.add(@resource[:name])
  end

  def destroy
     Mscs::Node.remove(@resource[:name])
  end

  def exists?
    init
    nodelist=Mscs::Node.query
    nodelist.include?(@resource[:name])
  end
end


