class EventSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :quota, :event_starts_at, :event_ends_at

  has_one :user_participation
  has_many :participants

  def user_participation
    UserParticipant.new(event: object, current_user: current_user)
  end

  # TODO: communitiesモデルが作成されたら、GETのURLをattributesに加えます。
end
