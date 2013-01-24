require "potemkin/version"
require "potemkin/ios/version"
require "potemkin/android/version"
require "potemkin/configuration"
require "potemkin/builder"
require "potemkin/android/builder"
require "potemkin/ios/builder"
require "potemkin/logger"
require "potemkin/git"
require "potemkin/android/manifest"


module Potemkin
  class << self
    def config
      @config ||= Configuration.new
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

    def platform_namespace
      @platform_namespace ||= const_get(config.platform.capitalize)
    end

  end

end
