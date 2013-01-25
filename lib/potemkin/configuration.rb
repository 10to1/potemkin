require "ostruct"
module Potemkin
  class Configuration < OpenStruct

    def sdk_root
      super || ENV["ANDROID_SDK_ROOT"] || "/usr/local/Cellar/android-sdk/r21"
    end

    # Works across platforms
    #
    # Returns path to the project dir.
    def project_path
      super || Dir.pwd
    end

    # Returns the path to the build configuration in project_dir
    # (Ant build.xml for android)
    def build_file
      super || "#{project_path}/build.xml"
    end

    # The directory where your app is located
    def build_directory
      return super if super
      case  platform
      when :android
        "#{project_path}/bin"
      when :ios
        raise "not yet implemented"
      when :ruby_motion
        raise "not yet implemented"
      end
    end

    # The platform that we're trying to build against
    #
    # This one must be set
    def platform
      super || raise("Please specify your platform")
    end

    def keystore
      super || "release.keystore"
    end

    def key_algorithm
      super || "MD5withRSA"
    end

    def digest_algorithm
      super || "SHA1"
    end

    def keystore_alias
      super || raise("Please set the keystore entry to use")
    end

    def project_name
      super || File.basename(project_path).downcase
    end

  end

end
