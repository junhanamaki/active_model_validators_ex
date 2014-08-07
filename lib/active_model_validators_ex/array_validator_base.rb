class ArrayValidatorBase < ActiveModel::EachValidator
  def initialize(options)
    options[:allow_nil]   ||= false
    options[:allow_empty] ||= false

    super(options)
  end

  def validate_each(record, attribute, value)
    return if options[:allow_nil] && value.nil?

    unless value.is_a? Array
      record.errors[attribute] << "attribute #{attribute} must be an Array"
      return
    end

    if !options[:allow_empty] and value.empty?
      record.errors[attribute] << "attribute #{attribute} can't be empty"
      return
    end

    custom_validations(record, attribute, value)
  end

  def custom_validations(record, attribute, value)
    unless self.instance_of? ArrayValidatorBase
      raise 'override this method to perform custom validations'
    end
  end
end