class DatetimeLessValidator < ActiveModel::EachValidator
  CHECKS = {
    less_than_or_equal_to:    :<=,
    greater_than_or_equal_to: :>=
  }.freeze

  def validate_each(record, attribute, value)
    unless is_datetime?(value)
      record.errors.add(attribute, :not_a_datetime)
      return
    end

    options.slice(*CHECKS.keys).each do |option, option_value|
      target_datetime  = record.send(option_value)
      error_option = {
        target_attr_name: record.class.human_attribute_name(option_value)
      }

      if target_datetime.blank?
        record.errors.add(attribute, :datetime_target_blank, error_option)
        next
      end

      unless value.send(CHECKS[option], target_datetime)
        record.errors.add(attribute, :"datetime_#{option.to_s}", error_option)
      end
    end
  end

  private

  def is_datetime?(value)
    DateTime.parse(value.to_s)
    true
  rescue ArgumentError, TypeError
    false
  end
end

module ActiveModel::Validations::HelperMethods
  def validates_datetime_less_of(*attr_names)
    validates_with DatetimeLessValidator, _merge_attributes(attr_names)
  end
end
