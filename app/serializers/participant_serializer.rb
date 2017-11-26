class ParticipantSerializer < ActiveModel::Serializer
  attributes :id, :event_id, :name
  has_one :event
end
