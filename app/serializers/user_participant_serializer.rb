class UserParticipantSerializer < ActiveModel::Serializer
  attributes :registered, :on_waiting_list

  def registered
    object.registered?
  end

  def on_waiting_list
    object.on_waiting_list?
  end
end
