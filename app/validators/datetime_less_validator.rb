class DatetimeLessValidator < ActiveModel::EachValidator
  CHECKS = {
    before: :<=,
    after:  :>=
  }

  ERRORS = {
    before: :before_datetime,
    after:  :after_datetime
  }

  def initialize(options)
    super
    @option_key = option_keys.first
    @comparison_attr = options[@option_key]
  end

  def check_validity!
    raise ArgumentError, 'Requires :before or :after option'      if !required_option_exist?
    raise ArgumentError, 'Duplicate option of :before and :after' if duplicate_option?
  end

  def validate_each(record, attribute, value)
    target_datetime  = record.send(@comparison_attr)
    target_attr_name = record.class.human_attribute_name(@comparison_attr)

    if target_datetime.blank?
      error   = :target_blank
      message = "#{target_attr_name} can't be blank"
    else
      unless value.send(CHECKS[@option_key], target_datetime)
        error   = ERRORS[@option_key]
        message = "must be #{@option_key.to_s} #{target_attr_name}"
      end
    end

    record.errors.add(
      attribute, 
      error,
      target_attr: target_attr_name,
      message:     message
    ) if error.present?
  end

  private

  def option_keys
    CHECKS.keys & options.keys
  end

  def required_option_exist?
    option_keys.present?
  end

  def duplicate_option?
    options.key?(:before) && options.key?(:after)
  end
end

module ActiveModel::Validations::HelperMethods
  def validates_datetime_less_of(*attr_names)
    validates_with DatetimeLessValidator, _merge_attributes(attr_names)
  end
end
