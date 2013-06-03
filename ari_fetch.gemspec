# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ari_fetch/version'

Gem::Specification.new do |gem|
  gem.name          = "ari_fetch"
  gem.version       = AriFetch::VERSION
  gem.authors       = ["keviv vivek"]
  gem.email         = ["vivek@devbrother.com"]
  gem.description   = "ARI"
  gem.summary       = "ARI"
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency "activesupport" , "~> 3.0.7"
  gem.add_dependency "rails"         , "~> 3.0.7"

end
