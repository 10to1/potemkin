require "forwardable"
module Potemkin
  module Android
    class Version
      extend ::Forwardable
      def_delegators :@version, :bump_major, :bump_minor, :bump_patch

      def initialize(manifest)
        @manifest = manifest
        @version_code = @manifest.version_code
        @version = Potemkin::Version.new(@manifest.version_name)
      end

      def bump(type)
        if %w(major minor patch).include?(type.downcase)
          @version_code +=1
          send("bump_#{type}")
          write!
        else
          raise "Don't now how to bump the #{type}amathing"
        end
      end

      # TODO: Keep the users formating in the manifest
      def write!
        @manifest.version_code = @version_code
        @manifest.version_name = @version
        @manifest.save!
      end

      def self.discovered
        new(Potemkin::Android::Manifest.discovered)
      end

    end
  end
end
