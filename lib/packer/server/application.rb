# coding: utf-8

require 'eventmachine'
require 'sinatra/base'
require 'packer/config'
require 'util/shell'

module Packer
  module Server
    class Application < Sinatra::Base
      get '/build' do 
        EM::defer do
          run_packer
        end
        
        "started packer process."
      end
      
      get '/health' do
        ''
      end
      
      def initialize(conf)
        @config = Packer::Config.load(conf)
      end
      
      def run_packer
        puts "config: #{@config}"
      
        Util::Shell.execute("git pull #{@config["vcs"]["url"]}")
        Util::Shell.execute("packer build #{@config["packer"]["path"]}")
      end
 
    end
  end
end
