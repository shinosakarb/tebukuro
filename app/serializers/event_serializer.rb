class EventSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :quota, :registered

  has_many :participants

  def registered
    object.user_registered?(scope)
  end

  # TODO: communitiesモデルが作成されたら、GETのURLをattributesに加えます。
end
