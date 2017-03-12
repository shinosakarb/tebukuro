class TicketSubscriptionSerializer < ActiveModel::Serializer
  attributes :id, :quantity
  belongs_to :ticket
end
