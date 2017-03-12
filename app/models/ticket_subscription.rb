class TicketSubscription < ApplicationRecord
  belongs_to :ticket
  belongs_to :user

  validates :quantity,
    presence: true,
    numericality: {
      only_integer: true,
      greater_than_or_equal_to: 1
    }
end
