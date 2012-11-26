require "helper"
describe Potemkin::IosBuilder do

  before do
    @builder = Potemkin::IosBuilder.new
    @builder.stubs(:config).returns(Potemkin::Configuration.new(:target => "Butane", :configuration => "Release", "project_path" => "Butane/Butane.xcodeproj"))
    end

  it "should run a build command" do
    command = "/usr/bin/xcodebuild -target 'Butane' -configuration 'Release' -project 'Butane/Butane.xcodeproj'"

    Potemkin.expects(:run).with(command).once
    @builder.build
  end

  it "should run a clean command" do
    command = "/usr/bin/xcodebuild -target 'Butane' -configuration 'Release' -project 'Butane/Butane.xcodeproj' clean"

    Potemkin.expects(:run).with(command).once
    @builder.clean
  end


end
