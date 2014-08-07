class ArrayInclusionValidator < ActiveModel::EachValidator
  def initialize(options)
    unless options.key?(:in) &&
           (options[:in].is_a?(Array) ||
            options[:in].is_a?(Range))
      raise 'ket in must be present, and value must be either a Range or Array'
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

    unless value.all? { |val| options[:in].include?(val) }
      record.errors[attribute] <<
        "attribute #{attribute} has be an array composed of values " \
        " #{options[:in]}"
      return
    end
  end
end