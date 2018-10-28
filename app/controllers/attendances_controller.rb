# frozen_string_literal: true

class AttendancesController < ApplicationController
  before_action :authenticate_user!, only: %i[update]
  before_action :build_attendance, only: %i[update]

  # PATCH /participants/:id/attendances
  def update
    authorize @attendance, :update?
    @attendance.update
    render json: @attendance.event
  end

  private

  def build_attendance
    @attendance = Attendance.new(participant: participant)
  end

  def participant
    Participant.find(params[:id])
  end
end
