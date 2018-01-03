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
end
