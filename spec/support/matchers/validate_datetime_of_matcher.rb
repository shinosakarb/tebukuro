# frozen_string_literal: true

RSpec::Matchers.define :validate_datetime_less_of do |attribute|
  match do |model|
    @attribute = attribute
    @model = model

    return false unless @attribute && @target

    @model[@attribute] = Time.zone.now

    less_or_greater_valid? && equal_valid?
  end

  chain :is_less_than_or_equal_to do |target|
    @target = target
    @less = true
    @equal = true
  end

  chain :is_greater_than_or_equal_to do |target|
    @target = target
    @less = false
    @equal = true
  end

  def less_or_greater_valid?
    @model[@target] =
      @less ? Time.zone.tomorrow : Time.zone.yesterday

    valid_attribute?
  end

  def equal_valid?
    @model[@target] = @model[@attribute]

    valid_attribute?
  end

  def valid_attribute?
    @model.valid?
    @model.errors[@attribute].blank?
  end
end
