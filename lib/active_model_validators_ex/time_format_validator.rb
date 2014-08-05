class TimeFormatValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if options[:allow_nil] && value.nil?

    parsed_time = Time.parse value.to_s

    unless options[:after].nil?
      previous_time = options[:after].call

      if parsed_time < previous_time
        record.errors[attribute] << "invalid value, #{value} must be after #{previous_time}"
      end
    end
  rescue StandardError => e
    record.errors[attribute] << "invalid value, #{value} not valid for #{attribute}"
  end
end