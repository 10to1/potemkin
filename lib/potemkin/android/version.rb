module Potemkin
  module Android
    class Version < Potemkin::Version

      def initialize(manifest_file = nil)
        if manifest_file
          @manifest = Potemkin::Android::Manifest.new(manifest_file)
        else
          @manifest = Potemkin::Android::Manifest.discovered
        end
        @version_code = @manifest.version_code
        super(@manifest.version_name)
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

      def write!
        @manifest.version_code = @version_code
        @manifest.version_name = self
        @manifest.save!
      end

      def self.discovered
        new(Potemkin::Android::Manifest.discovered)
      end

    end
  end
end
