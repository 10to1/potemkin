require "ostruct"
module Potemkin
  class Configuration < OpenStruct

    def self.default
      new \
      :sdk_root => default_sdk_root,
      :build_type => default_build_type
    end


    def self.default_sdk_root
      ENV["ANDROID_SDK_ROOT"] || "/usr/local/Cellar/android-sdk/r21"
    end

    def self.default_build_type
      "debug"
    end

  end

end
