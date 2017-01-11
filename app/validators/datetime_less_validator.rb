class DatetimeLessValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    before_datetime = record.send(options[:before])
    target_attr     = record.class.human_attribute_name options[:before]

    if before_datetime.blank?
      error   = :required_before_datetime
      message = "must not be nil #{target_attr}"
    elsif (before_datetime - value).to_i < 0
      error   = :less_than_datetime
      message = "must be before #{target_attr}"
    end

    record.errors.add(
      attribute, error,
      target_attr: target_attr,
      message:     message
    ) if error.present?
  end
end

module ActiveModel::Validations::HelperMethods
  def validates_datetime_less_of(*attr_names)
    validates_with DatetimeLessValidator, _merge_attributes(attr_names)
  end
end
