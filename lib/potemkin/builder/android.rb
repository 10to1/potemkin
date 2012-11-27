module Potemkin
  class AndroidBuilder < Builder

    # android needs the ANDROID_HOME dir to be set in the environment
    def env_vars
      { "ANDROID_HOME" => config.sdk_root }
    end

    # Returns the command to be executed to build
    # This command should be run in the root of the project dir
    def build_command
      "ant -f #{android_project_dir}/build.xml #{config.build_type}"
    end

    # this will clean out the bin directories within a project
    def clean_command
      "ant -f #{android_project_dir}/build.xml clean"
    end

    # The subfolder where the actual app is located
    def android_project_dir
      raise "Please add project dir" unless config.android_project_dir
      config.android_project_dir
    end


  end
end
