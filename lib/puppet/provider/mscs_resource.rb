#fetch the mscs_type call the class provide passing it mscs_resource 

Puppet::Type.type(:mscs_resource).provide(:mscs_resource, :parent => Puppet::Provider::MSCS) do
  desc "Resource Provider for MSCS clusters." 

  confine :feature => :windows
  
    def create
        #
    end

    def destroy
        #
    end

    def exists?
        #blah
    end
end
