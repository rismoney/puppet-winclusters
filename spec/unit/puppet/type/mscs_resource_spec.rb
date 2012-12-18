require 'puppet'

require File.dirname(__FILE__) + '/../../../spec_helper'

describe Puppet::Type.type(:mscs_resource) do

  it do
    expect {
      Puppet::Type.type(:mscs_resource).new(:name => '')
    }.to raise_error(Puppet::Error, /Name must not be empty/)
  end

  # check to make sure all parameters can be specified
  params = [
  'network',
  'enablenetbios',
  'remark',
  'startupparameters',
  'conditionalmount',
  'clustername',
  'clustergroup',
  ].each do |param|
    context "when a valid cluster parameter #{param} => is specified" do
      it "should not raise an error" do
        expect {
          Puppet::Type.type(:mscs_resource).new(:name => 'test', param => "blah")
          }.to_not raise_error
      end
    end
  end




# check to make sure these are valid parameters (assign them a required boolean)
   params = [
  'sharedubdirs',
  'remappipenames',
  'skipchkdsk',
  'interactwithDesktop',
  'usenetworkname',
  ].each do |param|
    context "when a valid cluster parameter #{param} => requiring boolean is specified  #{param}" do
      it "should not raise an error specified as true" do
        expect {
          Puppet::Type.type(:mscs_resource).new(:name => 'test', param => true)
          }.to_not raise_error
      end
      it "should not raise an error specified as false" do
        expect {
          Puppet::Type.type(:mscs_resource).new(:name => 'test', param => false)
          }.to_not raise_error
      end
      it "should not raise an error specified as y" do
        expect {
          Puppet::Type.type(:mscs_resource).new(:name => 'test', param => 'y')
          }.to_not raise_error
      end
      it "should not raise an error specified as n" do
        expect {
          Puppet::Type.type(:mscs_resource).new(:name => 'test', param => 'n')
          }.to_not raise_error
      end
      it "should not raise an error specified as yes" do
        expect {
          Puppet::Type.type(:mscs_resource).new(:name => 'test', param => 'yes')
          }.to_not raise_error
      end
      it "should not raise an error specified as no" do
        expect {
          Puppet::Type.type(:mscs_resource).new(:name => 'test', param => 'no')
          }.to_not raise_error
      end
    end
    
    context "when a valid cluster parameter #{param} => requiring boolean is not respected" do
      it "should raise an error" do
        expect {
          Puppet::Type.type(:mscs_resource).new(:name => 'test', param => 'booya')
          }.to raise_error
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
          Puppet::Type.type(:mscs_resource).new(:name => 'test', param => 'C:\windows')
          }.to raise_error
      end
    end
  end
  
  # check to make sure valid resource types are selected.
  res_types = [
  'networkname','nn',
  'genericservice','gensvc',

  ].each do |res_type|
    context "when resourcetype => #{res_type} is specified" do
  
  
      it 'should not raise an error' do
        expect {
          Puppet::Type.type(:mscs_resource).new(:name => 'test', :resourcetype => res_type)
          }.to_not raise_error
      end
    end
  end

  context "when a ip address resource is specified with ip address and subnetmask" do
    it do
      expect {
        Puppet::Type.type(:mscs_resource).new(:name => 'test', :resourcetype => 'ipaddress', :ipaddress => '1.1.1.1', :subnetmask => '2.2.2.2')
        }.to_not raise_error
    end
  end
  context "when a ip address resource is specified with ip address with subnetmask no ip" do
    it do
      expect {
        Puppet::Type.type(:mscs_resource).new(:name => 'test', :resourcetype => 'ipaddress', :subnetmask => '2.2.2.2')
        }.to raise_error
    end
  end
  context "when a ip address resource is specified with ip address and no subnetmask" do
    it do
      expect {
        Puppet::Type.type(:mscs_resource).new(:name => 'test', :resourcetype => 'ipaddress', :ipaddress => '1.1.1.1')
        }.to raise_error
    end
  end
  context "when a generic app is specified with command line and has current directory" do
    it do
      expect {
        Puppet::Type.type(:mscs_resource).new(:name => 'test', :resourcetype => 'genapp', :commandline => 'blah', :currentdirectory => 'C:\windows')
        }.to_not raise_error
    end
  end
  context "when a generic app is specified with currentdirectory and missing commandline" do
    it do
      expect {
        Puppet::Type.type(:mscs_resource).new(:name => 'test', :resourcetype => 'genapp', :currentdirectory => 'C:\windows')
        }.to raise_error
    end
  end
  context "when a generic app is specified with command line but missing currendir " do
    it do
      expect {
        Puppet::Type.type(:mscs_resource).new(:name => 'test', :resourcetype => 'genapp', :commandline => 'blah')
        }.to raise_error
    end
  end
  context "when a physical disk is specified with missing signature" do
    it do
      expect {
        Puppet::Type.type(:mscs_resource).new(:name => 'test', :resourcetype => 'pd')
        }.to raise_error
    end
  end
  context "when a physical disk is specified with signature" do
    it do
      expect {
        Puppet::Type.type(:mscs_resource).new(:name => 'test', :resourcetype => 'pd', :signature => 'blah')
        }.to_not raise_error
    end
  end
  

  context "when a file share resource is specified with path and sharename" do
    it do
      expect {
        Puppet::Type.type(:mscs_resource).new(:name => 'test', :resourcetype => 'fs', :path => 'C:\\windows', :sharename => 'blah')
        }.to_not raise_error
    end
  end
  
   context "when a file share resource is specified without path and sharename" do
    it do
      expect {
        Puppet::Type.type(:mscs_resource).new(:name => 'test', :resourcetype => 'fileshare')
        }.to raise_error
    end
   end
  
# inverse kick out bad resource types
  res_types = [
  'booya',
  '123',
  ].each do |res_type|
      it "should fail if the resourcetype #{res_type} is not valid" do
        expect {
          Puppet::Type.type(:mscs_resource).new(:name => 'test', :restype => res_type)
          }.to raise_error
    end
  end

end