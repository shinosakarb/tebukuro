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

  def waitlisted_participant_ids
    @waitlisted_participant_ids ||= get_waitlisted_participant_ids
  end

  def user_registered?(user)
    user ? participants.map(&:user_id).include?(user.id) : false
  end

  private

  def get_waitlisted_participant_ids
    quota ? participant_ids.sort.drop(quota) : []
  end
end
