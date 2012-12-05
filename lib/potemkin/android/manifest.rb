require "nokogiri"
module Potemkin
  module Android
    class Manifest

      def initialize(manifest_path)
        @manifest_path = manifest_path
      end

      def manifest_file
        @manifest_file ||= Nokogiri::XML(File.open(@manifest_path))
      end

      def version_code
        manifest_file.css("manifest").first["versionCode"].to_i
      end

      def version_code=(value)
        manifest_file.css("manifest").first["android:versionCode"] = value.to_s
      end

      def version_name
        manifest_file.css("manifest").first["versionName"]
      end

      def version_name=(value)
        manifest_file.css("manifest").first["android:versionName"] = value.to_s
      end

      def save!
        file = File.open(@manifest_path, "w")
        file.write(manifest_file)
        file.close
      end

      def self.discovered
        new(find_manifest_in_dir(Potemkin.config.project_dir))
      end

      def self.find_manifest_in_dir(dir)
        `find '#{dir}' -name "AndroidManifest.xml"`.split("\n").first
      end

    end
  end
end
