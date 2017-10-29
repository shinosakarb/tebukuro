class Event < ApplicationRecord
  belongs_to :community
  has_many :tickets

  validates :name, presence: true
end
