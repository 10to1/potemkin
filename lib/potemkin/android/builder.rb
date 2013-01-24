module Potemkin
  module Android
    class Builder < Potemkin::Builder

      attr_accessor :build_type

      # android needs the ANDROID_HOME dir to be set in the environment
      def env_vars
        { "ANDROID_HOME" => config.sdk_root }
      end

      # Returns the command to be executed to build
      # This command should be run in the root of the project dir
      def build_command(build_task = "debug")
        "ant -f #{project_dir}/#{build_file} #{build_task}"
      end

      # this will clean out the bin directories within a project
      def clean_command
        build_command("clean")
      end

      def sign_command
        return if !release_keystore || !keystore_password || !keystore_alias
        "jarsigner -sigalg #{key_algorithm} -digestalg #{digest_algorithm} -keystore #{release_keystore} -storepass #{keystore_password} #{signed_build} #{keystore_alias}"
      end

      def align_command
        "zipalign 4 #{signed_build} #{aligned_build}"
      end

      def prepare_apk_command(source, destination)
        "cp #{source} #{destination}"
      end

      # Create a signed, aligned apk for distribution
      def package_command
        @build_type = "release"
        [
         clean_command,
         build_command(build_type),
         prepare_apk_command(unsigned_build, signed_build),
         sign_command,
         align_command
        ].join(" && ")
      end

      def unsigned_build
        "#{build_directory}/#{project_name}-#{build_type}-unsigned.apk"
      end

      def signed_build
        "#{build_directory}/#{project_name}-#{build_type}-signed.apk"
      end

      def aligned_build
        "#{build_directory}/#{project_name}-#{build_type}-aligned.apk"
      end

      def build_type
        @build_type ||= "debug"
      end

      # The subfolder where the actual app is located
      def project_dir
        config.project_path
      end

      # The (ant) build file
      def build_file
        config.build_file
      end

      # the directory where builds are made
      def build_directory
        config.build_directory
      end

      def project_name
        config.project_name
      end

      def key_algorithm
        config.key_algorithm
      end

      def digest_algorithm
        config.digest_algorithm
      end

      def release_keystore
        config.release_keystore
      end

      def keystore_password
        config.keystore_password
      end

      def keystore_alias
        config.keystore_alias
      end

    end
  end
end
