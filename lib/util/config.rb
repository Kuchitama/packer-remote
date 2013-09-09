# coding: utf-8

module Util

  require 'json'
  
  class Config
    def self.load(json_path)
      File.open(json_path) do |io|
        conf = JSON.load(io)
        
        return conf
      end
    end
    
    DEFAULT = {"port" => 8080, "packer" => "./packer.json"}
  end
end
