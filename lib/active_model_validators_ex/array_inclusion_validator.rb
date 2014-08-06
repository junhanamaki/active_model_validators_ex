class ArrayInclusionValidator < ActiveModel::EachValidator
  def initialize(options)
    unless options.key?(:in) &&
           (options[:in].is_a?(Array) ||
            options[:in].is_a?(Range))
      raise 'key :in can not be nil, and value must be either an Array or Range'
    end

    super(options)
  end

  def validate_each(record, attribute, value)
    return if value.nil? and options[:allow_nil]

    unless value.is_a? Array
      record.errors[attribute] <<
        "expecting either Array or nil for attribute #{attribute}"
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