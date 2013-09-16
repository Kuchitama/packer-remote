# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'packer/server/version'

Gem::Specification.new do |spec|
  spec.name          = "packer-server"
  spec.version       = Packer::Server::VERSION
  spec.authors       = ["Kuchitama"]
  spec.email         = ["kiyo.kunihira@gmail.com"]
  spec.description   = %q{This is a tool to use Packer on the remote server. This starts to build image(s) when this get http request.}
  spec.summary       = %q{This is a tool to use Packer on the remote server.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "sinatra",      "~> 1.4.0"
  spec.add_dependency "erubis",       "~> 2.7.0"
  spec.add_dependency "eventmachine", "~> 1.0.3"
  
  spec.add_development_dependency "bundler",  "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "yard"
  spec.add_development_dependency "redcarpet"
end
