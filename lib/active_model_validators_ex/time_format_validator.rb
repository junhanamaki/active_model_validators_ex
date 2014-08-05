class TimeFormatValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if options[:allow_nil] && value.nil?

    parsed_time = Time.parse value.to_s

    previous_time = \
      case options[:after].class
      when Proc
        options[:after].call
      when DateTime
        options[:after]
      when Time
        options[:after]
      end

    unless previous_time.nil? or parsed_time > previous_time
      record.errors[attribute] << "invalid value, #{value} must be after #{previous_time}"
    end
  rescue StandardError => e
    record.errors[attribute] << "invalid value, #{value} not valid for #{attribute}"
  end
end