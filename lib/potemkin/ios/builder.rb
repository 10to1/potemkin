module Potemkin
  module Ios
    class Builder < Potemkin::Builder

      # Returns the command to be executed to build
      # This command should be run in the root of the project dir
      def build_command
        args = {
          "target" => config.target,
          "configuration" => config.configuration,
          "project" => config.project_path
        }.collect{|k,v| "-#{k} '#{v}'"}.join(" ")

        "#{xcodebuild_path} #{args}"
      end

      def clean_command
        "#{build_command} clean"
      end

      def xcodebuild_path
        "/usr/bin/xcodebuild"
      end
    end
  end
end
