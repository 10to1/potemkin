require "helper"
describe Potemkin::Android::Version do

  before do
    @manifest = Potemkin::Android::Manifest.new(File.join(FAKE_ANDROID_PROJECT_DIR, "AndroidManifest.xml"))
    @version = Potemkin::Android::Version.new(@manifest)
  end

  %w(major minor patch).each do |type|
    it "increments the version code when bumping #{type}" do
      code = @version.version_code
      @version.bump(type)
      assert_equal code + 1, @version.version_code
    end

    it "writes the manifest when bumping #{type}" do
      @version.expects(:write!)
      @version.bump(type)
    end

    it "bumps for #{type}" do
      @version.expects("bump_#{type}")
      @version.bump(type)
    end
  end

  it "sets the version code when writing" do
    @manifest.expects("version_code=")
    @version.write!
  end

  it "sets the version name when writing" do
    @manifest.expects("version_name=")
    @version.write!
  end

  it "can be initialized with a discovered manifest" do
    Potemkin::Android::Manifest.expects(:discovered).returns(@manifest)
    Potemkin::Android::Version.discovered
  end


end
