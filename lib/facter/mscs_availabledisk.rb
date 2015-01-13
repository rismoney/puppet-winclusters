# vim: set ts=2 sw=2 ai et:
require 'facter'

module Ise
  class Mscs
    def self.value(os = Facter.value(:kernel))
      case os
        when 'windows'; windows_value
        else          ; 'n/a'
      end
    end

    def self.windows_value
      require 'win32ole'
      clusterdisk_hash = { }
      begin

        objWMIService  = WIN32OLE.connect('winmgmts:{impersonationLevel=impersonate,authenticationLevel=pktPrivacy}!//./root/mscluster')
        objAvailableDisks = objWMIService.ExecQuery("Select * from MSCluster_AvailableDisk")
        objAvailableDisks.each do |disk|
          disk.Properties_.each do |property|
            key = "#{disk.name}_#{property.name}".to_sym
            clusterdisk_hash[key] = property.value
          end
        end
        
      rescue WIN32OLERuntimeError
        clusterdisk_hash={ }
      end
      clusterdisk_hash
    end
  end
end

Ise::Mscs::value.each do |k,v|

Facter.add("mscluster_availabledisk_#{k}") do
  setcode { v }
  end
end
