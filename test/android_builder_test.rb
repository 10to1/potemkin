require "helper"
describe Potemkin::Android::Builder do

  before do
    @builder = Potemkin::Android::Builder.new
    @builder.stubs(:config).returns(Potemkin::Configuration.new(:sdk_root => "/some/path", :project_path => FAKE_ANDROID_PROJECT_DIR, :platform => :android))
  end

  it "Should use the current path when it is not set" do
    @builder_without_dir = Potemkin::Android::Builder.new
    @builder_without_dir.stubs(:config).returns(Potemkin::Configuration.new(:sdk_root => "/some/path", :build_type => "debug"))
    assert_equal "#{Dir.pwd}/build.xml", @builder_without_dir.build_file
  end

  it "should run the build command with the android home set" do
    @builder.expects(:with_env_vars).with("ANDROID_HOME" => "/some/path").once
    @builder.build
  end

  describe "building" do

    it "should run a build command" do
      command = "ant -f #{FAKE_ANDROID_PROJECT_DIR}/build.xml debug"
      Potemkin.expects(:run).with(command).once
      @builder.build
    end

    it "should run a clean command" do
      command = "ant -f #{FAKE_ANDROID_PROJECT_DIR}/build.xml clean"
      Potemkin.expects(:run).with(command).once
      @builder.clean
    end

  end

  describe "packaging" do
    [:clean, :sign, :align].each do |type|
      it "should run the #{type} command" do
        @builder.expects("#{type}_command")
        @builder.package_command
      end
    end

    it "should run the build release command" do
      @builder.stubs(:clean_command)
      @builder.expects(:build_command).with("release")
      @builder.package_command
    end

    it "should copy the release build for signing" do
      @builder.stubs(:unsigned_build).returns("a")
      @builder.stubs(:signed_build).returns("b")
      @builder.expects(:prepare_apk_command).with("a", "b")
      @builder.package_command
    end

    it "should set the build type to release" do
      @builder.package_command
      assert_equal "release", @builder.build_type
    end

    it("should be able to copy a signed build") { assert_equal "cp a b", @builder.prepare_apk_command("a", "b")}

    it("should be able to sign a build") do
      @builder.expects(:release_keystore).returns("keystore").twice
      @builder.expects(:keystore_password).returns("pass").twice
      @builder.expects(:keystore_alias).returns("alias").twice
      @builder.expects(:key_algorithm).returns("MD5withRSA")
      @builder.expects(:digest_algorithm).returns("SHA1")
      @builder.expects(:signed_build).returns("some.apk")
      command = "jarsigner -sigalg MD5withRSA -digestalg SHA1 -keystore keystore -storepass pass some.apk alias"
      assert_equal command, @builder.sign_command

    end
  end
end
