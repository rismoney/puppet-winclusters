require 'C:/gitrepos/ruby-mscs/lib/mscs.rb'

# fetch the mscs_type call the class provide passing it mscs_resource 

Puppet::Type.type(:mscs_resource).provide(:mscs_resource) do
  desc "Resource Provider for MSCS clusters." 
  
  def create
    # puts "#{@resource[:name]}"
    # puts "#{@resource[:clustergroup]}"
    # puts "#{@resource[:ipaddress]}"
    # puts "#{@resource[:subnetmask]}"
    # puts "#{@resource[:network]}"
    
    cluster_group('add',@resource[:clustergroup])
    cluster_res('add',@resource[:name],@resource[:resourcetype],@resource[:clustergroup])
    #cluster_res_ip_props(@resource[:name],@resource[:clustergroup],@resource[:ipaddress],@resource[:subnetmask],@resource[:network])

    
  end

  def destroy
    # kill the mofo
  end

  def exists?
    File.exists?('C:/hello.txt')
  end

end


