require "helper"
describe Potemkin::Android::Manifest do

  before do
    @manifest = Potemkin::Android::Manifest.new(File.join(FAKE_ANDROID_PROJECT_DIR, "AndroidManifest.xml"))
  end

  it "should be able to parse the manifest" do
    assert @manifest.manifest_file.is_a? Nokogiri::XML::Document
  end

  it "should be able to read the version code" do
    assert_equal 1, @manifest.version_code
  end

  it "should be able to read the version name" do
    assert_equal "1.0", @manifest.version_name
  end

  it "should be able to change the version name" do
    @manifest.version_name = "1.0.1"
    assert_equal "1.0.1", @manifest.version_name
  end

  it "should be able to change the version code" do
    @manifest.version_code = 2
    assert_equal 2, @manifest.version_code
  end

  it "should be able to find a manifest in a directory" do
    assert_equal File.join(FAKE_ANDROID_PROJECT_DIR, "AndroidManifest.xml"), Potemkin::Android::Manifest.find_manifest_in_dir(FAKE_ANDROID_PROJECT_DIR)
  end

  it "should be able to create a manifest by discovering the manifest file" do
    Potemkin::Android::Manifest.expects(:new).with(File.join(FAKE_ANDROID_PROJECT_DIR, "AndroidManifest.xml"))
    Potemkin::Android::Manifest.discovered
  end

end
