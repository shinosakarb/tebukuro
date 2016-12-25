class EventSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :community_id,
             :invitation_starts_at, :invitation_ends_at,
             :event_starts_at, :event_ends_at

  # TODO: communitiesモデルが作成されたら、GETのURLをattributesに加えます。

end
