class Community < ApplicationRecord
  has_many :events
  has_many :members

  validates :name, presence: true
  validates :description, presence: true
end
