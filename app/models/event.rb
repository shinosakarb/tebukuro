class Event < ApplicationRecord
  belongs_to :community

  validates :name, presence: true
  validates :description, presence: true
  validates :invitation_starts_at, presence:true
  validates :invitation_ends_at, presence:true
  validates :event_starts_at, presence:true
  validates :event_ends_at, presence:true

end
