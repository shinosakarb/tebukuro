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

  def admitted_participant_ids
    @admitted_participant_ids ||= take_admitted_participant_ids
  end

  private

  def take_admitted_participant_ids
    quota ? participant_ids.sort.take(quota) : []
  end
end
