Puppet::Type.type(:mscs_resource).provide(:mscs_resource) do
  desc "Resource Provider for MSCS clusters." 

  commands :poshexec =>
    if File.exists?("#{ENV['SYSTEMROOT']}\\sysnative\\WindowsPowershell\\v1.0\\powershell.exe")
      "#{ENV['SYSTEMROOT']}\\sysnative\\WindowsPowershell\\v1.0\\powershell.exe"
    elsif File.exists?("#{ENV['SYSTEMROOT']}\\system32\\WindowsPowershell\\v1.0\\powershell.exe")
      "#{ENV['SYSTEMROOT']}\\system32\\WindowsPowershell\\v1.0\\powershell.exe"
    else
      'powershell.exe'
    end

  @@connstr= "import-module failoverclusters | out-null"

  def config_ip
    args = "#{@@connstr};" +
      "$Resource = Add-ClusterResource -Name \"#{@resource[:name]}\" -ResourceType \"IP Address\" -Group \"#{@resource[:clustergroup]}\";" +
      "$IPAddress = New-Object -TypeName Microsoft.FailoverClusters.PowerShell.ClusterParameter -ArgumentList $Resource,Address,\"#{@resource[:ipaddress]}\";" +
      "$SubnetMask = New-Object -TypeName Microsoft.FailoverClusters.PowerShell.ClusterParameter -ArgumentList $Resource,SubnetMask,\"#{@resource[:subnetmask]}\";" +
      "$IPAddress,$SubnetMask | Set-ClusterParameter"
    poshexec(args)
  end

  def config_name
    args = "#{@@connstr};" +
      "$resource = Add-ClusterResource \"#{@resource[:name]}\" -ResourceType \"Network Name\" -Group \"#{@resource[:clustergroup]}\";"+
      "$DNSName = New-Object -TypeName Microsoft.FailoverClusters.PowerShell.ClusterParameter -ArgumentList $Resource,DNSNAME,\"#{@resource[:name]}\";" +
      "$NetName = New-Object Microsoft.FailoverClusters.PowerShell.ClusterParameter $Resource,Address,\"#{@resource[:name]}\";" +
      "$DNSName,$NetName | Set-ClusterParameter"
    poshexec(args)
  end

  def set_private
  # TODO
  end

  def create
    args = "#{@@connstr};Add-ClusterResource -Cluster \"#{@resource[:clustername]}\ -Name \"#{@resource[:name]}\" -ResourceType \"#{@resource[:resourcetype]}\" -Group \"#{@resource[:clustergroup]}\""
    poshexec(args)

    case @resource[:resourcetype]
    when "ipaddress"
          config_ip
    when "networkname"
          config_name
    end #case
 
  end

  def destroy
    args = "#{@@connstr};Remove-ClusterResource -Cluster \"#{@resource[:clustername]}\" -Name \"#{@resource[:name]}\" -force"
    poshexec(args)
  end

  def exists?
    rc=false
    args = "#{@@connstr};(Get-ClusterResource -Cluster \"#{@resource[:clustername]}\" -Name \"#{@resource[:name]}\" 2> $null).name"
    clusterresource = poshexec(args).chomp
    rc = true if clusterresource == @resource[:name].to_s
    return rc
  end
end
