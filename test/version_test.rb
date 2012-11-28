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
end
