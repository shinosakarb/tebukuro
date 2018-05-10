# frozen_string_literal: true

class Participant < ApplicationRecord
  belongs_to :user
  belongs_to :event

  validate :cannot_join

  def cannot_join
    unless event.within_deadline?
      errors.add(:event_id, :cannot_join)
    end
  end

  def name
    user.name
  end

  def waitlisted?
    event.waitlisted_participant_ids.include?(id)
  end
end
