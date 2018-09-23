# frozen_string_literal: true

class Participant < ApplicationRecord
  belongs_to :user
  belongs_to :event

  validate :cannot_join
  validate :registered

  def cannot_join
    unless event.within_deadline?
      errors.add(:event_id, :cannot_join)
    end
  end

  def registered
    if registered?(user)
      errors.add(:event_id, :registered)
    end
  end

  def name
    user.name
  end

  def waitlisted?
    event.waitlisted_participant_ids.include?(id)
  end

  private

  def registered?(user)
    UserParticipant.new(event: event, current_user: user).registered?
  end
end
