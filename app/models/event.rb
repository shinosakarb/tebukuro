# frozen_string_literal: true

class Event < ApplicationRecord
  has_many :participants, ->{ order :id }
  has_many :tickets

  validates :name, presence: true
  validates :quota,
            presence: true,
            numericality:
            { greater_than_or_equal_to: 1,
              less_than_or_equal_to: 1000 }

  def admitted_participant?(participant_id)
    admitted_participants.include?(participant_id)
  end

  private

  def admitted_participants
    @admitted_participants ||= participant_ids.sort.take(quota)
  end
end
