require File.join(File.dirname(__FILE__), 'mscs/mscs_file_system_path_property')

Puppet::Type.newtype(:mscs_resource) do
  @doc = "Microsoft Cluster Server resource configuration information"

  ensurable

  newparam(:name) do
    desc "The name of the cluster resource"
    isnamevar

    validate do |value|
      raise Puppet::Error, "Name must not be empty" if value.empty?
    end

  end

  newparam(:resourcetype, :parent => Puppet::MscsProperty) do
    desc "The resource type to be managed by the cluster"
    newvalues(:ipaddress, :networkname, :fileshare, :genericservice, :physicaldisk, :genericapplication)
    aliasvalue :ip, :ipaddress
    aliasvalue :nn, :networkname
    aliasvalue :fs, :fileshare
    aliasvalue :gensvc, :genericservice
    aliasvalue :pd, :physicaldisk
    aliasvalue :genapp, :genericapplication
  end

  newparam(:clustername, :parent => Puppet::MscsProperty) do
    desc "The name of the cluster"
  end

  newparam(:clustergroup, :parent => Puppet::MscsProperty) do
    desc "The group on the cluster"
  end
  
  # ip address params
  newparam(:ipaddress, :parent => Puppet::MscsProperty) do
    desc "The ip address to be be assigned to ip address resource"
  end
  
  newparam(:subnetmask, :parent => Puppet::MscsProperty) do
    desc "The subnetmask to be be assigned to ip address resource"
  end
  
  newparam(:network, :parent => Puppet::MscsProperty) do
    desc "The default gateway to be be assigned to ip address resource"
  end
  
  newparam(:enablenetbios, :parent => Puppet::MscsProperty) do
    "The default gateway to be be assigned to ip address resource"
    defaultto :true
  end
  
  
  # network name params
  
  newparam(:remappipenames, :parent => Puppet::MscsProperty) do
    desc "The network name to be be assigned to network name resource"
    newvalues(:true, :false)
    aliasvalue(:yes, :true)
    aliasvalue(:y, :true)
    aliasvalue(:n, :false)
    aliasvalue(:no, :false)
    defaultto :true
  end

  #file share params

  newparam(:path, :parent => Puppet::MscsProperty) do
    desc "The network name to be be assigned to file share resource"
     validate do |value|
      raise Puppet::Error.new('Must be specified using an absolute path.') unless absolute_path?(value)
      raise Puppet::Error, "Invalid value for attribute '#{name}', must use back slashes instead of forward slashes" if self.should_to_s(value).include?('/')
    end
  end


  newparam(:sharename, :parent => Puppet::MscsProperty) do
    desc "The sharename to be be assigned to file share or generic service resource"
  end


  newparam(:remark, :parent => Puppet::MscsProperty) do
    desc "The remark to be be assigned to file share resource"
  end

  newparam(:sharedubdirs, :parent => Puppet::MscsProperty) do
    desc "Share subdirectory for file share resource? [y/n]"
    newvalues(:true, :false)
    aliasvalue(:yes, :true)
    aliasvalue(:y, :true)
    aliasvalue(:n, :false)
    aliasvalue(:no, :false)
    defaultto :true
  end


  # generic service parameters

  newparam(:startupparameters, :parent => Puppet::MscsProperty) do
    desc "The startup parameters to be be assigned to generic service resource"
    validate do |value|
      raise Puppet::Error, "Invalid value for attribute '#{name}', must use back slashes instead of forward slashes" if self.should_to_s(value).include?('/')
    end
  end
  

  # physical disk parameters
  
  newparam(:signature, :parent => Puppet::MscsProperty) do
    desc "The disk signature to be be assigned to physical disk resource"
  end
  
  newparam(:skipchkdsk, :parent => Puppet::MscsProperty) do
    desc "Run skipchkdsk on physical disk resource"
    newvalues(:true, :false)
    aliasvalue(:yes, :true)
    aliasvalue(:y, :true)
    aliasvalue(:n, :false)
    aliasvalue(:no, :false)
    defaultto :true
  end
  
  newparam(:conditionalmount, :parent => Puppet::MscsProperty) do
    desc "The conditionalmount to be be assigned to physical disk resource"
  end

  # generic apps properties
  newparam(:commandline, :parent => Puppet::MscsProperty) do
    desc "The commandline to be be assigned to generic app resource"
  end

  newparam(:currentdirectory, :parent => Puppet::MscsProperty) do
    desc "The Currentdirectory to be be assigned to generic app resource"
    validate do |value|
      raise Puppet::Error.new('Must be specified using an absolute path.') unless absolute_path?(value)
      raise Puppet::Error, "Invalid value for attribute '#{name}', must use back slashes instead of forward slashes" if self.should_to_s(value).include?('/')
    end
  end

  newparam(:interactwithDesktop, :parent => Puppet::MscsProperty) do
    desc "The InteractWithDesktop to be be assigned to generic app resource"
    newvalues(:true, :false)
    aliasvalue(:yes, :true)
    aliasvalue(:y, :true)
    aliasvalue(:n, :false)
    aliasvalue(:no, :false)
    defaultto :true
  end

  newparam(:usenetworkname, :parent => Puppet::MscsProperty) do
    desc "The UseNetworkName generic app resource"
    newvalues(:true, :false)
    aliasvalue(:yes, :true)
    aliasvalue(:y, :true)
    aliasvalue(:n, :false)
    aliasvalue(:no, :false)
    defaultto :true
  end
  

  validate do

    is_type = self[:resourcetype]
    is_ip = (is_type == 'ipaddress') || (is_type == 'ip')
    is_nn = (is_type == 'networkname') || (is_type =='nn')
    is_fs = (is_type == 'fileshare')  || (is_type =='fs')
    is_gensvc = (is_type == 'genericservice') || (is_type == 'gensvc')
    is_pd = (is_type == 'physicaldisk') || (is_type =='pd')
    is_genapp = (is_type == 'genericapplication') || (is_type == 'genapp')
    
    has_address = !self[:ipaddress].nil?
    has_subnetmask = !self[:subnetmask].nil?
    has_path = !self[:path].nil?
    has_signature = !self[:signature].nil?

    has_currentdirectory = !self[:currentdirectory].nil?
    has_sharename = !self[:sharename].nil?
    has_commandline = !self[:commandline].nil?
    
    raise Puppet::Error, "You must specify IP address for an IP Address Resource"  if is_ip != has_address
    raise Puppet::Error, "You must specify Subnet Mask for an IP Address Resource"  if is_ip != has_subnetmask
    raise Puppet::Error, "You must specify Path for an File Share Resource"  if is_fs != has_path
    raise Puppet::Error, "You must specify Sharename for an File Share Resource"  if is_fs != has_sharename
    raise Puppet::Error, "You must specify command line for a Generic Application Resource"  if is_genapp != has_commandline
    raise Puppet::Error, "You must specify currentdir for a Generic Application Resource"  if is_genapp != has_currentdirectory
    raise Puppet::Error, "You must specify Signature for an Physical Disk Resource"  if is_pd != has_signature


  end
end
