require "potemkin/version"
require "potemkin/configuration"
require "potemkin/builder"
require "potemkin/logger"

module Potemkin
  class << self
    def config
      @config ||= Configuration.default
    end

    def configure
      yield config
    end

    def run(cmd)
      puts "Executing #{cmd}"
      puts system("#{cmd}")
    end

    def logger
      @logger ||= Potemkin::Logger.new
    end

  end

end
