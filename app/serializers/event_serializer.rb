class EventSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :community_id, :start_time, :end_time

  # TODO: communitiesモデルが作成されたら、GETのURLをattributesに加えます。

end
