require 'puppet'

require File.dirname(__FILE__) + '/../../../spec_helper'

describe Puppet::Type.type(:mscs_resource) do

  it 'should fail if the name is empty ""' do
    expect {
      Puppet::Type.type(:mscs_resource).new(:name => '')
    }.to raise_error(Puppet::Error, /Name must not be empty/)
  end

  res_types = [
  'ipaddress','ip',
  'networkname','nn',
  'fileshare','fs',
  'genericservice','gensvc',
  'physicaldisk','pd',
  'genericapplication','genapp',
  ].each do |res_type|
    context "when resource type is #{res_type}" do
  
  
      it 'should not fail if the resourcetype is not valid' do
        expect {
          Puppet::Type.type(:mscs_resource).new(:name => 'test', :restype => res_type)
          }.to_not raise_error
      end
    end
  end
  
  res_types = [
  'garbage1',
  '123',
  ].each do |res_type|
      it 'should fail if the resourcetype is not valid' do
        expect {
          Puppet::Type.type(:mscs_resource).new(:name => 'test', :restype => res_type)
          }.to raise_error
    end
  end
  
end
