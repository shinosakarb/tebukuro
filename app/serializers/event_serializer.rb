class EventSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :community_id
end
