module Potemkin
  module Android
    class Builder < Potemkin::Builder
      # android needs the ANDROID_HOME dir to be set in the environment
      def env_vars
        { "ANDROID_HOME" => config.sdk_root }
      end

      # Returns the command to be executed to build
      # This command should be run in the root of the project dir
      def build_command(build_type = config.build_type)
        "ant -f #{project_dir}/#{build_file} #{build_type}"
      end

      # this will clean out the bin directories within a project
      def clean_command
        build_command("clean")
      end

      def package_command
        build_command("release")
      end

      # The subfolder where the actual app is located
      def project_dir
        config.project_dir
      end

      def build_file
        config.build_file
      end
    end
  end
end
