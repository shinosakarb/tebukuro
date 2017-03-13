class Ticket < ApplicationRecord
  # TODO: Delete the "#" after the user model is added.
  #belongs_to :event #through :user
  belongs_to :event
  has_one :community, through: :event
  has_many :ticket_subscriptions
  has_many :users, through: :ticket_subscriptions

  validates :name, presence: true
  validates :cost, presence: true,
                   numericality: { greater_than_or_equal_to: 0 }
  validates :quantity, presence: true,
                       numericality: { greater_than_or_equal_to: 1 }
  validates :sale_starts_at, presence: true
  validates :sale_ends_at, presence: true
 end
