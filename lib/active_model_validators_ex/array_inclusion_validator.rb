class ArrayInclusionValidator < ActiveModel::EachValidator
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