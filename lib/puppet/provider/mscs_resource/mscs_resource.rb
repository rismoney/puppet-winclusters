require 'D:\gitrepo\ruby-mscs\lib\mscs.rb'

Puppet::Type.type(:mscs_resource).provide(:mscs_resource) do
  desc "Resource Provider for MSCS clusters."

  def init
    clustername = resource[:clustername]
    Mscs::Cluster.initialize clustername
  end

  def config_ip
      {
        :enabledhcp    => 0,
        :address       => @resource[:ipaddress],
        :subnetmask    => @resource[:subnetmask],
        :network       => @resource[:network],
        :enablenetbios => 0
      }
  end

  def config_name
      {
        :name          => @resource[:name],
      }
  end

  def config_generic_service
      {
        :startupparameters    => @resource[:startupparameters]
      }
  end

  def config_fileshare
      {
        :path           => @resource[:path],
        :sharename      => @resource[:sharename],
        :maxusers       => @resource[:maxusers],
        :remark         => @resource[:remark],
        :sharedubdirs   => @resource[:sharesubdirs],
      }
  end
  
  def config_disk
      {
        :diskid             => @resource[:diskid],
        :skipchkdsk         => @resource[:skipchkdsk],
        :conditionalmount   => @resource[:conditionalmount],
      }
  end

  def create

    Mscs::Resource.add(@resource[:name],@resource[:resourcetype],@resource[:clustergroup])
    case @resource[:resourcetype]
      when "ipaddress"
        resource_config = config_ip
      when "networkname"
        resource_config = config_name
      when "genericservice"
        resource_config = config_generic_service
      when "physicaldisk"
        resource_config = config_disk
    end

    Mscs::Resource.set_priv(@resource[:name], resource_config)

  end

  def destroy
     Mscs::Resource.delete(@resource[:name])
  end

  def exists?
    init
    resourcelist=Mscs::Resource.query
    resourcelist.include?(@resource[:name])
  end
  
end