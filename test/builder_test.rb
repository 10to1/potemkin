require "helper"
describe Potemkin::Builder do

  before do
    @builder = Potemkin::Builder.new
    @builder.stubs(:config).returns(Potemkin::Configuration.new(:sdk_root => "/some/path", :android_project_dir => "dir", :build_type => "debug"))
  end

  it "should be able to wrap a block in env vars" do

  end

  it "should run the build command with the android home set" do
    android_home = "UNKNOWN"
    @builder.with_env_vars("ANDROID_HOME" => "~/her-o") do
      android_home = ENV["ANDROID_HOME"]
    end
    assert_equal "~/her-o", android_home
  end


end
