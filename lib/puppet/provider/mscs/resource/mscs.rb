require 'puppet/provider/mscs'

# fetch the mscs_type call the class provide passing it mscs_resource 

Puppet::Type.type(:mscs_resource).provide :mscs, :parent => Puppet::Provider::mscs do
  desc "Resource Provider for MSCS clusters." 

  confine :feature => :windows
  
def self.prefetch(resources)
    instances.each do |prov|
      if resource = resources[prov.name]
        resource.provider = prov
      end
    end

  end

  def self.instances
    # get a list of all resources
   
  
  end

  def flush
    @property_hash.clear
  end

  def create
    # create the #{resource[:name]
  end

  def destroy
    # kill the mofo
  end

  def currentstate
    # state of all the mofos
    
  end

  def exists?
    #
  end

end


