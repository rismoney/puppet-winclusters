require File.join(File.dirname(__FILE__), 'mscs/mscs_file_system_path_property')

Puppet::Type.newtype(:mscs_node) do
  @doc = "Microsoft Cluster Server node configuration information"

  ensurable

  newparam(:name) do
    desc "The name of the cluster node"
    isnamevar

    validate do |value|
      raise Puppet::Error, "Name must not be empty" if value.empty?
    end

  end

  
  newparam(:clustername, :parent => Puppet::MscsProperty) do
    desc "The name of the cluster"
  end

  validate do

    raise Puppet::Error, "You must specify clustername"  if self[:clustername].nil?

  end
end
