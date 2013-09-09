require 'spec_helper'

describe Util::Config do
  it 'should return default hash from json' do
    Util::Config.load("spec/resources/empty.json").should == Util::Config::DEFAULT
  end
 
  it 'should not change default value after load' do
    Util::Config.load("spec/resources/part.json")
    Util::Config::DEFAULT.should == {"port" => 8080, "packer" => "./packer.json"}
  end
  
  it 'should return hash over right by json value' do
    Util::Config.load("spec/resources/part.json").should == {"port"=>9000, "packer" => "./packer.json"}
  end
end
