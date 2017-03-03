class Event < ApplicationRecord
  belongs_to :community
  has_many :tickets

  validates :name, presence: true
  validates :description, presence: true
  validates :event_starts_at, presence:true
  validates :address, presence: true, length: { maximum: 255 }
end
