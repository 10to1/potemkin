module Potemkin
  class IosVersion
    extend Forwardable
    def_delegators :@version, :bump_major, :bump_minor, :bump_patch
    def initialize(plist_path)
      @plist_path = plist_path
      semver = fetch_version
      @version = Version.new(semver)
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
  end
end
