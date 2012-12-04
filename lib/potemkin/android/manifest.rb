require "nokogiri"
module Potemkin
  module Android
    class Manifest

      def initialize(manifest_file)
        @xml_file = Nokogiri::XML(File.open(manifest_file))
      end

      def version_code
        @xml_file.css("manifest").first["versionCode"].to_i
      end

      def version_name
        @xml_file.css("manifest").first["versionName"]
      end

      def self.discovered
        new(find_manifest_in_dir(Potemkin.config.project_dir))
      end

      def self.find_manifest_in_dir(dir)
        `find '#{dir}' -name "AndroidManifest.xml"`.split("\n").firsts
      end

    end
  end
end
