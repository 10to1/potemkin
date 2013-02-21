module Potemkin
  VERSION = "0.0.1"

  class Version

    def self.get_version
      if config.android_manifest_path
        manifest = Potemkin::Android::Manifest.new(config.android_manifest_path)
        Potemkin::Android::Version.new(manifest)
      elsif config.ios_plist_path
        Potemkin::Ios::Version.new(config.ios_plist_path)
      else
        Potemkin.platform_namespace.const_get("Version").discovered
      end
    end

    attr_reader :major, :minor, :patch
    def initialize(string)
      @major, @minor, @patch = string.strip.split(".")
      @major = @major.to_i || 0
      @minor = @minor.to_i || 0
      @patch = @patch.to_i || 1
    end

    def summary
      git = Potemkin::Git.discovered
      changelog =
<<changelog
Version was bumped to #{self}.

Here's what you've been doing since #{git.previous_tag}:

#{git.changelog.join("\n")}

changelog
    end

    def bump_major
      @major += 1
      @minor = 0
      @patch = 0
    end

    def bump_minor
      @minor += 1
      @patch = 0
    end

    def bump_patch
      @patch += 1
    end

    def to_s
      [major, minor, patch].compact.join('.')
    end

    def self.config
      Potemkin.config
    end
  end
end
