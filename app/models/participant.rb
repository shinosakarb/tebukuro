# frozen_string_literal: true

class Participant < ApplicationRecord
  belongs_to :user
  belongs_to :event

  def name
    user.name
  end

  def waitlisted?
    event.waitlisted_participant_ids.include?(id)
  end
end
