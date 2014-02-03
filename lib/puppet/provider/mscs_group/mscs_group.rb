Puppet::Type.type(:mscs_group).provide(:mscs_group) do
  desc "Group Provider for MSCS clusters." 

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
    args = "#{@@connstr};Add-ClusterGroup -Cluster \"#{@resource[:clustername]}\" -Name \"#{@resource[:name]}\""
    poshexec(args)
  end

  def destroy
    args = "#{@@connstr};Remove-ClusterGroup -Cluster \"#{@resource[:clustername]}\" -Name \"#{@resource[:name]}\" -Force"
    poshexec(args)
  end

  def exists?
    rc=false
    args = "#{@@connstr};(Get-ClusterGroup -Cluster \"#{@resource[:clustername]}\" -Name \"#{@resource[:name]}\").name"
    clustergroup = poshexec(args).chomp
    rc = true if clustergroup == @resource[:name].to_s
    return rc
	end
end