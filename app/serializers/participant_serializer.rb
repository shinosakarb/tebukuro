# frozen_string_literal: true

class ParticipantSerializer < ActiveModel::Serializer
  attributes :id, :event_id, :name, :on_waiting_list, :checked_in

  def on_waiting_list
    object.waitlisted?
  end

  def checked_in
    object.checked_in?
  end
end
