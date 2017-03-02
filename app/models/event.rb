class Event < ApplicationRecord
  belongs_to :community
  has_many :tickets

  validates :name, presence: true
  validates :description, presence: true
  validates :event_starts_at, presence:true
  validates :event_ends_at, presence:true
  validates :address, length: { maximum: 255 }
end
