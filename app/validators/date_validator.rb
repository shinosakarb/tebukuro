class DateValidator < ActiveModel::Validator
  def validate(record)
    if record.started_at < Time.zone.now
      record.errors[:started_at] << "はもう過ぎてしまっています"
    end

    if record.started_at > record.ended_at
      record.errors[:started_at] << "は終了時間より前に設定してください"
    end
  end
end