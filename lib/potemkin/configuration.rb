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

    # Works across platforms
    #
    # Returns path to the project dir.
    def project_dir
      android_project_dir || project_path
    end
  end

end
