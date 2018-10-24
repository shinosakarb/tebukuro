# frozen_string_literal: true

class Participant < ApplicationRecord
  belongs_to :user
  belongs_to :event

  validate :cannot_join, on: :create
  validate :registered, on: :create

  enum status: %i[not_checked_in checked_in]

  def cannot_join
    unless event.within_deadline?
      errors.add(:event_id, :cannot_join)
    end
  end

  def registered
    if event.user_registered?(user)
      errors.add(:event_id, :registered)
    end
  end

  def name
    user.name
  end

  def waitlisted?
    event.waitlisted_participant_ids.include?(id)
  end

  def toggle_status
    checked_in? ? not_checked_in! : checked_in!
  end
end
