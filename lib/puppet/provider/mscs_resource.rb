#require 'puppet/provider/mscs'

# fetch the mscs_type call the class provide passing it mscs_resource 

Puppet::Type.type(:mscs_resource).provide(:mscs_resource) do
  desc "Resource Provider for MSCS clusters." 
  
  def create
    File.open(@resource[:name], "w") { |f| f.puts "" } # Create an empty file
  end

  def destroy
    # kill the mofo
  end

  def exists?
    File.exists?(@resource[:name])
  end

end


