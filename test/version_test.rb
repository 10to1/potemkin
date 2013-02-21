require "helper"
describe Potemkin::Version do

  describe "a version initialized from a string" do

    it "should load a semver string without a problem" do
      assert_equal "1.0.0", Potemkin::Version.new("1.0.0").to_s
    end

    it "should set anything it doesn't recognise to 0.0.0" do
      assert_equal "0.0.0", Potemkin::Version.new("epic_version").to_s
    end
  end

  describe "bumping a version" do
    before do
      @version = Potemkin::Version.new("0.0.1")
    end

    it "should bump the major" do
      @version.bump_major
      assert_equal "1.0.0", @version.to_s
    end

    it "should bump the minor" do
      @version.bump_minor
      assert_equal "0.1.0", @version.to_s
    end

    it "should bump the patch" do
      @version.bump_patch
      assert_equal "0.0.2", @version.to_s
    end
  end

  describe "initialization for platforms" do
    it "should initialize an ios version with the plist set" do
      Potemkin::Version.stubs(:config).returns(Potemkin::Configuration.new(:ios_plist_path => "some/path"))
      Potemkin::Ios::Version.expects(:new).with("some/path").once
      Potemkin::Version.get_version
    end

    it "should initialize an android version with the manifest" do
      Potemkin::Version.stubs(:config).returns(Potemkin::Configuration.new(:android_manifest_path => "some/path"))
      manifest = Potemkin::Android::Manifest.new("some/path")
      Potemkin::Android::Manifest.expects(:new).with("some/path").returns(manifest).once
      Potemkin::Android::Version.expects(:new).with(manifest).once
      Potemkin::Version.get_version
    end


    it "should get a discovered android version when only the platform is set to android" do
      Potemkin.stubs(:platform_namespace).returns(Potemkin::Android)
      Potemkin::Android::Version.expects(:discovered)
      Potemkin::Version.get_version
    end

  end

  it "should be able to print out a changelog with since the previous version" do
    Potemkin::Git.expects(:discovered).returns(OpenStruct.new({previous_tag: "prev", changelog:["one", "two"]}))
    version = Potemkin::Version.new("0.0.1")
    expected_output = <<changelog
Version was bumped to 0.0.1.

Here's what you've been doing since prev:

one
two

changelog
    assert_equal expected_output, version.summary
  end
end
