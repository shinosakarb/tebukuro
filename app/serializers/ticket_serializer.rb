class TicketSerializer < ActiveModel::Serializer
  attributes :id, :name, :cost, :quantity, :event_id,
             :sale_starts_at, :sale_ends_at, :purchased
end
