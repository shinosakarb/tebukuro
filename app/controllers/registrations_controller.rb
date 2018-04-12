# frozen_string_literal: true

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
      policy_scope(Participant).where(event_id: params[:event_id]).first
  end
end
