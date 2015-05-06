# -*- encoding: utf-8 -*-
require File.expand_path('../lib/json-schema-rspec/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Sharethrough Engineering", "Michael Jensen"]
  gem.email         = ["engineers@sharethrough.com", "emjay1988@gmail.com"]
  gem.description   = %q{Adds RSpec matchers for validating JSON schemas}
  gem.summary       = %q{JSON Schema RSpec matchers}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "json-schema-rspec"
  gem.require_paths = ["lib"]
  gem.version       = Json::Schema::Rspec::VERSION
  gem.add_dependency "rspec"
  gem.add_dependency "json-schema", "~> 2.5"
end
