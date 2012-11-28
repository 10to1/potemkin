require "helper"
describe Potemkin::IosVersion do

  it "should expose the version object" do
    Potemkin::IosVersion.any_instance.stubs(:fetch_version).returns("1.2.3")
    v = Potemkin::IosVersion.new("some/path")
    assert_equal "1.2.3", v.version.to_s
  end
end
