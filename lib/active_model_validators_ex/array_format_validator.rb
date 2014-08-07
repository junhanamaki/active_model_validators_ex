require 'active_model_validators_ex/array_validator_base'

class ArrayFormatValidator < ArrayValidatorBase
  def initialize(options)
    unless options.key?(:with) && options[:with].is_a?(Regexp)
      raise 'key with must be present, and value must be a Regexp'
    end

    super(options)
  end

  def custom_validations(record, attribute, value)
    unless value.all? { |val| !val.match(options[:with]).nil? }
      record.errors[attribute] <<
        "attribute #{attribute} must be an Array with values that matches " \
        "#{options[:with]}"
    end
  end
end