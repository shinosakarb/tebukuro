# frozen_string_literal: true

class ParticipantsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]
  before_action :set_participant, only: [:destroy]
  before_action :build_participant, only: [:create]

  # POST /participants
  def create
    if @participant.save
      render json: @participant, status: :created
    else
      render json: @participant.errors, status: :unprocessable_entity
    end
  end

  # DELETE /participants
  def destroy
    if @participant.destroy
      render json: @participant
    else
      render json: @participant.errors, status: :unprocessable_entity
    end
  end

  private

  # Only allow a trusted parameter "white list" through.
  def participant_params
    params.require(:participant).permit(:name, :event_id)
  end

  def set_participant
    @participant = Participant.find(params[:id])
    authorize @participant
  end

  def build_participant
    @participant = Participant.new(participant_params)
    @participant.user_id = current_user.id
  end
end
