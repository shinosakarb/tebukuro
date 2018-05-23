class EventsController < ApplicationController

  before_action :set_event, only: [:show, :update, :destroy]
  before_action :build_event, only: [:create]

  def index
    @events = Event.all
    render json: @events
  end

  def create
    if @event.save
      render json: @event, status: :created, location: @event
    else
      render json: @event.errors, status: :unprocessable_entity
    end
  end

  def show
    render json: @event, include: 'participants'
  end

  def update
    if @event.update(event_params)
      render json: @event, include: 'participants'
    else
      render json: @event.errors, status: :unprocessable_entity
    end
  end

  def destroy
    if @event.destroy
      render json: @event
    else
      render json: @event.errors, status: :unprocessable_entity
    end
  end

  private

  def event_params
    params
      .require(:event)
      .permit(:name, :description, :quota, :event_starts_at, :event_ends_at)
  end

  def set_event
    @event = Event.find(params[:id])
  end

  def build_event
    @event = Event.new(event_params)
  end
end
