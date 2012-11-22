require "helper"
describe Potemkin::Configuration do

  it "a new configuration should have an SDK" do
    refute_nil Potemkin.config.sdk_root
  end

  it "should respect custom SDK path" do
    Potemkin.configure do |config|
      config.sdk_root = "/some/path"
    end
    assert_equal "/some/path", Potemkin.config.sdk_root
  end

end
