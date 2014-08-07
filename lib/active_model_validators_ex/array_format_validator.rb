class ArrayInclusionValidator < ActiveModel::EachValidator
  def initialize(options)
    unless options.key?(:with) && options[:with].is_a?(Regexp)
      raise 'key with must be present, and value must be a Regexp'
    end

    super(options)
  end

  def validate_each(record, attribute, value)
    return if options[:allow_nil] && value.nil?

    unless value.is_a? Array
      record.errors[attribute] << "attribute #{attribute} must be an Array"
      return
    end

    if options[:allow_empty] == false and value.empty?
      record.errors[attribute] << "attribute #{attribute} can't be empty"
      return
    end

    unless value.all? { |val| val.match(options[:with]) }
      record.errors[attribute] <<
        "attribute #{attribute} has be an array that matches #{options[:with]}"
      return
    end
  end
end