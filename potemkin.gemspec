# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'potemkin/version'

Gem::Specification.new do |gem|
  gem.name          = "potemkin"
  gem.version       = Potemkin::VERSION
  gem.authors       = ["Bob Van Landuyt", "Piet Jaspers"]
  gem.email         = ["bob.vanlanduyt@gmail.com"]
  gem.description   = "A gem to automate builds & deploys for Android, iOS and web apps"
  gem.summary       = "A gem to automate builds & deploys for Android, iOS and web apps"
  gem.homepage      = ""
  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
  gem.add_dependency "rugged", "0.17.0.b7"
  gem.add_dependency 'thor', '~> 0.16.0'
end
