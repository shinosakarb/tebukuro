class EventSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :quota, :registered,
    :event_starts_at, :event_ends_at

  has_many :participants

  def registered
    object.user_registered?(current_user)
  end

  # TODO: communitiesモデルが作成されたら、GETのURLをattributesに加えます。
end
