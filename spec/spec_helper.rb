require 'simplecov'
SimpleCov.start do
  coverage_dir 'tmp/coverage'
end

require 'active_model'
require 'active_model_validators_ex'
require 'pry'
require 'mock_objects/mock_record'