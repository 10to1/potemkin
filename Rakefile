require "bundler/gem_tasks"

#!/usr/bin/env rake
require "bundler/gem_tasks"
require 'rake/testtask'

desc 'Run Devise unit tests.'
Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.libs << 'test'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
end

task :default => :test

desc "Open an pry session with Potemkin loaded"
task :console do
  sh "pry -I lib -r potemkin.rb"
end
