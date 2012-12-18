module Puppet
  class MscsProperty < Puppet::Property
    munge do |value|
      value.to_s
    end
  end
end
