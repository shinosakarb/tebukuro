# frozen_string_literal: true

class Participant < ApplicationRecord
  belongs_to :user
  belongs_to :event

  validates :name, presence: true

  def waitlisted?
    event.waitlisted_participant_ids.include?(id)
  end
end
