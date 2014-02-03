Puppet::Type.type(:mscs_cluster).provide(:mscs_cluster) do
  desc "Cluster Provider for MSCS clusters." 

  commands :poshexec =>
    if File.exists?("#{ENV['SYSTEMROOT']}\\sysnative\\WindowsPowershell\\v1.0\\powershell.exe")
      "#{ENV['SYSTEMROOT']}\\sysnative\\WindowsPowershell\\v1.0\\powershell.exe"
    elsif File.exists?("#{ENV['SYSTEMROOT']}\\system32\\WindowsPowershell\\v1.0\\powershell.exe")
      "#{ENV['SYSTEMROOT']}\\system32\\WindowsPowershell\\v1.0\\powershell.exe"
    else
      'powershell.exe'
    end

  @@connstr= "import-module failoverclusters | out-null"

  def create
    args = "#{@@connstr};New-Cluster -Name \"#{@resource[:name]}\" -Node \"#{@resource[:nodenames].to_a.first}\" -StaticAddress \"#{@resource[:ipaddress].to_a.first}\""
    poshexec(args)
    # TODO set additional IPs and SubnetMasks
    end

  def destroy
    args = "#{@@connstr};Get-Cluster \"#{@resource[:name]}\" | Remove-Cluster"
    poshexec(args)
    # TODO force parameter needed - this isn't going to work
  end

  def exists?
    rc = false
    clusternodes = []
    args = "#{@@connstr};(Get-ClusterNode -Cluster \"#{@resource[:name]}\") 2> $null | foreach { $_.Name }"
    clusternodes=poshexec(args).chomp
    rc = true if clusternodes.include?(@resource[:nodenames].to_a.first)
    return rc
  end

end