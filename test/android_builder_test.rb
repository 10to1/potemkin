require "helper"
describe Potemkin::Android::Builder do

  before do
    @builder = Potemkin::Android::Builder.new
    @builder.stubs(:config).returns(Potemkin::Configuration.new(:sdk_root => "/some/path", :android_project_dir => "dir", :build_type => "debug"))
  end

  it "should run the build command with the android home set" do
    @builder.expects(:with_env_vars).with("ANDROID_HOME" => "/some/path").once
    @builder.build
  end

  it "should run a build command" do
    command = "ant -f dir/build.xml debug"
    Potemkin.expects(:run).with(command).once
    @builder.build
  end

  it "should run a clean command" do
    command = "ant -f dir/build.xml clean"
    Potemkin.expects(:run).with(command).once
    @builder.clean
  end

  it "should fail if the project dir is not set" do
    @builder_without_dir = Potemkin::Android::Builder.new
    @builder_without_dir.stubs(:config).returns(Potemkin::Configuration.new(:sdk_root => "/some/path", :build_type => "debug"))
    builder_error = @builder_without_dir.build rescue "RESCUED"
    assert_equal "RESCUED", builder_error
  end




end
