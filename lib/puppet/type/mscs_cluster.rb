require File.join(File.dirname(__FILE__), 'mscs/mscs_file_system_path_property')

Puppet::Type.newtype(:mscs_cluster) do
  @doc = "Microsoft Cluster Server cluster configuration information"

  ensurable

  newparam(:name) do
    desc "The name of the cluster"
    isnamevar

    validate do |value|
      raise Puppet::Error, "Name must not be empty" if value.empty?
    end

  end
  
  newparam(:nodenames, :array_matching => :all) do
    desc "The name of the cluster"
    validate do |value|
      raise Puppet::Error, "Name must not be empty" if value.empty?
    end
  end

  newparam(:ipaddresses, :array_matching => :all) do
    desc "The group on the cluster"
    validate do |value|
      raise Puppet::Error, "Name must not be empty" if value.empty?
    end
  end

  newparam(:subnetmasks, :array_matching => :all) do
    desc "The subnetmasks to be be assigned to the cluster ips"
    validate do |value|
      raise Puppet::Error, "Name must not be empty" if value.empty?
    end
  end


end

