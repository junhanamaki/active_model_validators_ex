class TimeFormatValidator < ActiveModel::EachValidator
  def initialize(options)
    options[:allow_nil] ||= false

    super(options)
  end

  def validate_each(record, attribute, value)
    return if options[:allow_nil] && value.nil?

    parsed_time = value.is_a?(Time) ? value : Time.parse(value.to_s)

    if !previous_time.nil? and parsed_time < previous_time
      record.errors[attribute] << "invalid value, #{value} must be after #{previous_time}"
    end
  rescue StandardError => e
    record.errors[attribute] << "invalid value, #{value} not valid for #{attribute}"
  end

  def previous_time
    case options[:after].class.name
    when 'Proc'
      options[:after].call
    when 'Time'
      options[:after]
    end
  end
end