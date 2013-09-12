# coding: utf-8

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
      options = Options.parse!(@argv)
      sub_command = options.delete(:command)

      DB.prepare

      case sub_command
        when 'run'
          run_server(options[:name], options[:content])
      end
    rescue => e
        abort "Error: #{e.message}"
    end

    def run_server()
      # TODO
      puts "process to run a server"
    end

  end
end
