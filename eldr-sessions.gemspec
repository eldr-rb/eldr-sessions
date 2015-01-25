# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'eldr/sessions/version'

Gem::Specification.new do |spec|
  spec.name          = 'eldr-sessions'
  spec.version       = Eldr::Sessions::VERSION
  spec.authors       = ['K-2052']
  spec.email         = ['k@2052.me']
  spec.summary       = %q{Session helpers for the Eldr ruby framework.}
  spec.description   = %q{Session helpers for the Eldr ruby framework.}
  spec.homepage      = 'https://github.com/eldr-rb/eldr-sessions'
  spec.license       = 'MIT'

  spec.required_rubygems_version = '~> 2.0'
  spec.required_ruby_version     = '>= 2.0'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'eldr', '~> 0.0'

  spec.add_development_dependency 'bundler',      '~> 1.7'
  spec.add_development_dependency 'rake',         '10.4.2'
  spec.add_development_dependency 'rspec',        '3.1.0'
  spec.add_development_dependency 'rubocop',      '0.28.0'
  spec.add_development_dependency 'rack-test',    '~> 0.6'
  spec.add_development_dependency 'coveralls',    '~> 0.7'
  spec.add_development_dependency 'bson_ext',     '1.11.1'
  spec.add_development_dependency 'mongo_mapper', '0.13.1'
end
