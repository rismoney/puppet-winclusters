require 'puppet'

require File.dirname(__FILE__) + '/../../spec_helper'

describe Puppet::Type.type(:mscs_resource) do

  it 'should fail if the name is empty ""' do
    expect {
      Puppet::Type.type(:mscs_resource).new(:name => '')
    }.to raise_error(Puppet::Error, /Name must not be empty/)
  end

  restypes = [
  'ipaddress','ip',
  'networkname','nn',
  'fileshare','fs',
  'genericservice','gensvc',
  'physicaldisk','pd',
  'genericapplication','genapp',
  ].each do |restype|
    context "when resource type is #{resourcetype}" do
  
  
      it 'should not fail if the resourcetype is not valid' do
        expect {
          Puppet::Type.type(:mscs_resource).new(:resourcetype => restype)
          }.to_not raise_error
      end
    end
  end
  
  restypes = [
  'garbage1',
  '123',
  
  ].each do |restype|
      it 'should fail if the resourcetype is not valid' do
        expect {
          Puppet::Type.type(:mscs_resource).new(:resourcetype => restype)
          }.to raise_error
    end
  end
  
end
