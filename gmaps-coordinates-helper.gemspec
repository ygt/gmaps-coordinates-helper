# -*- encoding: utf-8 -*-
require File.expand_path('../lib/gmaps-coordinates-helper/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Stephen Lewis"]
  gem.email         = ["stephenl@yourgolftravel.com"]
  gem.description   = %q{Google Maps coordinate calculator}
  gem.summary       = %q{Simple helper functions for lat/lng, world and tile coordinate calculations}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "gmaps-coordinates-helper"
  gem.require_paths = ["lib"]
  gem.version       = GmapsCoordinatesHelper::VERSION

  gem.add_development_dependency "rspec"  
end
