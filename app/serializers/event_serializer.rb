class EventSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :community_id

  # TODO: communitiesモデルが作成されたら、GETのURLをattributesに加えます。

end
