# coding: utf-8

module Util

  require 'json'
  
  class Config
    def self.load(json_path)
      conf = File.open(json_path) do |io|
        JSON.load(io)
      end
      
      return DEFAULT.merge(conf)
    end
    
    DEFAULT = {"port" => 8080, "packer" => "./packer.json"}
  end
end
