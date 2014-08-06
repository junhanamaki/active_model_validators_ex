# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'active_model_validators_ex/version'

Gem::Specification.new do |spec|
  spec.name          = "active_model_validators_ex"
  spec.version       = ActiveModelValidatorsEx::VERSION
  spec.authors       = ["junhanamaki"]
  spec.email         = ["jun.hanamaki@gmail.com"]
  spec.summary       = %q{Some custom validators for ActiveModel}
  spec.description   = %q{Extend ActiveModel with more validators for your
                          models.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency 'bundler', '~> 1.6'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'simplecov', '~> 0.9'
  spec.add_development_dependency 'jazz_hands', '~> 0.5'
  spec.add_development_dependency 'activemodel', '~> 4.1'
end
