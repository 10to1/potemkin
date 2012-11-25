module Potemkin
  class Builder

    # Will build the actual APK
    def build
      logger.describe "creating build"
      Potemkin.run build_command
    end

    def clean
      logger.describe "cleaning build"
      Potemkin.run clean_command
    end


    # Returns the command to be executed to build
    # This command should be run in the root of the project dir
    def build_command
      <<-command
  ANDROID_HOME=#{config.sdk_root} &&
export ANDROID_HOME &&
ant -f #{android_project_dir}/build.xml clean &&
ant -f #{android_project_dir}/build.xml #{config.build_type}
command

    end

    def android_project_dir
      raise "Please add project dir" unless config.android_project_dir
      config.android_project_dir
    end

    # Returns the config, mainly here to mock in tests
    def config
      Potemkin.config
    end

    # Returns the logger, mainly here to mock in tests
    def logger
      Potemkin.logger
    end

  end
end
