require "helper"
describe Potemkin::Builder do

  before do
    @builder = Potemkin::Builder.new
    @builder.stubs(:clean_command).returns("")
    @builder.stubs(:build_command).returns("")
    @builder.stubs(:config).returns(Potemkin::Configuration.new(:sdk_root => "/some/path", :android_project_dir => "dir", :build_type => "debug"))
  end

  it "should be able to wrap a block in env vars" do
    android_home = "UNKNOWN"
    @builder.with_env_vars("ANDROID_HOME" => "~/her-o") do
      android_home = ENV["ANDROID_HOME"]
    end
    assert_equal "~/her-o", android_home
  end

  it "should clean up the env vars after the block was run" do
    ENV["hello"] = "test"
    @builder.with_env_vars("hello" => "world") do
      # nothing really
    end
    assert_equal "test", ENV["hello"]
  end

  it "should run clean commands with environment variables" do
    @builder.expects(:with_env_vars)
    @builder.clean
  end

  it "should run clean commands with environment variables" do
    @builder.expects(:with_env_vars)
    @builder.build
  end



end
