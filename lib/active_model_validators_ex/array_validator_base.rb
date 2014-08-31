class ArrayValidatorBase < ActiveModel::EachValidator
  def initialize(options)
    options[:allow_nil]   ||= false
    options[:allow_empty] ||= false

    super(options)
  end

  def validate_each(record, attribute, value)
    return if options[:allow_nil] && value.nil?

    unless value.is_a? Array
      record.errors.add(attribute, :array, options)
      return
    end

    if !options[:allow_empty] and value.empty?
      record.errors.add(attribute, :empty, options)
      return
    end

    custom_validations(record, attribute, value)
  end

  def custom_validations(record, attribute, value)
    raise 'override this method to perform custom validations'
  end
end