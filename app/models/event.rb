class Event < ApplicationRecord
  belongs_to :community
  has_many :tickets
  has_many :participants

  validates :name, presence: true
end
