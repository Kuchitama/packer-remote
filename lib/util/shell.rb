# coding: utf-8

module Util
  class Shell
    def self.execute(command)
      result = `#{command}`
      
      puts result

      if $? != 0
        raise "finish #{$?}: '#{command}'"
      end
    end
  end
end
