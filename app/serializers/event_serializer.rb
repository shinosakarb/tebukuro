class EventSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :community_id, :started_at, :ended_at

  # TODO: communitiesモデルが作成されたら、GETのURLをattributesに加えます。

end
