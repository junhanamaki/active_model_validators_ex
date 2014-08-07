require 'active_model_validators_ex/array_validator_base'

class ArrayInclusionValidator < ArrayValidatorBase
  def initialize(options)
    unless options.key?(:in) &&
           (options[:in].is_a?(Array) ||
            options[:in].is_a?(Range))
      raise 'ket in must be present, and value must be either a Range or Array'
    end

    super(options)
  end

  def custom_validations(record, attribute, value)
    unless value.all? { |val| options[:in].include?(val) }
      record.errors[attribute] <<
        "attribute #{attribute} has be an array composed of values " \
        " #{options[:in]}"
    end
  end
end