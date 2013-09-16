# coding: utf-8

require 'packer/command/option'
require 'packer/config'
require 'util/shell'
require 'erubis'

module Packer
  # コマンドラインベースの処理を行うクラス
  # @authore kuchitama
  class Command
  
    def self.run(argv)
      new(argv).execute
    end

    def initialize(argv)
      @argv = argv
    end
    
    def execute
      puts "argv: #{@argv}"
      options = Packer::Command::Options.parse!(@argv)
      puts "options: #{options}"
      sub_command = options.delete(:command)

      case sub_command
        when 'run'
          unless options[:config]
            options[:config] = "./config.json"
          end
          
          run_server(options[:port], options[:config])
      end
    rescue => e
        abort "Error: #{e.message}"
    end

   
    def run_server(port, config)
      conf_path = File.expand_path(config)
      conf = Packer::Config.load(config)
      
      if port
        conf["port"] = port
      end
      
      puts 'Start server process...'

      # generate 'config.ru' from 'config.ru.eruby'
      eruby_path = File.expand_path(File.join(File.dirname(__FILE__), '..', '..', 'config.ru.eruby'))
      eruby = Erubis::Eruby.new(File.read(eruby_path))
      rack_config = File.join(File.dirname(conf_path), 'config.ru')

      File.open(rack_config, 'w') do |f|
        f.write(eruby.result(:path => conf_path))
      end

      exec "cd #{File.dirname(rack_config)} && rackup -E production -p #{conf["port"]} ./config.ru"
    end
    
    
  end
end
