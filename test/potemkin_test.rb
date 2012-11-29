require "helper"
describe Potemkin do

  it "should return the correct namespace for android" do
        Potemkin.stubs(:config).returns(Potemkin::Configuration.new(:platform => :android))
    assert_equal Potemkin::Android, Potemkin.platform_namespace
  end

end
