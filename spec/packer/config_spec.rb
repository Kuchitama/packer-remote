require 'spec_helper'

describe Packer::Config do
  describe "load" do
    it 'should not change default value after load' do
      Packer::Config.load("spec/resources/part.json")
      Packer::Config::DEFAULT.should == {"port" => 8080, "packer" => "./packer.json"}
    end
  
    it 'should return hash over right by json value' do
      Packer::Config.load("spec/resources/part.json").should == {"port" => 9000, "packer" => "./packer.json", "vcs" => {"type" => "git", "url" => "https://host/repository.git"}}
    end
  
    it 'should raise error when json is not has require settings' do
      expect{ Packer::Config.load("spec/resources/empty.json") }.to raise_error
    end
  end 
  
  describe "validateConfig" do
    it 'should raise error when "vcs" is not setted' do
      expect{ Packer::Config.validateConfig({}) }.to raise_error
    end
    it 'should raise error when "vcs"."type" is not setted' do
      expect{ Packer::Config.validateConfig({"vcs"=>{"url" => "foo"}}) }.to raise_error
    end
    it 'should raise error when "vcs"."url" is not setted' do
      expect{ Packer::Config.validateConfig({"vcs"=>{"type" => "foo"}}) }.to raise_error
    end
    it 'should raise error when "vcs"."url" and "type" is not setted' do
      expect{ Packer::Config.validateConfig({"vcs"=>{}}) }.to raise_error
    end
  end
end
