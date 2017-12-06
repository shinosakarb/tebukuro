class Event < ApplicationRecord
  has_many :tickets
  has_many :participants

  validates :name, presence: true
end
