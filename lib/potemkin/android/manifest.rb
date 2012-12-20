require "nokogiri"
module Potemkin
  module Android
    class Manifest
      attr_accessor :manifest_path
      def initialize(path)
        puts "#{path}"
        @manifest_path = path
      end

      def manifest_file
        @manifest_file ||= Nokogiri::XML(File.open(manifest_path))
        puts @manifest_file.inspect
        @manifest_file
      end

      def version_code
        puts manifest_file.css("manifest").first["versionCode"].inspect
        manifest_file.css("manifest").first["versionCode"].to_i
      end

      def version_code=(value)
        manifest_file.css("manifest").first["android:versionCode"] = value.to_s
      end

      def version_name
        puts manifest_file.css("manifest").first["versionName"].inspect
        manifest_file.css("manifest").first["versionName"]
      end

      def version_name=(value)
        manifest_file.css("manifest").first["android:versionName"] = value.to_s
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
