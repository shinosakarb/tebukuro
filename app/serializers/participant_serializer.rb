# frozen_string_literal: true

class ParticipantSerializer < ActiveModel::Serializer
  attributes :id, :event_id, :name, :on_waiting_list

  def on_waiting_list
    object.waitlisted?
  end
end
