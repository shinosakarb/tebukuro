class Event < ApplicationRecord
  belongs_to :community

  validates :name, presence: true
  validates :description, presence: true
  validates :started_at, presence: true
  validates :ended_at, presence: true

  validate :start_is_after_created
  validate :start_is_before_end

  private
  def start_is_after_created
    return unless started_at

    if started_at < Time.zone.now
      errors.add(:started_at, 'はもう過ぎてしまっています')
    end
  end

  def start_is_before_end
    return unless started_at && ended_at

    if started_at >= ended_at
      errors.add(:started_at, 'は終了時間よりも前に設定してください')
    end
  end

end
