# frozen_string_literal: true

class AttendancesController < ApplicationController
  before_action :authenticate_user!, only: %i[update]
  before_action :set_participant, only: %i[update]

  # PATCH /participants/:id/attendances
  def update
    authorize @participant, :toggle_status?
    @participant.toggle_status
    render json: participated_event
  end

  private

  def participated_event
    Event.find(params[:id])
  end

  def set_participant
    @participant = Participant.find(params[:id])
  end
end
