require "helper"
describe Potemkin::Ios::Version do

  it "should expose the version object" do
    Potemkin::Ios::Version.any_instance.stubs(:fetch_version).returns("1.2.3")
    Potemkin::Ios::Version.any_instance.stubs(:raise_error_unless_exists?).returns(:nothing)
    v = Potemkin::Ios::Version.new("some/path")
    assert_equal "1.2.3", v.version.to_s
  end
end
