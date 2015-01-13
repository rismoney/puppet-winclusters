require 'D:\gitrepo\ruby-mscs\lib\mscs.rb'

Puppet::Type.type(:mscs_disk).provide(:mscs_disk) do
  desc "Disk Provider for MSCS clusters." 

  def init
    clustername = resource[:clustername]
    Mscs::Cluster.initialize clustername
  end
  
  def create
     Mscs::Disk.add(@resource[:diskid])
     Mscs::Disk.move@resource[:diskid],(@resource[:clustergroup])
     Mscs::Disk.rename@resource[:diskid],(@resource[:name])
  end

  def destroy
     Mscs::Disk.remove(@resource[:diskid])
  end

  def exists?
    init
    disklist=Mscs::Disk.query
    disklist.include?(@resource[:diskid])
  end
end