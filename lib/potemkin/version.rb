module Potemkin
  VERSION = "0.0.1"

  class Version
    attr_reader :major, :minor, :patch
    def initialize(string)
      @major, @minor, @patch = string.strip.split(".")
      @major = @major.to_i || 0
      @minor = @minor.to_i || 0
      @patch = @patch.to_i || 1
    end

    def bump_major
      @major += 1
      @minor = 0
      @patch = 0
    end

    def bump_minor
      @minor += 1
      @patch = 0
    end

    def bump_patch
      @patch += 1
    end

    def to_s
      [major, minor, patch].compact.join('.')
    end
  end
end
