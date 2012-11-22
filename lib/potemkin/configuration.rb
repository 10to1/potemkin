require "ostruct"
module Potemkin
  class Configuration < OpenStruct

    def self.default
      new :sdk_root => default_sdk_root
    end


    def self.default_sdk_root
      ENV["ANDROID_SDK_ROOT"] || "/usr/local/Cellar/android-sdk/r21"
    end

  end
end
