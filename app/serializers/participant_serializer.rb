class ParticipantSerializer < ActiveModel::Serializer
  attributes :id, :event_id, :name, :admitted
end
