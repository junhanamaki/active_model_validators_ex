require 'simplecov'
SimpleCov.start do
  coverage_dir 'tmp/coverage'
end

require 'factory_girl'
require 'pry'
require 'active_model_validators_ex'