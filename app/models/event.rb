# frozen_string_literal: true

class Event < ApplicationRecord
  has_many :participants
  has_many :tickets

  validates :name, presence: true
  validates :quota,
            presence: true,
            numericality:
            { greater_than_or_equal_to: 1,
              less_than_or_equal_to: 1000 }

  validates :event_starts_at, presence: true
  validates :event_ends_at, presence: true
  validate :start_after_end?, if: %i[event_starts_at? event_ends_at?]

  def waitlisted_participant_ids
    @waitlisted_participant_ids ||= get_waitlisted_participant_ids
  end

  def user_registered?(user)
    user ? participants.map(&:user_id).include?(user.id) : false
  end

  def within_deadline?
    Time.current < event_starts_at
  end

  private

  def get_waitlisted_participant_ids
    quota ? participant_ids.sort.drop(quota) : []
  end

  def start_after_end?
    if event_ends_at <= event_starts_at
      errors.add(:event_starts_at, :exceeds_end_time)
    end
  end
end
