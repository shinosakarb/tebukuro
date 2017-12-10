# frozen_string_literal: true

class ParticipantsController < ApplicationController
  # POST /participants
  def create
    @participant = Participant.new(participant_params)

    if @participant.save
      render json: @participant, status: :created
    else
      render json: @participant.errors, status: :unprocessable_entity
    end
  end

  private

  # Only allow a trusted parameter "white list" through.
  def participant_params
    params.require(:participant).permit(:name, :event_id)
  end
end
