require "nokogiri"
module Potemkin
  module Android
    class Manifest
      attr_accessor :manifest_path

      def initialize(path)
        @manifest_path = path
      end

      def manifest_file
        @manifest_file ||= Nokogiri::XML(File.read(manifest_path))
      end

      def manifest_node
        @manifest_node ||= manifest_file.xpath("manifest", "android" => "http://schemas.android.com/apk/res/android").first
      end

      def version_code
        manifest_node["versionCode"].to_i
      end

      def version_code=(value)
        manifest_node["android:versionCode"] = value.to_s
      end

      def version_name
        manifest_node["versionName"]
      end

      def version_name=(value)
        manifest_node["android:versionName"] = value.to_s
      end

      def save!
        file = File.open(manifest_path, "w")
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
