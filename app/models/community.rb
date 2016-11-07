class Community < ApplicationRecord
  has_many :event

  validates :name, presence: true
  validates :description, presence: true

end
