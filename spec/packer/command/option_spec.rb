require 'spec_helper'

describe Packer::Command do
  describe "hoge" do
    it '' do
      options = Packer::Command::Options.parse!(['run', '-c ./packer.json'])
      options[:config].should == " ./packer.json"
    end
  end

end
