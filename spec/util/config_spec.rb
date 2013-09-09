require 'spec_helper'

describe Util::Config do
  it 'should return default hash from json' do
    Util::Config.load("spec/resources/empty.json").should == Util::Config::DEFAULT
 end
end
