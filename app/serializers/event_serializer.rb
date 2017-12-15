class EventSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :quota

  has_many :participants

  # TODO: communitiesモデルが作成されたら、GETのURLをattributesに加えます。
end
