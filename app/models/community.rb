class Community < ApplicationRecord
  has_many :owners
  has_many :events
  has_many :tickets, through: :events

  validates :name, presence: true
  validates :description, presence: true
  
end
