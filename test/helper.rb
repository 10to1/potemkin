# coding: utf-8

require "minitest/autorun"
require 'mocha/setup'

begin
  # [turn](http://rubygems.org/gems/turn)
  require 'turn/autorun'
rescue LoadError
end

$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'potemkin'

class MiniTest::Spec
  before do
    Potemkin::Logger.any_instance.stubs(:log)
    Potemkin::Android::Manifest.any_instance.stubs(:save!)
  end
end
FAKE_ANDROID_PROJECT = "fake_project"
FAKE_ANDROID_PROJECT_DIR = "#{File.dirname(__FILE__)}/fakes/android/#{FAKE_ANDROID_PROJECT}"
