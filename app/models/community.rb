class Community < ApplicationRecord
  has_many :events
  has_many :tickets, through: :event

  validates :name, presence: true
  validates :description, presence: true
  
end
