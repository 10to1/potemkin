require "helper"
describe Potemkin::Builder do

  before do
    @builder = Potemkin::Builder.new
    @builder.stubs(:config).returns(Potemkin::Configuration.new(:sdk_root => "/some/path", :android_project_dir => "dir", :build_type => "debug"))
    end

  it "should run a build command" do
    command = <<-command
  ANDROID_HOME=/some/path &&
export ANDROID_HOME &&
ant -f dir/build.xml clean &&
ant -f dir/build.xml debug
command

    Potemkin.expects(:run).with(command).once
    @builder.build
  end



end
