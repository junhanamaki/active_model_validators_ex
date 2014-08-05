# ActiveModelValidatorsEx

A lib of custom validators for ActiveModel.

## Installation

Add this line to your application's Gemfile:

    gem 'active_model_validators_ex'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install active_model_validators_ex

## Usage

After requiring, the following classes will be available for ActiveModel
validations:

  * ArrayInclusionValidator

   Allow you to validate if values in an array is included in a specified range
   (meaning the value itself has to be an Array). As an example:

        class ExampleModel
          include Mongoid::Document

          field :array

          validates :array, array_inclusion: {
              # the collection of valid values for array elements
              in: [0, 1, 2], # it could also be written as a range: 0..2

              # can be either true or false, indicates if nil is accepted
              # defaults to false
              allow_nil: true
            }
        end

        # returns true
        ExampleModel.new(array: [1, 2, 1]).valid?

        # returns false
        ExampleModel.new(array: [1, 2, 5]).valid?

  * TimeFormatValidator

   Allow you to check if given value is parsable to time, example:

        class ExampleModel < ActiveRecord::Base
          attr_accessible :time

          validates :time, time_format: {
              # value can be either a lambda or a time, and indicates that
              # attribute value must be after this value
              after: lambda { Time.new(2014) },

              # can be either true or false, indicates if nil is accepted
              # defaults to false
              allow_nil: true
            }
        end

        # returns true
        ExampleModel.new(time: Time.new(2015)).valid?

        # returns false
        ExampleModel.new(time: Time.new(2013)).valid?

## Contributing

1. Fork it ( https://github.com/junhanamaki/active_model_validators_ex/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
