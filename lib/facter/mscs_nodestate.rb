# vim: set ts=2 sw=2 ai et:
require 'facter'

module Ise
  class Mscs
    class Nodestate
      def self.value(os = Facter.value(:kernel))
        case os
          when 'windows'; windows_value
          else          ; 'n/a'
        end
      end


      def self.windows_value
        require 'win32ole'
        clusterstate = ""
        objWMIService  = WIN32OLE.connect('winmgmts:{impersonationLevel=impersonate,authenticationLevel=pktPrivacy}!//./root/mscluster')
        objClus = objWMIService.Get("MSCluster_Cluster")
        nodestate=objClus.ExecMethod_("GetNodeClusterState")
        clusterstate = case nodestate.ClusterState
          when 0 ; 'ClusterStateNotInstalled'
          when 1 ; 'ClusterStateNotConfigured'
          when 3 ; 'ClusterStateNotRunning'
          when 19 ; 'ClusterStateRunning'
          else 'unavailable'
        end
        rescue WIN32OLERuntimeError
          clusterstate='busted'
      end
    end
  end
 end


Facter.add(:mscs_nodestate) do
  setcode { Ise::Mscs::Nodestate.value }
end