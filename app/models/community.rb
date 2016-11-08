class Community < ApplicationRecord
  has_many :events

  validates :name, presence: true
  validates :description, presence: true

end
