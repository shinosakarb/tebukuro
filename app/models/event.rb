class Event < ApplicationRecord
  belongs_to :community

  validates :name, presence: true
  validates :description, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true

  validate :start_is_after_created
  validate :start_is_before_end

  private
  def start_is_after_created
    return unless start_time

    if start_time < Time.now
      errors.add(:start_time, 'はもう過ぎてしまっています')
    end
  end

  def start_is_before_end
    return unless start_time && end_time

    if start_time >= end_time
      errors.add(:start_time, 'は終了時間よりも前に設定してください')
    end
  end

end
