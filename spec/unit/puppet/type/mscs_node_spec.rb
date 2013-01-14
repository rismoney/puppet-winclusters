require 'puppet'

require File.dirname(__FILE__) + '/../../../spec_helper'

describe Puppet::Type.type(:mscs_node) do

  it do
    expect {
      Puppet::Type.type(:mscs_node).new(:name => '')
    }.to raise_error(Puppet::Error, /Name must not be empty/)
  end

  # check to make sure all parameters can be specified
  params = [
  'clustername',
  ].each do |param|
    context "when a valid cluster parameter #{param} => is specified" do
      it "should not raise an error" do
        expect {
          Puppet::Type.type(:mscs_node).new(:name => 'test', param => "blah")
          }.to_not raise_error
      end
    end
  end

# check to make sure a bullshit params raises an error 
  params = [
  'booya',
  '123',
  ].each do |param|
    context "when param used is #{param}" do
      it "should fail if the resourcetype #{param} is not valid" do
        expect {
          Puppet::Type.type(:mscs_node).new(:name => 'test', param => 'C:\windows')
          }.to raise_error
      end
    end
  end
end