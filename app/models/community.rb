class Community < ApplicationRecord
  has_many :owners
  has_many :events
  has_many :tickets, through: :events

  validates :name, presence: true
  validates :description, presence: true

  def self.new_with_owners(attributes = nil)
    self.new(attributes&.except(:owners)) do |c|
      c.owners.build(attributes.try!(:[], :owners))
    end
  end
end
