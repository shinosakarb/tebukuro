class RegistrationsController < ApplicationController
  before_action :authenticate_user!, only: [:destroy]
  before_action :set_participant, only: [:destroy]

  # DELETE /events/:id/registrations
  def destroy
    if @participant.destroy
      render json: @participant.event
    else
      render json: @participant.errors, status: :unprocessable_entity
    end
  end

  private

  def set_participant
    @participant =
      Participant.find_by(event_id: params[:event_id], user_id: current_user.id)
    authorize @participant
  end
end
