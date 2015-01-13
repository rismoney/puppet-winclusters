require File.join(File.dirname(__FILE__), 'mscs/mscs_file_system_path_property')

Puppet::Type.newtype(:mscs_disk) do
  @doc = "Microsoft Cluster Server disk configuration information"

  ensurable

  newparam(:name) do
    desc "The name of the cluster disk"
    isnamevar

    validate do |value|
      raise Puppet::Error, "Name must not be empty" if value.empty?
    end

  end


  newparam(:clustergroup, :parent => Puppet::MscsProperty) do
    desc "The group name of the cluster"
  end
  
  newparam(:clustername, :parent => Puppet::MscsProperty) do
    desc "The name of the cluster"
  end
  
  newparam(:diskid, :parent => Puppet::MscsProperty) do
    desc "The disk id to be be assigned to physical disk resource"
  end
  
  

  validate do
  #  has_diskid = !self[:diskid].nil?
  #  raise Puppet::Error, "You must specify diskid for disk"  if has_diskid
  #
   end
end
