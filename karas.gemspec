# -*- encoding: utf-8 -*-
require File.expand_path('../lib/karas/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Josef Šimánek"]
  gem.email         = ["retro@ballgag.cz"]
  gem.description   = %q{PHP in Ruby}
  gem.summary       = %q{Just a stupid relax project}
  gem.homepage      = ""
  gem.extensions    = ["ext/karas/extconf.rb"]

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "karas"
  gem.require_paths = ["lib"]
  gem.version       = Karas::VERSION

  gem.add_development_dependency "rake-compiler"
end
