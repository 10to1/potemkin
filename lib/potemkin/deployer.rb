module Potemkin
  class Deployer
    attr_accessor :build_path

    def initialize(build_path)
      self.build_path = build_path
    end

  end
end
