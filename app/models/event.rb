class Event < ApplicationRecord
  belongs_to :community
  
  validates :name, presence: true
  validates :description, presence: true
end
