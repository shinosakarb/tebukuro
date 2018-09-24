# frozen_string_literal: true

class RegistrationsController < ApplicationController
  before_action :authenticate_user!, only: %i[create destroy]
  before_action :build_participant, only: %i[create]
  before_action :set_participant, only: %i[destroy]

  # POST /events/:id/registrations
  def create
    if @participant.save
      render json: participated_event
    else
      render json: @participant.errors, status: :unprocessable_entity
    end
  end

  # DELETE /events/:id/registrations
  def destroy
    if @participant.destroy
      render json: participated_event
    else
      render json: @participant.errors, status: :unprocessable_entity
    end
  end

  private
  def build_participant
    @participant = Participant.new(event_id: params[:id], user_id: current_user.id)
  end

  def set_participant
    @participant =
      ParticipantPolicy::Scope.new(current_user, Participant).resolve(scope_query)
  end

  def participated_event
    Event.find(params[:id])
  end

  def scope_query
    { event_id: params[:id] }
  end
end
