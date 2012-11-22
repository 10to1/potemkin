require "potemkin/version"
require "potemkin/configuration"
module Potemkin
  class << self
    def config
      @config ||= Configuration.default
    end

    def configure
      yield config
    end
  end
end
