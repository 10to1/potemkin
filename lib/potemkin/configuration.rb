require "ostruct"
module Potemkin
  class Configuration < OpenStruct

    def sdk_root
      super || ENV["ANDROID_SDK_ROOT"] || "/usr/local/Cellar/android-sdk/r21"
    end

    def build_type
      super || "debug"
    end

    # Works across platforms
    #
    # Returns path to the project dir.
    def project_path
      super || Dir.pwd
    end

    # Returns the path to the build configuration relative to project_dir
    # (Ant build.xml for android)
    def build_file
      super || "build.xml"
    end

    def build_directory
      return super if super
      case  platform
      when :android
        "#{project_dir}/bin/"
      when :ios
        raise "not yet implemented"
      when :ruby_motion
        raise "not yet implemented"
      end
    end

    def platform
      super || raise("Please specify your platform")
    end

  end

end
