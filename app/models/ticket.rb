class Ticket < ApplicationRecord
  belongs_to :event #through :user

  validates :name, presence: true
  validates :cost, presence: true,
                   numericality: { greater_than_or_equal_to: 0 }
  validates :quantity, presence: true,
                       numericality: { greater_than_or_equal_to: 1 }
  validates :sale_starts_at, presence: true
  validates :sale_ends_at, presence: true
 end
