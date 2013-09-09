require 'spec_helper'

describe Packer::Server do
  it 'should have a version number' do
    Packer::Server::VERSION.should_not be_nil
  end

end
