require 'spec_helper'

describe Packer::Remote do
  it 'should have a version number' do
    Packer::Remote::VERSION.should_not be_nil
  end

end
