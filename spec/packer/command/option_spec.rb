require 'spec_helper'

describe Packer::Command::Options do
  describe "parse!" do
    it 'return hash by argv' do
      options = Packer::Command::Options.parse!(['run', '-c ./packer.json'])
      options[:config].should == " ./packer.json"
    end
  end

end
