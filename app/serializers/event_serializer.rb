class EventSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :quota,
             :event_starts_at, :event_ends_at, :within_deadline

  has_one :user_participation
  has_many :participants

  def user_participation
    UserParticipant.new(event: object, current_user: current_user)
  end

  def within_deadline
    object.within_deadline?
  end

  # TODO: communitiesモデルが作成されたら、GETのURLをattributesに加えます。
end
