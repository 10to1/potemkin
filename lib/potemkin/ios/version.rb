require "forwardable"
module Potemkin
  module Ios
    class Version
      extend ::Forwardable
      def_delegators :@version, :bump_major, :bump_minor, :bump_patch
      def initialize(plist_path)
        raise_error_unless_exists?(plist_path.to_s)
        @plist_path = plist_path
        semver = fetch_version
        @version = Potemkin::Version.new(semver)
      end

      def raise_error_unless_exists?(plist_path)
        return if File.exists? plist_path

        raise <<-ERROR
Could not find a valid plist-file in #{Potemkin.config.project_dir},
please set it manually in the config file with:

    config.ios_plist_path = "<path/to/Info.plist"
ERROR
      end

      def bump(type)
        if %w(major minor patch).include?(type.downcase)
          send("bump_#{type}")
          write!
        else
          raise "Don't now how to bump the #{type}amathing"
        end
      end

      def fetch_version
        `/usr/libexec/PlistBuddy -c "Print CFBundleShortVersionString" #{@plist_path}`
      end

      def version
        @version
      end

      def git_sha
        `/usr/bin/git log -1 --format="%H"`.strip()[0..10]
      end

      def write!
        `/usr/libexec/PlistBuddy -c "Set CFBundleShortVersionString #{@version}" #{@plist_path}`
        `/usr/libexec/PlistBuddy -c "Set CFBundleVersion #{git_sha}" #{@plist_path}`
      end

      def to_s
        "%s at %s" % [@version, @plist_path]
      end

      # Takes a dir and find all file matching *-Info.plist
      #
      # Returns the first match dir
      def self.find_plist_in_dir(dir)
        `find '#{dir}' -name "*-Info.plist"`.split("\n").first
      end

      # Tries to autodetect the Info.plist file
      #
      # Returns a new version instance
      def self.discovered
        new(find_plist_in_dir(Potemkin.config.project_dir))
      end
    end
  end
end
