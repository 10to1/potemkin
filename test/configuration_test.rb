require "helper"
describe Potemkin::Configuration do
  before do
    Potemkin.configure do |c|
      c.platform = :android
    end
  end

  it "a new configuration should have an SDK" do
    refute_nil Potemkin.config.sdk_root
  end

  it "should respect custom SDK path" do
    Potemkin.configure do |config|
      config.sdk_root = "/some/path"
    end
    assert_equal "/some/path", Potemkin.config.sdk_root
  end

  it "should have a default build directory" do
    refute_nil Potemkin.config.build_directory
  end

end
