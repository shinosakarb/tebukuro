class DateTimeDiffValidator < ActiveModel::EachValidator
  def validate(record)
    start_endtime = record.send(options[:start_attr])
    end_datetime  = record.send(options[:end_attr])

    if (end_datetime - start_endtime).to_i < 0
      record.errors.add(:base, 'error!')
    end
  rescue => e
  end
end
