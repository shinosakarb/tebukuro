class Event < ApplicationRecord
  belongs_to :community

  validates :name, presence: true
  validates :description, presence: true
  validates :started_at, presence: true
  validates :ended_at, presence: true

  validates_with DateValidator, if: (:started_at && :ended_at)
end
