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

  newparam(:restype, :parent => Puppet::MscsProperty) do
    desc "The resource type to be managed by the cluster"
    #newvalues(:ipaddress, :networkname, :fileshare, :genericservice, :physicaldisk, :genericapplication)
    #aliasvalue :ip, :ipaddress
    #aliasvalue :nn, :networkname
    #aliasvalue :fs, :fileshare
    #aliasvalue :gensvc, :genericservice
    #aliasvalue :pd, :physicaldisk
    #aliasvalue :genapp, :genericapplication
  end

  # ip address params
  newparam(:address, :parent => Puppet::MscsProperty) do
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
  # raise Puppet::Error, "Invalid value for attribute '#{name}', must use back slashes instead of forward slashes" if self.should_to_s(value).include?('/')
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
    #raise Puppet::Error.new('Must be specified using an absolute path.') unless absolute_path?(value)
    #raise Puppet::Error, "Invalid value for attribute '#{name}', must use back slashes instead of forward slashes" if self.should_to_s(value).include?('/')
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

    is_type = !self[:restype]

    case is_type
      when :ipaddress
        has_address = !self[:address].nil?
        has_subnetmask = !self[:subnetmask].nil?
        self.fail "You must specify address, and subnetmask" if has_address != has_subnetmask
      when :networkname
        has_remappipenames = !self[:has_remappipenames].nil?
        self.fail "You must specify address, and subnetmask" if has_remappipenames.nil
      # TODO pending
      #when :fileshare
        
      #when :genericservice
      #when :physicaldisk
      #when :genericapplication
    end

  end
end
