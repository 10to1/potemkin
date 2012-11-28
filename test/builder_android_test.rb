require "helper"
describe Potemkin::AndroidBuilder do

  before do
    @builder = Potemkin::AndroidBuilder.new
    @builder.stubs(:config).returns(Potemkin::Configuration.new(:sdk_root => "/some/path", :android_project_dir => "dir", :build_type => "debug"))
  end

  # TODO: This test fails every other time
  it "should run the build command with the android home set" do
    proc = Proc.new { ENV["ANDROID_HOME"] }
    Potemkin.expects(:run).returns(proc.call)
    home = @builder.build
    assert_equal "/some/path", home
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
    @builder_without_dir = Potemkin::AndroidBuilder.new
    @builder_without_dir.stubs(:config).returns(Potemkin::Configuration.new(:sdk_root => "/some/path", :build_type => "debug"))
    builder_error = @builder_without_dir.build rescue "RESCUED"
    assert_equal "RESCUED", builder_error

  end




end
