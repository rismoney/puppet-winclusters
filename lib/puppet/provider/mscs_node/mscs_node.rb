Puppet::Type.type(:mscs_node).provide(:mscs_node) do
  desc "Group Provider for MSCS clusters." 

  commands :poshexec =>
  if File.exists?("#{ENV['SYSTEMROOT']}\\sysnative\\WindowsPowershell\\v1.0\\powershell.exe")
    "#{ENV['SYSTEMROOT']}\\sysnative\\WindowsPowershell\\v1.0\\powershell.exe"
  elsif File.exists?("#{ENV['SYSTEMROOT']}\\system32\\WindowsPowershell\\v1.0\\powershell.exe")
    "#{ENV['SYSTEMROOT']}\\system32\\WindowsPowershell\\v1.0\\powershell.exe"
  else
    'powershell.exe'
  end

  def create
    args = "#{@@connstr};get-cluster \"#{@resource[:clustername]}\| Add-ClusterNode -Name \"#{@resource[:name]}\""
    poshexec(args)
  end 

  def destroy
    args = "#{@@connstr};Remove-ClusterNode -Cluster \"#{@resource[:clustername]}\" -Name \"#{@resource[:name]}\" -Force"
    poshexec(args)
  end

  def exists?
    rc=false
    args = "#{@@connstr};(Get-ClusterNode -Cluster \"#{@resource[:clustername]}\" -Name \"#{@resource[:name]}\" 2> $null).name"
    clusternode = poshexec(args).chomp
    rc = true if clusternode == @resource[:name].to_s
    return rc
  end

end
