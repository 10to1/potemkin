# coding: utf-8

require "minitest/autorun"
require 'mocha/setup'
require "android_helper"

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
  end
end
