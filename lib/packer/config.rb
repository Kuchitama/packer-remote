# coding: utf-8

module Packer

  require 'json'
  
  class Config
    def self.validateConfig(config)
      undefined_fields = []

      unless config["vcs"]
        undefined_fields << "'vcs'"
      else
        unless config["vcs"]["type"];   undefined_fields << "'vcs', 'type'";   end 
        unless config["vcs"]["url"];    undefined_fields << "'vcs', 'hoge'";   end
      end

      unless undefined_fields.empty?
        msg = "Undefined configurations. Below fields must be setted.\n"
        undefined_fields.each do |field|
          msg += "\t#{field}\n"
        end
        
        raise msg
      end
    end
    
    def self.load(json_path)
      conf = File.open(json_path) do |io|
        JSON.load(io)
      end
      
      config = DEFAULT.merge(conf)
      
      validateConfig(config)
      
      return config
    end
    
    DEFAULT = {"port" => 8080, "packer" => "./packer.json"}
    
  end
end
