class EventSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :quota,
    :event_starts_at, :event_ends_at, :user_participation

  has_many :participants

  def user_participation
    user_participant =
      UserParticipant.new(event: object, current_user: current_user)
    UserParticipantSerializer.new(user_participant).attributes
  end

  # TODO: communitiesモデルが作成されたら、GETのURLをattributesに加えます。
end
